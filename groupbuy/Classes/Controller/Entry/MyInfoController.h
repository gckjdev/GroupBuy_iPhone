//
//  MyInfoController.h
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "HJManagedImageV.h"
#import "PasswordInputController.h"
#import "CityPickerViewController.h"

@interface MyInfoController : PPTableViewController <UIActionSheetDelegate, PasswordInputControllerDelegate, CityPickerDelegate> {
    IBOutlet UILabel         *loginIdLabel;
    IBOutlet UILabel         *loginIdTypeLabel;
    IBOutlet UIImageView     *avatarView;           // useless
    IBOutlet UILabel         *nicknameLabel;
    HJManagedImageV *avatarImageView;
    UIButton *logoutButton;
    
    int action;
}

@property (nonatomic, retain) IBOutlet UILabel         *loginIdLabel;
@property (nonatomic, retain) IBOutlet UILabel         *loginIdTypeLabel;
@property (nonatomic, retain) IBOutlet UIImageView     *avatarView;
@property (retain, nonatomic) IBOutlet UIImageView *topBackgroundImageView;
@property (nonatomic, retain) IBOutlet UILabel         *nicknameLabel;
@property (nonatomic, retain) IBOutlet HJManagedImageV *avatarImageView;
@property (retain, nonatomic) IBOutlet UIImageView *tableBackgroundImageView;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;

- (IBAction)clickLogout:(id)sender;
- (IBAction)clickAvatar:(id)sender;

+ (MyInfoController*)show:(UINavigationController*)navgivationController;

- (IBAction)clickFeedback:(id)sender;
- (IBAction)clickSendAppLink:(id)sender;

@end
