//
//  PushKanColleWidgetUserLocalRepository.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/09/07.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetUserLocalRepository.h"
#import "PushKanColleWidgetUserModel.h"

@implementation PushKanColleWidgetUserLocalRepository

+ (BOOL) save:(PushKanColleWidgetUserModel *)user
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:user.name forKey:@"username"];
    [ud setObject:user.idStr forKey:@"idStr"];
    [ud synchronize];
    return YES;
}
+ (PushKanColleWidgetUserModel *) load
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:@"username"];
    NSString *idStr = [ud objectForKey:@"idStr"];
    return [PushKanColleWidgetUserModel create:username idStr:idStr];
}
@end
