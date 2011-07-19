//
//  SeeExamplePostController.h
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"

@class FriendPostExampleManager;

@interface SeeExamplePostController : PPTableViewController {
    
    FriendPostExampleManager    *manager;
}

+ (SeeExamplePostController*)showSeeExamplePostController:(UIViewController*)superController;

@end
