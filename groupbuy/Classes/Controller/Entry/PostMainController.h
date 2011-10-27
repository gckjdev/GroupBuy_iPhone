//
//  PostMainController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"

@class CommonProductListController;
@class ProductCategoryController;

@interface PostMainController : PPViewController {
    
    CommonProductListController *priceController;
    CommonProductListController *rebateController;
    CommonProductListController *boughtController;
    CommonProductListController *distanceController;
    ProductCategoryController *categoryController;
    ProductCategoryController *todayController;
    
}

@property (nonatomic, retain) CommonProductListController *priceController;
@property (nonatomic, retain) CommonProductListController *rebateController;
@property (nonatomic, retain) CommonProductListController *boughtController;
@property (nonatomic, retain) CommonProductListController *distanceController;
@property (nonatomic, retain) ProductCategoryController *categoryController;
@property (nonatomic, retain) ProductCategoryController *todayController;

- (void)clickSegControl:(id)sender;

@end
