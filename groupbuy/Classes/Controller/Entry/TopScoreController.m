//
//  TopScoreController.m
//  groupbuy
//
//  Created by qqn_pipi on 11-9-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TopScoreController.h"


enum TOP_SCORE_TYPE {
    TOP_0_10,
    TOP_10,
    TOP_NEW,
};

@implementation TopScoreController

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
    [self createNavigationTitleToolbar:
     [NSArray arrayWithObjects:
      @"0－10元排名",
      @"10元以上排名",
      @"发布日期",
      nil]
    defaultSelectIndex:0];    

    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)showTopZeroTen
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self clickSegControl:self.titleSegControl];
    [super viewDidAppear:animated];
}

- (void)clickSegControl:(id)sender
{
    
    UISegmentedControl* segControl = sender;
    
    
    
    switch (segControl.selectedSegmentIndex) {

        case TOP_0_10:
            [self showTopZeroTen];
            break;
            
            
        default:
            break;
    }
}

@end
