//
//  PushKanColleWidgetTwitterAccount.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetTwitterAccount.h"

@implementation PushKanColleWidgetTwitterAccount

- (void) requestAccessToTwitterAccountWithCompletion:(TwitterAccountRequestCompletionBlock)blok
{
    ACAccountType *type = [self accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self requestAccessToAccountsWithType:type options:nil completion:^(BOOL granted, NSError *error) {
        if (! granted || error != nil) {
            return;
        }
        NSArray *accounts = [self accountsWithAccountType:type];
        if (accounts.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iPushKanColleWidget" message:@"デバイスにTwitterアカウントが紐づけられてないっぽい？" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            return;
        }
        ACAccount *account = accounts[0];
        NSString *username = [account username];
        NSString *idStr = [[account valueForKey:@"properties"] objectForKey:@"user_id"];
        blok(username, idStr);
    }];
}
@end
