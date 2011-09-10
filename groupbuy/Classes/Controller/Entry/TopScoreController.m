//
//  TopScoreController.m
//  groupbuy
//
//  Created by qqn_pipi on 11-9-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TopScoreController.h"
#import "ProductPriceDataLoader.h"


enum TOP_SCORE_TYPE {
    TOP_0_10,
    TOP_10,
    TOP_NEW,
};

@implementation TopScoreController

@synthesize belowTenController;
@synthesize aboveTenController;
@synthesize topNewController;

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
    self.belowTenController = nil;
    self.aboveTenController = nil;
    self.topNewController = nil;
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
    self.belowTenController = nil;
    self.aboveTenController = nil;
    self.topNewController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)showTopZeroTen
{
    if (self.belowTenController == nil){
        self.belowTenController = [[[CommonProductListController alloc] init] autorelease];        
        self.belowTenController.superController = self;
        self.belowTenController.dataLoader = [[[ProductTopScoreBelowTenDataLoader alloc] init] autorelease];
        self.belowTenController.view.frame = self.view.bounds;        
        [self.view addSubview:self.belowTenController.view];                
    }
    
    [self.view bringSubviewToFront:self.belowTenController.view];
    [self.belowTenController viewDidAppear:NO];
}

- (void)showTopTen
{
    if (self.aboveTenController == nil){
        self.aboveTenController = [[[CommonProductListController alloc] init] autorelease];        
        self.aboveTenController.superController = self;
        self.aboveTenController.dataLoader = [[[ProductTopScoreAboveTenDataLoader alloc] init] autorelease];
        self.aboveTenController.view.frame = self.view.bounds;        
        [self.view addSubview:self.aboveTenController.view];                
    }
    
    [self.view bringSubviewToFront:self.aboveTenController.view];
    [self.aboveTenController viewDidAppear:NO];
}

- (void)showTopNew
{
    if (self.topNewController == nil){
        self.topNewController = [[[CommonProductListController alloc] init] autorelease];        
        self.topNewController.superController = self;
        self.topNewController.dataLoader = [[[ProductStartDateDataLoader alloc] init] autorelease];
        self.topNewController.view.frame = self.view.bounds;        
        [self.view addSubview:self.topNewController.view];                
    }
    
    [self.view bringSubviewToFront:self.topNewController.view];
    [self.topNewController viewDidAppear:NO];
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
        case TOP_10:
            [self showTopTen];
            break;
        case TOP_NEW:
            [self showTopNew];
            break;
        default:
            break;
    }
}

@end
