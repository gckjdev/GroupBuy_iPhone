//
//  PlaceLocationController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaceLocationController.h"
#import "CreatePlaceController.h"
#import "MapViewUtil.h"

@implementation PlaceLocationController

@synthesize mapView;
@synthesize location;
@synthesize marker;

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
    [mapView release];
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
    [self setNavigationRightButton:NSLS(@"Finish") action:@selector(finishSelectLocation:)];
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mapView setCenterCoordinate:location zoomLevel:12 animated:YES];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)finishSelectLocation:(id)sender
{
    NSArray *controllers = self.navigationController.viewControllers;
    CreatePlaceController *controller = [controllers objectAtIndex:([controllers count] - 2)];
    controller.location = [mapView convertPoint:CGPointMake(17, 53) toCoordinateFromView:marker]; 
    [self.navigationController popViewControllerAnimated:YES];
}

@end
