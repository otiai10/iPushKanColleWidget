//
//  PushKanColleWidgetEventModel.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/23.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushKanColleWidgetEventModel : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *display;
@property (strong, nonatomic) NSString *optional;
@property NSInteger timestamp;

+(PushKanColleWidgetEventModel *)create;
+(PushKanColleWidgetEventModel *)initWithDictionary:(NSDictionary *)dict;

@end
