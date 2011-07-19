//
//  SinaService.m
//  Dipan
//
//  Created by penglzh on 11-5-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SinaService.h"
#import "OAuthCore.h"


#define sinaAppKey                      @"1528146353"
#define sinaAppSecret                   @"4815b7938e960380395e6ac1fe645a5c"
#define sinaCreateWeiboUrl              @"http://api.t.sina.com.cn/statuses/update.json"

@implementation SinaService

+ (BOOL)createWeiboWith:(NSString *)content accessToken:(NSString *)token tokenSecret:(NSString *)tokenSecret
{
    NSURL *url = [NSURL URLWithString:sinaCreateWeiboUrl];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:content forKey:@"status"];
    NSString *queryString = [OAuthCore queryStringWithUrl:url
                                         method:@"POST"
                                     parameters:dict
                                    consumerKey:sinaAppKey
                                 consumerSecret:sinaAppSecret
                                          token:token
                                    tokenSecret:tokenSecret];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"SinaService create weibo result: %@", result);
    if (200 == [response statusCode] && nil == error) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
