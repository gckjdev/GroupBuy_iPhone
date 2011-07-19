//
//  AtMePostController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "LocalDataService.h"
#import "PostTableViewCell.h"

@interface AtMePostController : PPTableViewController <LocalDataServiceDelegate, PostTableViewCellDelegate> {
    UIViewController     *superController;
}

@property (nonatomic, retain) UIViewController     *superController;

@end
