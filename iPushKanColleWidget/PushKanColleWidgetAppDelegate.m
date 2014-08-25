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

@import Accounts;

@implementation PushKanColleWidgetAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    PushKanColleWidgetTwitterAccount *store = [PushKanColleWidgetTwitterAccount new];
    [store requestAccessToTwitterAccountWithCompletion:^(NSString *username, NSString *idStr){
        // If implement requesting here in AppDelegate, username and idStr should be app property
        self.username = username;
        self.idStr = idStr;
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge;
        [application registerForRemoteNotificationTypes:types];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:self.username forKey:@"username"];
        [ud setObject:self.idStr forKey:@"idStr"];
        [ud synchronize];
    }];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self registerUserInfoToPushServer];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if (DEBUG) {
        self.deviceToken = @"324175ddc7f8ba3944f60cb88b30b955b6d215570e59b5088a531580742b66e6";
        [self registerUserInfoToPushServer];
    }
}

- (void)registerUserInfoToPushServer
{
    [PushKanColleWidgetUserRemoteRepository save:self.username idStr:self.idStr deviceToken:self.deviceToken completion:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (connectionError != nil) {
            NSLog(@"CONNECTION ERROR %@", connectionError);
        }
    }];
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

@end
