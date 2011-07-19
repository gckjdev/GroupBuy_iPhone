//
//  SelectPlaceController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"

@class Place;

@protocol SelectPlaceControllerDelegate <NSObject>

- (void)selectPlace:(Place*)place;

@end

@interface SelectPlaceController : PPTableViewController {
    Place*      place;  // input place
    id<SelectPlaceControllerDelegate> delegate;
}

@property (nonatomic, retain) Place*      place;
@property (nonatomic, assign) id<SelectPlaceControllerDelegate> delegate;

+ (SelectPlaceController*)gotoSelectPlaceController:(PPViewController<SelectPlaceControllerDelegate>*)viewController defaultPlace:(Place*)defaultPlace;


@end
