//
//  PushKanColleWidgetUserRemoteRepository.m
//  iPushKanColleWidget
//
//  Created by otiai10 on 2014/08/13.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "PushKanColleWidgetUserRemoteRepository.h"
#import "PushKanColleWidgetUserModel.h"

@implementation PushKanColleWidgetUserRemoteRepository

+ (NSString *) buildQuery:(NSString *)username idStr:(NSString *)idStr deviceToken:(NSString *)deviceToken
{
    return [NSString stringWithFormat:@"username=%@&idStr=%@&deviceToken=%@&clientToken=%@",username,idStr,deviceToken,[self clientToken]];
}

+ (NSURL *) url
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [super baseURL], @"user/register"]];
}
+ (NSURL *) urlOfGet:(NSString *)idStr
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@?clientToken=%@", [super baseURL], @"user/", idStr, [super clientToken]]];
}

+ (void) save:(PushKanColleWidgetUserModel *)user completion:(RemoteRepositoryCompletionHandler)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self url]];
    [request setHTTPMethod:@"POST"];
    NSString *params = [self buildQuery:user.name idStr:user.idStr deviceToken:user.deviceToken];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [super sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        block(response, data, connectionError);
    }];
}

+ (void) load:(NSString *)idStr completion:(RemoteRepositoryCompletionHandler)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self urlOfGet:idStr]];
    [request setHTTPMethod:@"GET"];
    [super sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil || [data isEqual:[NSNull null]]) {
            return;
        }
        block(response, data, connectionError);
    }];
}

@end
