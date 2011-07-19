//
//  NearbyPlaceController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "LocalDataService.h"

@interface NearbyPlaceController : PPTableViewController <LocalDataServiceDelegate> {
 
    UIViewController     *superController;
}

@property (nonatomic, retain) UIViewController     *superController;

@end
