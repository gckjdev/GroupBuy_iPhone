//
//  CreatePrivateMessageController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "UIRectTextView.h"

@interface CreatePrivateMessageController : PPViewController {
    
    UIRectTextView *contentTextView;
    UILabel *userLabel;
    
    NSString *messageUserId;
    NSString *messageUserNickName;
    NSString *messageUserAvatar;
}
@property (nonatomic, retain) IBOutlet UIRectTextView *contentTextView;
@property (nonatomic, retain) IBOutlet UILabel *userLabel;
@property (nonatomic, retain) NSString *messageUserId;
@property (nonatomic, retain) NSString *messageUserNickName;
@property (nonatomic, retain) NSString *messageUserAvatar;


- (IBAction)clickSend:(id)sender;

+ (CreatePrivateMessageController*)showCreatePrivateMessage:(UIViewController*)viewController
                                              messageUserId:(NSString*)messageUserId
                                          messageUserNickName:(NSString*)messageUserNickName
                                          messageUserAvatar:(NSString*)messageUserAvatar;


@end
