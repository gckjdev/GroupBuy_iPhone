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

enum{
    SELECT_BOY,
    SELECT_GIRL
};

#define DEFAULT_Y                       10

@implementation RegisterController
@synthesize loginPasswordTextField;
@synthesize genderSegControl;
@synthesize genderLabel;
@synthesize gender;

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

    CGRect frame = self.view.frame;
    frame.origin.y = DEFAULT_Y;
    self.view.frame = frame;
        
    [super viewDidLoad];
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
    [super dealloc];
}

- (BOOL)isAlreadyScroll
{
    return (self.view.frame.origin.y < 0);
}

- (IBAction)textFieldDoneEditing:(id)sender {
    
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
    
    UserService* userService = GlobalGetUserService();
    [userService loginUserWithLoginId:loginIdField.text gender:gender viewController:self];     
}

- (IBAction)clickSinaLogin:(id)sender
{
    PlaceSNSService* snsService = GlobalGetSNSService();
    [snsService sinaInitiateLogin:self];
}

- (IBAction)clickQQLogin:(id)sender
{
    PlaceSNSService* snsService = GlobalGetSNSService();
    [snsService qqInitiateLogin:self];
}

- (BOOL)verifyField
{
    if ([self.loginIdField.text length] <= 0){
        [self 
        return NO;
    }
    
    if ([self.loginPasswordTextField.text length] <= 0){
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
    [UserService loginUser:loginIdField.text password:loginPasswordTextField.text];
}

@end
