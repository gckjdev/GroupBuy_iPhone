//
//  CreatePlaceController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "PlaceLocationController.h"

@interface CreatePlaceController : PPTableViewController {
    
    UITextField             *nameTextField;
    UITextField             *descriptionTextField;
    CLLocationCoordinate2D  location;
    BOOL                    hasLocationData;
    NSString                *defaultPlaceName;
    
    PlaceLocationController *placeController;
}

@property (nonatomic, retain) UITextField             *nameTextField;
@property (nonatomic, retain) UITextField             *descriptionTextField;
@property (nonatomic, assign) CLLocationCoordinate2D  location;
@property (nonatomic, retain) PlaceLocationController *placeController;
@property (nonatomic, retain) NSString                *defaultPlaceName;

- (void)clickSave:(id)sender;

@end
