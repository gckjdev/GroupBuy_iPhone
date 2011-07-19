//
//  PrivateMessageControllerUtils.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPViewController;
@class CreatePrivateMessageController;

@interface PrivateMessageControllerUtils : NSObject {
    
}

+ (CreatePrivateMessageController*)showPrivateMessageController:(NSString*)userId 
                        userNickName:(NSString*)nickName
                          userAvatar:(NSString*)avatar
                      viewController:(UIViewController*)superViewController;

@end
