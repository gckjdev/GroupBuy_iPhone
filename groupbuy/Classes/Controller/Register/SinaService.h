//
//  SinaService.h
//  Dipan
//
//  Created by penglzh on 11-5-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SinaService : NSObject {
}

+ (BOOL)createWeiboWith:(NSString *)content accessToken:(NSString *)token tokenSecret:(NSString *)tokenSecret;

@end