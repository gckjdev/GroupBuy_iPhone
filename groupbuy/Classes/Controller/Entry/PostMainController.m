//
//  PostMainController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PostMainController.h"
#import "Post.h"
#import "PostManager.h"
#import "UserManager.h"
#import "CommonProductListController.h"
#import "ProductPriceDataLoader.h"
#import "ProductCategoryController.h"
#import "GroupBuyReport.h"

enum SELECT_POST_TYPE {
    SELECT_TODAY = 0,
    SELECT_CATEGORY,
    SELECT_PRICE,
    SELECT_REBATE,
    SELECT_BOUGHT,                  // not used, reserved
    SELECT_DISTANCE,
    };

@implementation PostMainController

@synthesize priceController;
@synthesize categoryController;
@synthesize distanceController;
@synthesize rebateController;
@synthesize boughtController;
@synthesize todayController;

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
    [priceController release];
    [categoryController release];
    [distanceController release];
    [boughtController release];
    [rebateController release];
    [todayController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    NSLog(@"didReceiveMemoryWarning");

    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)showProductByPrice
{
    if (self.priceController == nil){
        self.priceController = [[[CommonProductListController alloc] init] autorelease];        
        self.priceController.superController = self;
        self.priceController.dataLoader = [[[ProductPriceDataLoader alloc] init] autorelease];
        self.priceController.type = [titlePPSegControl titleForSegmentAtIndex:
                                                [titlePPSegControl selectedSegmentIndex]];

        self.priceController.view.frame = self.view.bounds;        
        [self.view addSubview:priceController.view];                
    }
    
    [self.view bringSubviewToFront:priceController.view];
    [priceController viewDidAppear:NO];
    
}

- (void)showProductByRebate
{
    if (self.rebateController == nil){
        self.rebateController = [[[CommonProductListController alloc] init] autorelease];        
        self.rebateController.superController = self;
        self.rebateController.dataLoader = [[[ProductRebateDataLoader alloc] init] autorelease];
       
        self.rebateController.type = [titlePPSegControl titleForSegmentAtIndex:[titlePPSegControl selectedSegmentIndex]];   
        
        self.rebateController.view.frame = self.view.bounds;        
        [self.view addSubview:rebateController.view];                
    }
    
    [self.view bringSubviewToFront:rebateController.view];
    [rebateController viewDidAppear:NO];
    
}

- (void)showProductByDistance
{
    if (self.distanceController == nil){
        self.distanceController = [[[CommonProductListController alloc] init] autorelease];        
        self.distanceController.superController = self;
        self.distanceController.dataLoader = [[[ProductDistanceDataLoader alloc] init] autorelease];
        self.distanceController.type = [titlePPSegControl titleForSegmentAtIndex:[titlePPSegControl selectedSegmentIndex]];       
        self.distanceController.view.frame = self.view.bounds;        
        [self.view addSubview:distanceController.view];                
    }
    
    [self.view bringSubviewToFront:distanceController.view];
    [distanceController viewDidAppear:NO];
    
}

- (void)showProductByBought
{
    if (self.boughtController == nil){
        self.boughtController = [[[CommonProductListController alloc] init] autorelease];        
        self.boughtController.superController = self;
        self.boughtController.dataLoader = [[[ProductBoughtDataLoader alloc] init] autorelease];
        self.boughtController.type = [titlePPSegControl titleForSegmentAtIndex:[titlePPSegControl selectedSegmentIndex]];               
        self.boughtController.view.frame = self.view.bounds;        
        [self.view addSubview:boughtController.view];                
    }
    
    [self.view bringSubviewToFront:boughtController.view];
    [boughtController viewDidAppear:NO];
    
}

- (void)showProductByCategory
{
    if (self.categoryController == nil){
        self.categoryController = [[[ProductCategoryController alloc] init] autorelease];        
        self.categoryController.superController = self;
        self.categoryController.view.frame = self.view.bounds;        
        [self.view addSubview:categoryController.view];                
    }
    
    [self.view bringSubviewToFront:categoryController.view];
    [categoryController viewDidAppear:NO];
    
}

- (void)showProductByToday
{
    if (self.todayController == nil){
        self.todayController = [[[ProductCategoryController alloc] init] autorelease];        
        self.todayController.superController = self;
        self.todayController.todayOnly = YES;
        self.todayController.view.frame = self.view.bounds;        
        [self.view addSubview:todayController.view];                
    }
    
    [self.view bringSubviewToFront:todayController.view];
    [todayController viewDidAppear:NO];
    
}

- (void)viewDidLoad
{
    // set right button
//    UIBarButtonItem *newPostButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickCreatePost:)];
//    self.navigationItem.rightBarButtonItem = newPostButton;
//    [newPostButton release];
    
    [self createDefaultNavigationTitleToolbar:
                    [NSArray arrayWithObjects:
                     @"今日",
                     @"所有",
                     @"最便宜",
                     @"最划算",
                     @"最热销",
                     @"最方便",
                     nil]
                    defaultSelectIndex:0];    

    [super viewDidLoad];
//    [self showProductByToday];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self clickSegControl:self.titlePPSegControl];
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.priceController = nil;
    self.categoryController = nil;
    self.todayController = nil;
    self.rebateController = nil;
    self.distanceController = nil;
    self.boughtController = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table View Delegate

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView 
//{
//	NSMutableArray* array = [NSMutableArray arrayWithArray:[ArrayOfCharacters getArray]];
//	[array addObject:kSectionNull];
//	return array;
//	
////		NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
////		return nil;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//	return [groupData sectionForLetter:title];
//}


#pragma Title ToolBar Button Actions

- (void)clickSegControl:(id)sender
{
    
    PPSegmentControl* segControl = sender;
    
    [GroupBuyReport reportPPSegControlClick:segControl];
    NSInteger index = [segControl selectedSegmentIndex];
    if (index == SELECT_BOUGHT){
        [self showProductByBought];
    }
    else if (index == SELECT_TODAY){
        [self showProductByToday];
    }
    else if (index == SELECT_CATEGORY){
        [self showProductByCategory];
    }
    else if (index == SELECT_PRICE){
        [self showProductByPrice];
    }    
    else if (index == SELECT_DISTANCE){
        [self showProductByDistance];
    }
    else{
        [self showProductByRebate];
    }
}
@end


