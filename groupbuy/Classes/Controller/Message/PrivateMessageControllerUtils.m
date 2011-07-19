//
//  PrivateMessageControllerUtils.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PrivateMessageControllerUtils.h"
#import "CreatePrivateMessageController.h"
#import "PPViewController.h"

@implementation PrivateMessageControllerUtils

+ (CreatePrivateMessageController*)showPrivateMessageController:(NSString*)userId 
                        userNickName:(NSString*)nickName
                          userAvatar:(NSString*)avatar
                      viewController:(UIViewController*)superViewController
{
    CreatePrivateMessageController* controller = [[CreatePrivateMessageController alloc] init];
    controller.messageUserId = userId;
    controller.messageUserNickName = nickName;
    controller.messageUserAvatar = avatar;
    [superViewController.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    return controller;
}

@end
