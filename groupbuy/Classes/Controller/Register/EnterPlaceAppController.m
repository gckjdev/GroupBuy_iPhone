//
//  EnterPlaceAppController.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EnterPlaceAppController.h"


@implementation EnterPlaceAppController
@synthesize placeNameTextField;
@synthesize createPlaceButton;
@synthesize registerButton;
@synthesize registerTitleLabel;
@synthesize createPlaceTitleLabel;
@synthesize appDescLabel;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [placeNameTextField release];
    [createPlaceButton release];
    [registerButton release];
    [registerTitleLabel release];
    [createPlaceTitleLabel release];
    [appDescLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPlaceNameTextField:nil];
    [self setCreatePlaceButton:nil];
    [self setRegisterButton:nil];
    [self setRegisterTitleLabel:nil];
    [self setCreatePlaceTitleLabel:nil];
    [self setAppDescLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickRegiser:(id)sender
{
    if (delegate != nil && [delegate respondsToSelector:@selector(doRegisterWithPlaceName:)]){
        [delegate doRegisterWithPlaceName:nil];
    }
}

- (IBAction)clickCreatePlace:(id)sender
{
    if ([placeNameTextField.text length] == 0){
        [UIUtils alert:NSLS(@"kPlaceNameEmpty")];
        return;
    }
    
    if (delegate != nil && [delegate respondsToSelector:@selector(doRegisterWithPlaceName:)]){
        [delegate doRegisterWithPlaceName:placeNameTextField.text];
    }    
}

- (NSString*)placeNameForRegistration
{
    return placeNameTextField.text;
}

@end
