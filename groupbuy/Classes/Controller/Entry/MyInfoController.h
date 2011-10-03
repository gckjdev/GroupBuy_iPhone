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

@interface MyInfoController : PPTableViewController <UIActionSheetDelegate> {
    IBOutlet UILabel         *loginIdLabel;
    IBOutlet UILabel         *loginIdTypeLabel;
    IBOutlet UIImageView     *avatarView;           // useless
    IBOutlet UILabel         *nicknameLabel;
    HJManagedImageV *avatarImageView;
    UIButton *logoutButton;
}

@property (nonatomic, retain) IBOutlet UILabel         *loginIdLabel;
@property (nonatomic, retain) IBOutlet UILabel         *loginIdTypeLabel;
@property (nonatomic, retain) IBOutlet UIImageView     *avatarView;
@property (nonatomic, retain) IBOutlet UILabel         *nicknameLabel;
@property (nonatomic, retain) IBOutlet HJManagedImageV *avatarImageView;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;

- (IBAction)clickLogout:(id)sender;
- (IBAction)clickAvatar:(id)sender;

+ (MyInfoController*)show:(UINavigationController*)navgivationController;

@end
