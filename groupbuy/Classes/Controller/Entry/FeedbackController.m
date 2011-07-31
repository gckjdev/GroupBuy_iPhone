//
//  FeedbackController.m
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import "FeedbackController.h"
#import "groupbuyAppDelegate.h"

@implementation FeedbackController
@synthesize feedbackLabel;
@synthesize feedbackButton;

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
    
    [self setBackgroundImageName:@"background.png"];
    
	feedbackLabel.text = NSLS(@"kFeedbackLabel");
	[feedbackButton setTitle:NSLS(@"kFeedbackButton") forState:UIControlStateNormal];		

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
    [self setFeedbackLabel:nil];
    [self setFeedbackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [feedbackLabel release];
    [feedbackButton release];
    [super dealloc];
}

- (IBAction)clickFeedback:(id)sender
{
    [self sendEmailTo:[NSArray arrayWithObject:@"zz2010.support@gmail.com"] 
		 ccRecipients:nil 
		bccRecipients:nil 
			  subject:NSLS(@"kFeedbackSubject")
				 body:NSLS(@"") 
			   isHTML:NO 
			 delegate:self];
}

- (IBAction)clickSendAppLink:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLS(@"kSendBySMS"), NSLS(@"kSendByEmail"), nil];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (void)handleSendAppLinkClick:(NSInteger)buttonIndex
{
    NSString* appLink = [UIUtils getAppLink:kAppId];
    NSString* body = [NSString stringWithFormat:NSLS(@"kSendAppLinkBody"), appLink];
    NSString* subject = NSLS(@"kSendAppLinkSubject");
    
    enum{
        BUTTON_SEND_BY_SMS,
        BUTTON_SEND_BY_EMAIL,
        BUTTON_CANCEL
    };
    
    switch (buttonIndex) {
        case BUTTON_SEND_BY_SMS:
            [self sendSms:@"" body:body];
            break;
            
        case BUTTON_SEND_BY_EMAIL:
            [self sendEmailTo:nil ccRecipients:nil bccRecipients:nil subject:subject body:body isHTML:NO delegate:self];
            break;
            
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self handleSendAppLinkClick:buttonIndex];
}

@end
