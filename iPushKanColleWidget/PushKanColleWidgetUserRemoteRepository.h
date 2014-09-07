//
//  PushKanColleWidgetUserRemoteRepository.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushKanColleWidgetRemoteRepository.h"
#import "PushKanColleWidgetUserModel.h"

@interface PushKanColleWidgetUserRemoteRepository : PushKanColleWidgetRemoteRepository

+ (void) save:(PushKanColleWidgetUserModel *)user completion:(RemoteRepositoryCompletionHandler)block;
+ (void) load:(NSString *)idStr completion:(RemoteRepositoryCompletionHandler)block;

@end
