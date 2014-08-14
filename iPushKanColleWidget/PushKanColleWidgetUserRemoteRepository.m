//
//  PushKanColleWidgetUserRemoteRepository.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetUserRemoteRepository.h"

@implementation PushKanColleWidgetUserRemoteRepository

+ (NSString *) buildQuery:(NSString *)username idStr:(NSString *)idStr deviceToken:(NSString *)deviceToken
{
    return [NSString stringWithFormat:@"username=%@&idStr=%@&deviceToken=%@",username,idStr,deviceToken];
}

+ (NSURL *) url
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [super baseURL], @"user/register"]];
}

+ (void) save:(NSString *)username idStr:(NSString *)idStr deviceToken:(NSString *)deviceToken completion:(RemoteRepositoryCompletionHandler)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self url]];
    [request setHTTPMethod:@"POST"];
    NSString *params = [self buildQuery:username idStr:idStr deviceToken:deviceToken];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [super sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        block(response, data, connectionError);
    }];
}

@end
