//
//  PushKanColleWidgetRemoteRepository.h
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushKanColleWidgetRemoteRepository : NSURLConnection

typedef void (^RemoteRepositoryCompletionHandler)(NSURLResponse *response, NSData *data, NSError *connectionError);

+(NSString *)baseURL;
+(NSString *)clientToken;

@end
