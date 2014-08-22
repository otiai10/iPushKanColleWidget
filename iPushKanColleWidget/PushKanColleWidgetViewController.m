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
    self.navigationItem.title = [NSString stringWithFormat:@"@%@", username];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
