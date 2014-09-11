//
//  PushKanColleWidgetViewController.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/12.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetViewController.h"
#import "PushKanColleWidgetUserRemoteRepository.h"
#import "PushKanColleWidgetUserLocalRepository.h"
#import "PushKanColleWidgetEventModel.h"
#import "PushKanColleWidgetColorModel.h"
#import "PushKanColleWidgetUserModel.h"
#import "PushKanColleWidgetTwitterAccount.h"

@interface PushKanColleWidgetViewController ()

@end

@implementation PushKanColleWidgetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PushKanColleWidgetTwitterAccount *store = [PushKanColleWidgetTwitterAccount new];
    [store requestAccessToTwitterAccountWithCompletion:^(NSString *username, NSString *idStr){
        self.user = [PushKanColleWidgetUserModel create:username idStr:idStr];
        [PushKanColleWidgetUserLocalRepository save:self.user];
        [self changeTitle:self.user.name];
        
        UIApplication *application = [UIApplication sharedApplication];
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:types];
    }];
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    [rc addTarget:self action:@selector(onPullToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
}

- (void)onPullToRefresh:(UIRefreshControl *) rc
{
    [rc beginRefreshing];
    
    [self loadRemoteEventsToTable:^{
        [rc endRefreshing];
    }];
}

- (void)changeTitle:(NSString *)title
{
    if (! title) {
        title = self.user.name;
    }
    self.navigationItem.title = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (! self.events) {
        return 0;
    }
    return [self.events count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MainCell";
    
    // cellの再利用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    PushKanColleWidgetEventModel *event = [PushKanColleWidgetEventModel initWithDictionary:[self.events objectAtIndex:indexPath.row]];
    
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[event timestamp]];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"HH:mm"];
    NSString *timeDisplay = [f stringFromDate:d];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", timeDisplay, [event display], [event optional]];
    
    return cell;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kind = [[self.events objectAtIndex:indexPath.row] objectForKey:@"Kind"];
    cell.backgroundColor = [PushKanColleWidgetColorModel initByKind:kind];
}

- (void)loadRemoteEventsToTable:(ReloadCompletionHandler)block
{
    NSLog(@"Fired!!");

    // {{{ 以下のコードだと、初期読み込みでもちゃんとidStrが取れる
    PushKanColleWidgetUserModel *user = [PushKanColleWidgetUserLocalRepository load];
    NSString *idStr = user.idStr;
    // }}}

    // idStrが初期読み込みでちゃんと来るとループするので、初期読み込みでは取れない方法をここでは行う
    idStr = self.user.idStr;

    if (! idStr) {
        if (block) {
            block();
        }
        return;
    }
    [PushKanColleWidgetUserRemoteRepository load:idStr completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            if (block != nil) {
                block();
            }
            return [self showErrorAlert:[connectionError code] message:@"サーバが忙しいっぽい"];
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        int code = [[dict objectForKey:@"code"] intValue];
        if (code != 1000) {
            if (block != nil) {
                block();
            }
            return [self showErrorAlert:code message:[dict objectForKey:@"message"]];
        }
        NSDictionary *user = [dict objectForKey:@"user"];
        self.events = [user objectForKey:@"Events"];
        if (! self.events || [self.events isEqual:[NSNull null]]) {
            self.events = nil;
        }
        [self.tableView reloadData];
        if (block != nil) {
            block();
        }
    }];
}

- (void)showErrorAlert:(int) code message:(NSString *)message
{
    NSString *mess = [NSString stringWithFormat:@"code: %ld\nmessage: %@", (long)code, message];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"艦これウィジェットの通知するやつ" message:mess delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [av show];
}

@end
