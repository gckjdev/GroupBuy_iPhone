//
//  DistanceController.m
//  groupbuy
//
//  Created by haodong qiu on 12年1月15日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "DistanceController.h"
#import "ProductPriceDataLoader.h"

@implementation DistanceController

@synthesize distanceController;


- (void)dealloc
{
    [distanceController release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [self setBackgroundImageName:@"background.png"];
    [self setGroupBuyNavigationTitle:self.tabBarItem.title];
    
    [super viewDidLoad];
        
    if (self.distanceController == nil){
        self.distanceController = [[[CommonProductListController alloc] init] autorelease];        
        self.distanceController.superController = self;
        ProductDistanceDataLoader *dataLoader = [[[ProductDistanceDataLoader alloc] init] autorelease];
        
        self.distanceController.dataLoader = dataLoader;
        self.distanceController.type = [titlePPSegControl titleForSegmentAtIndex:
                                        [titlePPSegControl selectedSegmentIndex]];        
        CGRect bounds = self.view.bounds;
        self.distanceController.view.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);         
        [self.view addSubview:distanceController.view];                
    }
    
    
    [distanceController viewDidAppear:NO];
    
}

- (void)viewDidUnload
{
    self.distanceController = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
