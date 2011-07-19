//
//  CreatePrivateMessageController.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CreatePrivateMessageController.h"
#import "MessageService.h"

@implementation CreatePrivateMessageController
@synthesize contentTextView;
@synthesize userLabel;
@synthesize messageUserId;
@synthesize messageUserNickName;
@synthesize messageUserAvatar;

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
    [contentTextView release];
    [userLabel release];
    [messageUserId release];
    [messageUserAvatar release];
    [messageUserNickName release];
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
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    [self setNavigationRightButton:NSLS(@"Send") action:@selector(clickSend:)];
    
    self.navigationItem.title = NSLS(@"kSendPrivateMessage");
    if ([messageUserNickName length] > 0){
        self.userLabel.text = [NSString stringWithFormat:@"%@%@", NSLS(@"kSendTo"), messageUserNickName];    
    }
    else{
        self.userLabel.text = [NSString stringWithFormat:@"%@%@", NSLS(@"kSendTo"), messageUserId];    
    }
        
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.contentTextView becomeFirstResponder];

}

- (void)viewDidUnload
{
    [self setContentTextView:nil];
    [self setUserLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickSend:(id)sender
{
    if ([contentTextView.text length] <= 0){
        [self popupUnhappyMessage:NSLS(@"kNoContentInMessage") title:@""];
        return;
    }
    
    MessageService* messageService = GlobalGetMessageService();
    [messageService sendMessage:self toUserId:self.messageUserId textContent:contentTextView.text];
}

+ (CreatePrivateMessageController*)showCreatePrivateMessage:(UIViewController*)viewController
                                              messageUserId:(NSString*)messageUserId
                                        messageUserNickName:(NSString*)messageUserNickName
                                          messageUserAvatar:(NSString*)messageUserAvatar
{
    return nil;
}

     
@end
