//
//  PushKanColleWidgetUserModel.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/09/05.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetUserModel.h"

@implementation PushKanColleWidgetUserModel

+ (PushKanColleWidgetUserModel *)create:(NSString *)name idStr:(NSString *)idStr
{
    PushKanColleWidgetUserModel *user = [[PushKanColleWidgetUserModel alloc] init];
    user.name = name;
    user.idStr = idStr;
    return user;
}
+ (PushKanColleWidgetUserModel *)createWithDeviceToken:(NSString *)name idStr:(NSString *)idStr deviceToken:(NSString *)deviceToken
{
    PushKanColleWidgetUserModel *user = [[PushKanColleWidgetUserModel alloc] init];
    user.name = name;
    user.idStr = idStr;
    user.deviceToken = deviceToken;
    return user;
}

@end
