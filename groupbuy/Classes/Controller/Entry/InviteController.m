//
//  InviteController.m
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import "InviteController.h"
#import "groupbuyAppDelegate.h"
#import "PlaceSNSService.h"
#import "TextEditorViewController.h"
enum{
    ACTION_SEND_APPLINK,
    ACTION_SNS_LIKE
};

@implementation InviteController
@synthesize sendAppLinkLabel;
@synthesize sendAppLinkButton;
@synthesize snsLikeLabel;
@synthesize snsLikeButton;

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
    
    // TODO GUI localization
    
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
    [self setSendAppLinkLabel:nil];
    [self setSendAppLinkButton:nil];
    [self setSnsLikeLabel:nil];
    [self setSnsLikeButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [sendAppLinkLabel release];
    [sendAppLinkButton release];
    [snsLikeLabel release];
    [snsLikeButton release];
    [super dealloc];
}

- (IBAction)clickSendAppLink:(id)sender
{
    currentAction = ACTION_SEND_APPLINK;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLS(@"kSendBySMS"), NSLS(@"kSendByEmail"), nil];

    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (IBAction)clickSNSLike:(id)sender
{
    currentAction = ACTION_SNS_LIKE;
    
    UserService *userService = GlobalGetUserService();
    if ([userService hasBindSNS]){
        // go to write text directly
        TextEditorViewController* postController = [[TextEditorViewController alloc] init];
        postController.hasSendButton = YES;
        postController.delegate = self;        
        [self.navigationController pushViewController:postController animated:YES];
        [postController release];
    }
    else{
        // require user to select an SNS network to login
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLS(@"kBindSina"), NSLS(@"kBindQQ"), NSLS(@"kBindRenren"), nil];
        
        [actionSheet showFromTabBar:self.tabBarController.tabBar];
        [actionSheet release];
    }
}




- (void)clickSend:(NSString*)text
{
    // sync post to SNS
    PlaceSNSService* snsService = GlobalGetSNSService();
    [snsService syncWeiboToAllSNS:text viewController:self];
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)handleSNSLikeClick:(NSInteger)buttonIndex
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (currentAction) {
        case ACTION_SEND_APPLINK:
            [self handleSendAppLinkClick:buttonIndex];
            break;
            
        case ACTION_SNS_LIKE:
            [self handleSNSLikeClick:buttonIndex];
            
        default:
            break;
    }

}





@end
