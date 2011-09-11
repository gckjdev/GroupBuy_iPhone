//
//  CategoryTopScoreController.m
//  groupbuy
//
//  Created by  on 11-9-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryTopScoreController.h"
#import "ProductPriceDataLoader.h"


enum TOP_SCORE_TYPE {
    TOP_0_10,
    TOP_10,
    TOP_NEW,
    TOP_DISTANCE
};

@implementation CategoryTopScoreController

@synthesize categoryName;
@synthesize categoryId;
@synthesize belowTenController;
@synthesize aboveTenController;
@synthesize topNewController;
@synthesize distanceController;

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
    [super viewDidLoad];
    
    self.navigationItem.title = self.categoryName;
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"0－10元", @"10元以上", @"发布日期", @"距离远近", nil];
    self.titleSegControl = [[[UISegmentedControl alloc] initWithItems:titleArray] autorelease];
    titleSegControl.segmentedControlStyle = UISegmentedControlStyleBar;
    titleSegControl.selectedSegmentIndex = 0;
    [titleSegControl addTarget:self 
                        action:@selector(clickSegControl:) 
              forControlEvents:UIControlEventValueChanged];
    CGRect frame = self.titleSegControl.frame;
    frame = CGRectMake(31, 10, frame.size.width, frame.size.height);
    self.titleSegControl.frame = frame;
    [self.view addSubview:self.titleSegControl];
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
        ProductTopScoreBelowTenDataLoader *dataLoader = [[[ProductTopScoreBelowTenDataLoader alloc] init] autorelease];
        dataLoader.categoryId = self.categoryId;
        self.belowTenController.dataLoader = dataLoader;
        self.distanceController.type = [titleSegControl titleForSegmentAtIndex:
                                        titleSegControl.selectedSegmentIndex];
        CGRect bounds = self.view.bounds;
        self.belowTenController.view.frame = CGRectMake(0, 50, bounds.size.width, bounds.size.height);        
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
        ProductTopScoreAboveTenDataLoader *dataLoader = [[[ProductTopScoreAboveTenDataLoader alloc] init] autorelease];
        dataLoader.categoryId = self.categoryId;
        self.aboveTenController.dataLoader = dataLoader;
        self.distanceController.type = [titleSegControl titleForSegmentAtIndex:
                                        titleSegControl.selectedSegmentIndex];
        CGRect bounds = self.view.bounds;
        self.aboveTenController.view.frame = CGRectMake(0, 50, bounds.size.width, bounds.size.height);         
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
        ProductStartDateDataLoader *dataLoader = [[[ProductStartDateDataLoader alloc] init] autorelease];
        dataLoader.categoryId = self.categoryId;
        self.topNewController.dataLoader = dataLoader;
        self.distanceController.type = [titleSegControl titleForSegmentAtIndex:
                                        titleSegControl.selectedSegmentIndex];
        CGRect bounds = self.view.bounds;
        self.topNewController.view.frame = CGRectMake(0, 50, bounds.size.width, bounds.size.height);        
        [self.view addSubview:self.topNewController.view];                
    }
    
    [self.view bringSubviewToFront:self.topNewController.view];
    [self.topNewController viewDidAppear:NO];
}

- (void)showProductByDistance
{
    if (self.distanceController == nil){
        self.distanceController = [[[CommonProductListController alloc] init] autorelease];        
        self.distanceController.superController = self;
        ProductDistanceDataLoader *dataLoader = [[[ProductDistanceDataLoader alloc] init] autorelease];
        dataLoader.categoryId = self.categoryId;
        self.distanceController.dataLoader = dataLoader;
        self.distanceController.type = [titleSegControl titleForSegmentAtIndex:
                                        titleSegControl.selectedSegmentIndex];        
        CGRect bounds = self.view.bounds;
        self.distanceController.view.frame = CGRectMake(0, 50, bounds.size.width, bounds.size.height);         
        [self.view addSubview:distanceController.view];                
    }
    
    [self.view bringSubviewToFront:distanceController.view];
    [distanceController viewDidAppear:NO];
    
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
        case TOP_DISTANCE:
            [self showProductByDistance];
            break;
        default:
            break;
    }
}

@end

