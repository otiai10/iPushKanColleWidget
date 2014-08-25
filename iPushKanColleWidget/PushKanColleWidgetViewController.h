//
//  PushKanColleWidgetViewController.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/12.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushKanColleWidgetViewController : UITableViewController

@property (strong, atomic) NSArray *events;
- (void)showErrorAlert:(int)code message:(NSString *)message;

@end
