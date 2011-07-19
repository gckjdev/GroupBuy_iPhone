//
//  NewMakeFriendPostMainController.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NewMakeFriendPostMainController.h"
#import "SelectPostPhotoController.h"
#import "SeeExamplePostController.h"
#import "HelpWritePostController.h"
#import "PostService.h"

#import "groupbuyAppDelegate.h"

#define MIN_CONTENT_LEN 20
#define MAX_CONTENT_LEN 140


@implementation NewMakeFriendPostMainController
@synthesize newPostLabel;
@synthesize postContentTextView;
@synthesize referButton;
@synthesize helpButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateTitle
{
    int len = [self.postContentTextView.text length];
    self.navigationItem.title = [NSString stringWithFormat:@"%@(%d/%d)", NSLS(@"kNewPostTitle"), len, MAX_CONTENT_LEN];
}

- (void)dealloc
{
    [newPostLabel release];
    [postContentTextView release];
    [referButton release];
    [helpButton release];
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
//    [self setNavigationRightButton:NSLS(@"Next") action:@selector(clickNext:)];
    [self updateTitle];
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    groupbuyAppDelegate* appDelegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([appDelegate hasDataForRegistration]){        
        self.postContentTextView.text = [appDelegate dataForRegistration];
        [self popupHappyMessage:NSLS(@"kTipsNext") title:nil];
    }    
}

- (void)viewDidUnload
{
    [self setNewPostLabel:nil];
    [self setPostContentTextView:nil];
    [self setReferButton:nil];
    [self setHelpButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)clickNext:(id)sender
{
    // save data
    if ([postContentTextView.text length] < MIN_CONTENT_LEN){
        [self popupHappyMessage:NSLS(@"kContentLessThan20") title:nil];
        return;
    }
    else if ([postContentTextView.text length] > MAX_CONTENT_LEN){
        [self popupHappyMessage:NSLS(@"kContentExceed140") title:nil];        
        return;
    }
    PostService* postService = GlobalGetPostService();
    [postService setPostTextContent:postContentTextView.text];
    
    // next step
    [SelectPostPhotoController showSelectPostPhotoController:self];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateTitle];
}

- (IBAction)clickReferButton:(id)sender
{
    [postContentTextView resignFirstResponder];
    [SeeExamplePostController showSeeExamplePostController:self];
}

- (IBAction)clickHelpButton:(id)sender
{
    [postContentTextView resignFirstResponder];
    [HelpWritePostController showHelpWritePostController:self];
}

- (void)clickCancel:(id)sender
{
    [self.postContentTextView resignFirstResponder];
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)helpWritePostDone:(NSString*)text
{
    self.postContentTextView.text = text;
}

- (void)keyboardDidShowWithRect:(CGRect)keyboardRect
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromTop];
//    animation.fillMode = kCAFillModeRemoved;
    [self.view.layer addAnimation:animation forKey:@"Reveal"];
    CGRect frame = self.view.frame;
    frame.origin.y = -47;
    self.view.frame = frame;
    
    [self setNavigationLeftButton:NSLS(@"Cancel") action:@selector(clickCancel:)];        
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromBottom];
    [self.view.layer addAnimation:animation forKey:@"Reveal"];
    
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
        
    self.navigationItem.leftBarButtonItem = nil;
}


@end
