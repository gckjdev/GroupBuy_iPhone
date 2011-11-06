//
//  RegisterController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-11.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import "RegisterController.h"
#import "groupbuyAppDelegate.h"
#import "PlaceSNSService.h"
#import "StringUtil.h"
#import "GroupBuyUserService.h"
#import "NewUserRegisterController.h"
#import "GroupBuySNSService.h"
#import "MyInfoController.h"
#import "UIImageUtil.h"
#import "GroupBuyControllerExt.h"

enum{
    SELECT_BOY,
    SELECT_GIRL
};

#define DEFAULT_Y                       0

@implementation RegisterController
@synthesize loginPasswordTextField;
@synthesize genderSegControl;
@synthesize genderLabel;
@synthesize gender;

@synthesize accountBackgroundView;
@synthesize loginButton;
@synthesize newAccountButton;
@synthesize loginIdField;
@synthesize token;
@synthesize tokenSecret;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

//    [self setBackgroundImageName:@"background.png"];
    
//    CGRect frame = self.view.frame;
//    frame.origin.y = DEFAULT_Y;
//    self.view.frame = frame;
    
    [self.loginIdField setBackground:[UIImage strectchableImageName:FIRST_CELL_IMAGE]];
    [self.loginPasswordTextField setBackground:[UIImage strectchableImageName:LAST_CELL_IMAGE]];
    [self.accountBackgroundView setImage:[UIImage strectchableTopImageName:@"tu_203.png"]];
    [self.loginButton setBackgroundImage:[UIImage strectchableImageName:@"tu_129.png"] forState:UIControlStateNormal];
    [self.newAccountButton setBackgroundImage:[UIImage strectchableImageName:@"tu_133.png"] forState:UIControlStateNormal];
    [self setGroupBuyNavigationTitle:self.tabBarItem.title];
        
    [super viewDidLoad];
    
    if ([GlobalGetUserService() hasBindAccount]){
        MyInfoController* infoController = [[MyInfoController alloc] init];
        [self.navigationController pushViewController:infoController animated:NO];
        [infoController release];
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setGenderSegControl:nil];
    [self setGenderLabel:nil];
    [self setLoginPasswordTextField:nil];
    [self setLoginButton:nil];
    [self setNewAccountButton:nil];
    [self setAccountBackgroundView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.loginIdField = nil;
}


- (void)dealloc {
    [genderSegControl release];
    [genderLabel release];
    [loginIdField release];
    [token release];
    [tokenSecret release];
    [gender release];
    [loginPasswordTextField release];
    [loginButton release];
    [newAccountButton release];
    [accountBackgroundView release];
    [super dealloc];
}

- (BOOL)isAlreadyScroll
{
    return (self.view.frame.origin.y < 0);
}

- (IBAction)textFieldDoneEditing:(id)sender {
    
    if ([self isAlreadyScroll] == NO){
        return;
    }
    
	[loginIdField resignFirstResponder];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    [self.view.layer addAnimation:animation forKey:@"Reveal"];
    CGRect frame = self.view.frame;
    frame.origin.y = DEFAULT_Y;
    self.view.frame = frame;
}

- (IBAction)textFieldDidBeginEditing:(id)sender
{
    if ([self isAlreadyScroll]){
        return;
    }
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    animation.fillMode = kCAFillModeRemoved;
    [self.view.layer addAnimation:animation forKey:@"Reveal"];
    CGRect frame = self.view.frame;
    frame.origin.y = -165;
    self.view.frame = frame;
}

- (IBAction)textFieldDidEndEditing:(id)sender
{
}

- (IBAction)backgroundTap:(id)sender {
	[loginIdField resignFirstResponder];
}

- (IBAction)clickRegister:(id)sender {
    
//    [self.view endEditing:YES];
    [self textFieldDoneEditing:nil];
    
//    UserService* userService = GlobalGetUserService();
//    [userService registerUser:loginIdField.text password:loginPasswordTextField.text viewController:self];     
    
    [NewUserRegisterController showController:loginIdField.text
                                     password:loginPasswordTextField.text
                              superController:self];
}

- (IBAction)clickSinaLogin:(id)sender
{
    GroupBuySNSService* snsService = GlobalGetGroupBuySNSService();
    [snsService sinaInitiateLogin:self];
}

- (IBAction)clickQQLogin:(id)sender
{
    GroupBuySNSService* snsService = GlobalGetGroupBuySNSService();
    [snsService qqInitiateLogin:self];
}

- (BOOL)verifyField
{
    if ([loginIdField.text length] == 0){
        [UIUtils alert:@"电子邮件地址不能为空"];
        [loginIdField becomeFirstResponder];
        return NO;
    }
    
    if (NSStringIsValidEmail(loginIdField.text) == NO){
        [UIUtils alert:@"输入的电子邮件地址不合法，请重新输入"];
        [loginIdField becomeFirstResponder];
        return NO;        
    }
    
    if ([loginPasswordTextField.text length] == 0){
        [UIUtils alert:@"密码不能为空"];
        [loginPasswordTextField becomeFirstResponder];
        return NO;
    }         
    
    return YES;
}


- (IBAction)clickLogin:(id)sender
{
    if ([self verifyField] == NO){        
        return;
    }
    
    [self.view endEditing:YES];
    [self textFieldDoneEditing:nil];
    
    UserService* userService = GlobalGetUserService();
    [userService loginUserWithEmail:loginIdField.text password:loginPasswordTextField.text viewController:self];
}

- (void)actionDone:(int)resultCode
{
    if (resultCode == 0){
        self.navigationItem.hidesBackButton = YES;
        self.navigationController.navigationItem.hidesBackButton = YES;
        [MyInfoController show:self.navigationController];
    }
}

@end
