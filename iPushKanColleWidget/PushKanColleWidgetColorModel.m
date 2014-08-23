//
//  PushKanColleWidgetColorModel.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/23.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetColorModel.h"

@implementation PushKanColleWidgetColorModel

+(UIColor *) ofMission
{
    return [UIColor colorWithRed:0.95 green:1.0 blue:0.95 alpha:1.0];
}
+(UIColor *) ofNyukyo
{
    return [UIColor colorWithRed:0.95 green:0.95 blue:1.0 alpha:1.0];
}
+(UIColor *) ofCreateship
{
    return [UIColor colorWithRed:1.0 green:0.95 blue:0.95 alpha:1.0];
}
+(UIColor *) initByKind:(NSString *)kind
{
    if ([kind isEqualToString:@"mission-finish"]) {
        return [self ofMission];
    }
    if ([kind isEqualToString:@"nyukyo-finish"]) {
        return [self ofNyukyo];
    }
    if ([kind isEqualToString:@"createship-finish"]) {
        return [self ofCreateship];
    }
    return [self whiteColor];
}

@end
