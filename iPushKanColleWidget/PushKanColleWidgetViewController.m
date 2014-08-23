//
//  PushKanColleWidgetViewController.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/12.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetViewController.h"
#import "PushKanColleWidgetUserRemoteRepository.h"
#import "PushKanColleWidgetEventModel.h"

@interface PushKanColleWidgetViewController ()

@end

@implementation PushKanColleWidgetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud stringForKey:@"username"];
    
    // ナビゲーションバーのところに名前出す
    self.navigationItem.title = [NSString stringWithFormat:@"%@", username];
    
    [self loadRemoteEventsToTable];
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    [rc addTarget:self action:@selector(onPullToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
}

- (void)onPullToRefresh:(UIRefreshControl *) rc
{
    [rc beginRefreshing];
    
    [self loadRemoteEventsToTable];
    
    [rc endRefreshing];
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
    if ([kind isEqualToString:@"mission-finish"]) {
        cell.backgroundColor = [UIColor colorWithRed:0.95 green:1.0 blue:0.95 alpha:1.0];
    } else if ([kind isEqualToString:@"nyukyo-finish"]) {
        cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:1.0 alpha:1.0];
    } else if ([kind isEqualToString:@"createship-finish"]) {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.95 alpha:1.0];
    }
}

- (void)loadRemoteEventsToTable
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *idStr = [ud stringForKey:@"idStr"];
    
    if (! idStr) {
        return;
    }
    
    [PushKanColleWidgetUserRemoteRepository load:idStr completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *user = [dict objectForKey:@"user"];
        self.events = [user objectForKey:@"Events"];
        if (! self.events || [self.events isEqual:[NSNull null]]) {
            self.events = nil;
        }
        [self.tableView reloadData];
    }];
}

@end
