//
//  TopScoreController.h
//  groupbuy
//
//  Created by qqn_pipi on 11-9-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "CommonProductListController.h"

@interface TopScoreController : PPViewController {
    CommonProductListController *belowTenController;
    CommonProductListController *aboveTenController;
    CommonProductListController *topNewController;
    CommonProductListController *distanceController;
}

@property (nonatomic, retain) CommonProductListController *belowTenController;
@property (nonatomic, retain) CommonProductListController *aboveTenController;
@property (nonatomic, retain) CommonProductListController *topNewController;
@property (nonatomic, retain) CommonProductListController *distanceController;

- (void)clickSegControl:(id)sender;

@end
