//
//  PushKanColleWidgetRemoteRepository.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetRemoteRepository.h"

@implementation PushKanColleWidgetRemoteRepository

+ (NSString *) baseURL
{
    if (DEBUG) {
        return @"http://localhost:9000/";
    }
    return @"http://localhost:9000/";
}

@end
