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
#import "NearbyPostController.h"
#import "CreatePostController.h"
#import "PrivateMessageUserController.h"
#import "PublicTimelinePostController.h"
#import "CommonProductListController.h"
#import "ProductPriceDataLoader.h"
#import "ProductCategoryController.h"

enum SELECT_POST_TYPE {
    SELECT_TODAY = 0,
    SELECT_CATEGORY,
    SELECT_PRICE,
    SELECT_REBATE,
    SELECT_BOUGHT,                  // not used, reserved
    SELECT_DISTANCE,
    };

@implementation PostMainController

@synthesize nearbyPostController;
@synthesize followPostController;
@synthesize privateMessageController;
@synthesize atMePostController;
@synthesize latestPostController;
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
    [nearbyPostController release];
    [followPostController release];
    [privateMessageController release];
    [atMePostController release];
    [latestPostController release];
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
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)showNearbyPost
{
    if (self.nearbyPostController == nil){
        self.nearbyPostController = [[NearbyPostController alloc] init];
        self.nearbyPostController.superController = self;
        self.nearbyPostController.view.frame = self.view.bounds;        
        [self.view addSubview:nearbyPostController.view];                
    }
    
    [self.view bringSubviewToFront:nearbyPostController.view];
    [nearbyPostController viewDidAppear:NO];
}

- (void)showLatestPost
{
    if (self.latestPostController == nil){
        self.latestPostController = [[PublicTimelinePostController alloc] init];
        self.latestPostController.superController = self;
        self.latestPostController.view.frame = self.view.bounds;        
        [self.view addSubview:latestPostController.view];                
    }
    
    [self.view bringSubviewToFront:latestPostController.view];
    [latestPostController viewDidAppear:NO];
}

- (void)showFollowPost
{
    if (self.followPostController == nil){
        self.followPostController = [[FollowPostController alloc] init];
        self.followPostController.superController = self;
        self.followPostController.view.frame = self.view.bounds;        
        [self.view addSubview:followPostController.view];        
    }
    
    [self.view bringSubviewToFront:followPostController.view];
    [followPostController viewDidAppear:NO];
}

- (void)showAtMePost
{
    if (self.atMePostController == nil){
        self.atMePostController = [[AtMePostController alloc] init];
        self.atMePostController.superController = self;
        self.atMePostController.view.frame = self.view.bounds;        
        [self.view addSubview:atMePostController.view];                
    }
    
    [self.view bringSubviewToFront:atMePostController.view];
    [atMePostController viewDidAppear:NO];    
}


- (void)showPrivateMessage
{
    if (self.privateMessageController == nil){
        self.privateMessageController = [[PrivateMessageUserController alloc] init];
        self.privateMessageController.superController = self;
        self.privateMessageController.view.frame = self.view.bounds;        
        [self.view addSubview:privateMessageController.view];                
    }

    [self.view bringSubviewToFront:privateMessageController.view];
    [privateMessageController viewDidAppear:NO];

}

- (void)showProductByPrice
{
    if (self.priceController == nil){
        self.priceController = [[CommonProductListController alloc] init];        
        self.priceController.superController = self;
        self.priceController.dataLoader = [[ProductPriceDataLoader alloc] init];
        self.priceController.view.frame = self.view.bounds;        
        [self.view addSubview:priceController.view];                
    }
    
    [self.view bringSubviewToFront:priceController.view];
    [priceController viewDidAppear:NO];
    
}

- (void)showProductByRebate
{
    if (self.rebateController == nil){
        self.rebateController = [[CommonProductListController alloc] init];        
        self.rebateController.superController = self;
        self.rebateController.dataLoader = [[ProductRebateDataLoader alloc] init];
        self.rebateController.view.frame = self.view.bounds;        
        [self.view addSubview:rebateController.view];                
    }
    
    [self.view bringSubviewToFront:rebateController.view];
    [rebateController viewDidAppear:NO];
    
}

- (void)showProductByDistance
{
    if (self.distanceController == nil){
        self.distanceController = [[CommonProductListController alloc] init];        
        self.distanceController.superController = self;
        self.distanceController.dataLoader = [[ProductDistanceDataLoader alloc] init];
        self.distanceController.view.frame = self.view.bounds;        
        [self.view addSubview:distanceController.view];                
    }
    
    [self.view bringSubviewToFront:distanceController.view];
    [distanceController viewDidAppear:NO];
    
}

- (void)showProductByBought
{
    if (self.boughtController == nil){
        self.boughtController = [[CommonProductListController alloc] init];        
        self.boughtController.superController = self;
        self.boughtController.dataLoader = [[ProductBoughtDataLoader alloc] init];
        self.boughtController.view.frame = self.view.bounds;        
        [self.view addSubview:boughtController.view];                
    }
    
    [self.view bringSubviewToFront:boughtController.view];
    [boughtController viewDidAppear:NO];
    
}

- (void)showProductByCategory
{
    if (self.categoryController == nil){
        self.categoryController = [[ProductCategoryController alloc] init];        
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
        self.todayController = [[ProductCategoryController alloc] init];        
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
    
    [self createNavigationTitleToolbar:
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
    [self showProductByToday];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    UISegmentedControl* segControl = sender;
    if (segControl.selectedSegmentIndex == SELECT_BOUGHT){
        [self showProductByBought];
    }
    else if (segControl.selectedSegmentIndex == SELECT_TODAY){
        [self showProductByToday];
    }
    else if (segControl.selectedSegmentIndex == SELECT_CATEGORY){
        [self showProductByCategory];
    }
    else if (segControl.selectedSegmentIndex == SELECT_PRICE){
        [self showProductByPrice];
    }    
    else if (segControl.selectedSegmentIndex == SELECT_DISTANCE){
        [self showProductByDistance];
    }
    else{
        [self showProductByRebate];
    }
}

- (void)clickCreatePost:(id)sender
{
    CreatePostController* vc = [[CreatePostController alloc] init];
    vc.place = nil;
    vc.navigationItem.title = NSLS(@"kCreatePostTitle");
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

@end


