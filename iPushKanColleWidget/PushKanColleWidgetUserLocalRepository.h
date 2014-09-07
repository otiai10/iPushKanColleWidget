//
//  PushKanColleWidgetUserLocalRepository.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/09/07.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushKanColleWidgetUserModel.h"

@interface PushKanColleWidgetUserLocalRepository : NSUserDefaults

+ (BOOL) save:(PushKanColleWidgetUserModel *)user;
+ (PushKanColleWidgetUserModel *) load;

@end