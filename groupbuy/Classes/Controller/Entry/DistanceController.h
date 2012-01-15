//
//  DistanceController.h
//  groupbuy
//
//  Created by haodong qiu on 12年1月15日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "CommonProductListController.h"

@interface DistanceController : PPViewController{
    CommonProductListController *distanceController;
}

@property (nonatomic, retain) CommonProductListController *distanceController;

@end
