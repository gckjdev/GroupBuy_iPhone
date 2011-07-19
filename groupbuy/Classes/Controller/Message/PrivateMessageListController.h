//
//  PrivateMessageListController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "MessageService.h"

@interface PrivateMessageListController : PPTableViewController <MessageServiceDelegate>     {
    
    UIViewController     *superController;
    NSString             *messageUserId;
    NSString             *messageUserNickName;
}

@property (nonatomic, retain) UIViewController     *superController;
@property (nonatomic, retain) NSString             *messageUserId;
@property (nonatomic, retain) NSString             *messageUserNickName;

@end




