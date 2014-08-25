//
//  PushKanColleWidgetInfoViewController.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/26.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetInfoViewController.h"

@interface PushKanColleWidgetInfoViewController ()

@end

@implementation PushKanColleWidgetInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onRoonyanTwitterLinkTouched:(id)sender {
    [self openBrowser:@"https://twitter.com/roonyan"];
}
- (IBAction)onRoonyanBlogLinkTouched:(id)sender {
    [self openBrowser:@"http://blog.roomania.biz"];
}
- (IBAction)onOtiai10TwitterLinkTouched:(id)sender {
    [self openBrowser:@"https://twitter.com/otiai10"];
}
- (void)openBrowser:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
