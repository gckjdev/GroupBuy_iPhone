//
//  EnterPlaceAppController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"

@protocol EnterPlaceAppDelegate <NSObject>

- (void)doRegisterWithPlaceName:(NSString*)placeName;

@end

@interface EnterPlaceAppController : PPViewController {
    
    UITextField *placeNameTextField;
    UIButton *createPlaceButton;
    UIButton *registerButton;
    UILabel *registerTitleLabel;
    UILabel *createPlaceTitleLabel;
    UILabel *appDescLabel;
    
    id<EnterPlaceAppDelegate> delegate;
}
@property (nonatomic, retain) IBOutlet UITextField *placeNameTextField;
@property (nonatomic, retain) IBOutlet UIButton *createPlaceButton;
@property (nonatomic, retain) IBOutlet UIButton *registerButton;
@property (nonatomic, retain) IBOutlet UILabel *registerTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *createPlaceTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *appDescLabel;
@property (nonatomic, assign) id<EnterPlaceAppDelegate> delegate;

- (IBAction)clickRegiser:(id)sender;
- (IBAction)clickCreatePlace:(id)sender;

- (NSString*)placeNameForRegistration;

@end
