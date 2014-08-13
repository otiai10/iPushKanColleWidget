//
//  PushKanColleWidgetAppDelegate.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/12.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushKanColleWidgetAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, atomic) NSString *username;
@property (strong, atomic) NSString *idStr;
@property (strong, atomic) NSString *deviceToken;

@end
