//
//  SettingsController.m
//  groupbuy
//
//  Created by qqn_pipi on 11-8-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SettingsController.h"
#import "CityPickerViewController.h"
#import "LocationService.h"

@implementation SettingsController
@synthesize cityLabel;

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
    [cityLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)setCity:(NSString*)city
{
    cityLabel.text = [NSString stringWithFormat:@"当前选择的城市是：%@", city];    
}

- (void)viewDidLoad
{    
    [self setCity:[GlobalGetLocationService() getDefaultCity]];
    
    [self setBackgroundImageName:@"background.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setCityLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickSetCity:(id)sender
{

    NSString* city = [GlobalGetLocationService() getDefaultCity];
    
    CityPickerViewController* controller = [[CityPickerViewController alloc] initWithCityName:city hasLeftButton:YES];
    
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:YES];    
    [controller release];
}

-(void) dealWithPickedCity:(NSString *)city
{
    if ([city length] > 0){
        [GlobalGetLocationService() setDefaultCity:city];
        [self setCity:city];
    }
}

@end
