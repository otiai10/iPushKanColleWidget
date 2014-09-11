//
//  PushKanColleWidgetAppDelegate.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/12.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetAppDelegate.h"
#import "PushKanColleWidgetTwitterAccount.h"
#import "PushKanColleWidgetUserRemoteRepository.h"
#import "PushKanColleWidgetUserLocalRepository.h"
#import "PushKanColleWidgetViewController.h"

@import Accounts;

@implementation PushKanColleWidgetAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (DEBUG) {
        [self clearUserDefaults];
    }
    return YES;
}

- (void)clearUserDefaults
{
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:bundleId];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    PushKanColleWidgetUserModel *user = [PushKanColleWidgetUserLocalRepository load];
    user.deviceToken = self.deviceToken;
    [PushKanColleWidgetUserRemoteRepository save:user completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            // TODO: showAlert
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
        int code = [[dict objectForKey:@"code"] intValue];
        if (code != 1000) {
            [self showAlert:[dict objectForKey:@"message"]];
            return;
        }
        // 謎ループするので初期読み込みはしない
        // [self refreshTable];
        return;
    }];
}

- (void)refreshTable
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PushKanColleWidgetViewController *vc = [sb instantiateViewControllerWithIdentifier:@"main"];
    [vc loadRemoteEventsToTable:nil];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) showAlert:(NSString *)message
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"艦これウィジェットの通知するやつのエラーです" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [av show];
}

@end