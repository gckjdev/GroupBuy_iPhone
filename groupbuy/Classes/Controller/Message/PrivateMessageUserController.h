//
//  PrivateMessageUserController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "PPViewController.h"
#import "MessageService.h"

@interface PrivateMessageUserController : PPTableViewController <MessageServiceDelegate> {
    PPViewController    *superController;
}

@property (nonatomic, retain) PPViewController    *superController;

@end
