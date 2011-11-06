//
//  RegisterController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-11.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "GroupBuyUserService.h"

@interface RegisterController : PPViewController <GroupBuyUserServiceDelegate> {
    UITextField *loginIdField;
    NSString *token;
    NSString *tokenSecret;
    UISegmentedControl *genderSegControl;
    UILabel *genderLabel;
    
    NSString *gender;
    UITextField *loginPasswordTextField;
}

@property (retain, nonatomic) IBOutlet UIImageView *accountBackgroundView;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UIButton *newAccountButton;

@property (nonatomic, retain) IBOutlet UITextField *loginIdField;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *tokenSecret;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)textFieldDidBeginEditing:(id)sender;
- (IBAction)textFieldDidEndEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)clickRegister:(id)sender;
- (IBAction)clickSinaLogin:(id)sender;
- (IBAction)clickQQLogin:(id)sender;
- (IBAction)clickLogin:(id)sender;

- (BOOL)verifyField;

@property (nonatomic, retain) IBOutlet UISegmentedControl *genderSegControl;
@property (nonatomic, retain) IBOutlet UILabel *genderLabel;
@property (nonatomic, retain) NSString *gender;

@property (nonatomic, retain) IBOutlet UITextField *loginPasswordTextField;

@end


