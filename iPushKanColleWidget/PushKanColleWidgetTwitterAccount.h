//
//  PushKanColleWidgetTwitterAccount.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Accounts/Accounts.h>

@interface PushKanColleWidgetTwitterAccount : ACAccountStore

typedef void (^TwitterAccountRequestCompletionBlock)(NSString* username, NSString *idStr);

- (void) requestAccessToTwitterAccountWithCompletion:(TwitterAccountRequestCompletionBlock)block;

@end
