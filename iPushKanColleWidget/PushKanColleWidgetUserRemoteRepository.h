//
//  PushKanColleWidgetUserRemoteRepository.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushKanColleWidgetRemoteRepository.h"

@interface PushKanColleWidgetUserRemoteRepository : PushKanColleWidgetRemoteRepository

+ (void) save:(NSString *)username idStr:(NSString *)idStr deviceToken:(NSString *)deviceToken completion:(RemoteRepositoryCompletionHandler)block;
+ (NSURL *) url;

@end
