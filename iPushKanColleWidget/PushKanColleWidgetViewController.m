//
//  PushKanColleWidgetViewController.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/12.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetViewController.h"

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
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    [rc addTarget:self action:@selector(onPullToRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
}

- (void)onPullToRefresh:(UIRefreshControl *) rc
{
    [rc beginRefreshing];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"iPushKanColleWidget" message:@"REFRESHED" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [av show];
    
    [rc endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MainCell";
    
    // cellの再利用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"FOOOO";
    
    return cell;
}

@end
