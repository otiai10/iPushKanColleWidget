//
//  PushKanColleWidgetUserModel.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/09/05.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushKanColleWidgetUserModel : NSObject

@property (strong, atomic) NSString *name;
@property (strong, atomic) NSString *idStr;
- (PushKanColleWidgetUserModel *)create:(NSString *)name idStr:(NSString *)idStr;

@end
