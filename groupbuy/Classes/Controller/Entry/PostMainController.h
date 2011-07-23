//
//  PostMainController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "NearbyPostController.h"
#import "FollowPostController.h"
#import "PrivateMessageListController.h"
#import "AtMePostController.h"

@class PrivateMessageUserController;
@class PublicTimelinePostController;
@class CommonProductListController;

@interface PostMainController : PPViewController {
    NearbyPostController    *nearbyPostController;
    FollowPostController    *followPostController;
    AtMePostController      *atMePostController;
    PrivateMessageUserController *privateMessageController;
    PublicTimelinePostController *latestPostController;
    
    CommonProductListController *priceController;
}

@property (nonatomic, retain) NearbyPostController    *nearbyPostController;
@property (nonatomic, retain) FollowPostController    *followPostController;
@property (nonatomic, retain) PrivateMessageUserController *privateMessageController;
@property (nonatomic, retain) AtMePostController      *atMePostController;
@property (nonatomic, retain) PublicTimelinePostController *latestPostController;

@property (nonatomic, retain) CommonProductListController *priceController;

@end
