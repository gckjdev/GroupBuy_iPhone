//
//  InviteController.h
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "CityPickerViewController.h"
@interface InviteController : PPViewController <UIActionSheetDelegate> {

    UILabel *sendAppLinkLabel;
    UIButton *sendAppLinkButton;
    UILabel *snsLikeLabel;
    UIButton *snsLikeButton;
    UIButton *cityPickerButton;
    int currentAction;
}
@property (nonatomic, retain) IBOutlet UILabel *sendAppLinkLabel;
@property (nonatomic, retain) IBOutlet UIButton *sendAppLinkButton;
@property (nonatomic, retain) IBOutlet UILabel *snsLikeLabel;
@property (nonatomic, retain) IBOutlet UIButton *snsLikeButton;

@property (nonatomic, retain) IBOutlet UIButton *cityPickerButton;

- (IBAction)clickSendAppLink:(id)sender;
- (IBAction)clickSNSLike:(id)sender;

- (IBAction)clickCityPicker;

@end
