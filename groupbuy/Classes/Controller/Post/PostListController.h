//
//  PostListController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "Place.h"
#import "LocalDataService.h"
#import "PlaceTableViewCell.h"
#import "PostTableViewCell.h"


@interface PostListController : PPTableViewController <LocalDataServiceDelegate, PlaceTableViewCellDelegate, PostTableViewCellDelegate> {
    
    Place                           *place;
    IBOutlet PlaceTableViewCell     *placeCell;
}

@property (nonatomic, retain) Place       *place;

- (IBAction)clickFollow:(id)sender;
- (IBAction)clickUnFollow:(id)sender;

- (void)clickActionButton:(id)sender atRow:(NSUInteger)row;

@end
