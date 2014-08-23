//
//  PushKanColleWidgetEventModel.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/23.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetEventModel.h"

@implementation PushKanColleWidgetEventModel

+(PushKanColleWidgetEventModel *)create
{
    return [PushKanColleWidgetEventModel init];
}

+(PushKanColleWidgetEventModel *)initWithDictionary:(NSDictionary *)dict
{
    PushKanColleWidgetEventModel *event = [[PushKanColleWidgetEventModel alloc] init];
    event.message = [dict objectForKey:@"Message"];
    event.timestamp = [[dict objectForKey:@"Finish"] integerValue];
    
    event.display = [NSString stringWithFormat:@"%@%@%@ %@", [dict objectForKey:@"Prefix"], [dict objectForKey:@"Identifier"], [dict objectForKey:@"Unit"], [dict objectForKey:@"Label"]];
    
    // TODO: separate
    if ([[dict objectForKey:@"Kind"]  isEqual: @"mission-finish"]) {
        NSArray *arr = [dict objectForKey:@"OptionalStrings"];
        if (arr && ! [arr isEqual:[NSNull null]] && [arr count] > 1) {
            event.optional = arr[1];
        } else {
            event.optional = @"";
        }
    }
    
    return event;
}

@end
