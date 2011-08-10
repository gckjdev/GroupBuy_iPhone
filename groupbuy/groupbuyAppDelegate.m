//
//  groupbuyAppDelegate.m
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright QQN-PIPI.com 2011. All rights reserved.
//

#import "groupbuyAppDelegate.h"
#import "UIUtils.h"
#import "ReviewRequest.h"

// optional header files
#import "AboutViewController.h"
#import "PPViewController.h"
#import "TestPPViewController.h"
#import "SelectItemViewController.h"
#import "SettingsController.h"

#import "SearchProductController.h"
#import "MyInfoController.h"
#import "InviteController.h"
#import "FeedbackController.h"
#import "NewMakeFriendPostMainController.h"
#import "PostMainController.h"
#import "CommonProductListController.h"

#import "CommonManager.h"
#import "UserManager.h"
#import "RegisterController.h"
#import "DeviceLoginRequest.h"

#import "PlaceManager.h"
#import "PlaceSNSService.h"
#import "MessageService.h"
#import "PostService.h"
#import "AppService.h"
#import "ProductService.h"
#import "ProductManager.h"
#import "GroupBuyUserService.h"

#import "ProductPriceDataLoader.h"
#import "GroupBuyReport.h"

#import "GroupBuyNetworkRequest.h"

#import "CityPickerViewController.h"

#define kDbFileName			@"AppDB"

NSString* GlobalGetServerURL()
{
//    return @"http://192.168.1.101:8000/api/i?";
    return @"http://107.20.223.45:8000/api/i?";
}

AppService* GlobalGetAppService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate appService];            
}

PostService* GlobalGetPostService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate postService];        
}

MessageService*   GlobalGetMessageService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate messageService];    
}

LocalDataService* GlobalGetLocalDataService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate localDataService];
}

LocationService*   GlobalGetLocationService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    return [delegate locationService];
    
}

UserService* GlobalGetUserService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate userService];    
}

PlaceSNSService* GlobalGetSNSService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate snsService];    
}

NSString* GlobalGetPlaceAppId()
{
    return @"GROUPBUY";
}

ProductService* GlobalGetProductService()
{
    groupbuyAppDelegate* delegate = (groupbuyAppDelegate*)[[UIApplication sharedApplication] delegate];    
    return [delegate productService];   
}

@implementation groupbuyAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize dataManager;
@synthesize localDataService;
@synthesize locationService;
@synthesize registerController;
@synthesize userService;
@synthesize snsService;
@synthesize enterController;
@synthesize dataForRegistration;
@synthesize messageService;
@synthesize postService;
@synthesize appService;
@synthesize productService;
@synthesize reviewRequest;

#pragma mark -
#pragma mark Application lifecycle

- (void)initTabViewControllers
{
	NSMutableArray* controllers = [[NSMutableArray alloc] init];
    
	[UIUtils addViewController:[PostMainController alloc]
					 viewTitle:@"首页"
					 viewImage:@"home_24.png"
			  hasNavController:YES			
			   viewControllers:controllers];	

	[UIUtils addViewController:[SearchProductController alloc]
					 viewTitle:@"搜索"				 
					 viewImage:@"magnifier_24.png"
			  hasNavController:YES			
			   viewControllers:controllers];	
	
	CommonProductListController* historyController = (CommonProductListController*)[UIUtils addViewController:[CommonProductListController alloc]
					 viewTitle:@"历史"				 
					 viewImage:@"folder_bookmark_24.png"
			  hasNavController:YES			
			   viewControllers:controllers];	
    historyController.dataLoader = [[ProductHistoryDataLoader alloc] init];
    
//	[UIUtils addViewController:[MyInfoController alloc]
//					 viewTitle:NSLS(@"Setting")				 
//					 viewImage:@"man_24.png"
//			  hasNavController:YES			
//			   viewControllers:controllers];	

    [UIUtils addViewController:[SettingsController alloc]
					 viewTitle:@"设置"				 
					 viewImage:@"gear_24.png"
			  hasNavController:YES			
			   viewControllers:controllers];	
        
	[UIUtils addViewController:[FeedbackController alloc]
					 viewTitle:@"反馈"
					 viewImage:@"help_24.png"
			  hasNavController:YES			
			   viewControllers:controllers];	
	
	tabBarController.viewControllers = controllers;
	
	[controllers release];
}

- (void)initMobClick
{
	[MobClick setDelegate:self];
	[MobClick appLaunched];	
}

- (void)initLocalDataService
{
    self.localDataService = [[LocalDataService alloc] initWithDelegate:self];
}

- (void)initLocationService
{
    self.locationService = [[LocationService alloc] init];
    [locationService asyncGetLocation];        
}

- (void)initMessageService
{
    self.messageService = [[MessageService alloc] init];
}


- (void)initUserService
{
    self.userService = [[UserService alloc] init];
    userService.delegate = self;
}

- (void)initSNSService
{
    self.snsService = [[PlaceSNSService alloc] init];
}

- (void)initPostService
{
    self.postService = [[PostService alloc] init];
}

- (void)initAppService
{
    self.appService = [[AppService alloc] init];
}

- (void)initProductService
{
    self.productService = [[ProductService alloc] init];
}

- (void)showViewByUserStatus
{
    [userService groupBuyCheckDevice];    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	NSLog(@"Application starts, launch option = %@", [launchOptions description]);	
	
	// Init Core Data
	self.dataManager = [[CoreDataManager alloc] initWithDBName:kDbFileName dataModelName:nil];
    workingQueue = dispatch_queue_create("main working queue", NULL);    
    
    [self initSNSService];
	[self initMobClick];
    [self initImageCacheManager];    
    [self initLocationService];
    [self initUserService];
    [self initLocalDataService];       
    [self initMessageService];
    [self initPostService];
    [self initAppService];    
    [self initProductService];
    
    [self showViewByUserStatus];
    
    
    [window makeKeyAndVisible];
	
    // update app version
    [appService startAppUpdate];
    
	// Ask For Review
	self.reviewRequest = [ReviewRequest startReviewRequest:kAppId appName:GlobalGetAppName() isTest:NO];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	NSLog(@"applicationWillResignActive");	
	[MobClick appTerminated];
    
}

- (void)stopAudioPlayer
{
	if (player && [player isPlaying]){
		[player stop];
	}	
}

- (void)cleanUpDeleteData
{
    int timeStamp = time(0) - 3600; // before 1 hour
    [ProductManager cleanData:timeStamp];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	NSLog(@"applicationDidEnterBackground");	
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self releaseResourceForAllViewControllers];	
	[self stopAudioPlayer];
    
    backgroundTask = [application beginBackgroundTaskWithExpirationHandler: ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (UIBackgroundTaskInvalid != backgroundTask) {
                [application endBackgroundTask:backgroundTask];
                backgroundTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    NSLog(@"Background Task Remaining Time = %f", [application backgroundTimeRemaining]);
    if (UIBackgroundTaskInvalid != backgroundTask) {
        [self cleanUpDeleteData];
    }		
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
	NSLog(@"applicationWillEnterForeground");	
	
	[self initMobClick];
    [appService startAppUpdate];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	
	NSLog(@"applicationDidBecomeActive");	
	
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    
	NSLog(@"applicationWillTerminate");	
	
	[MobClick appTerminated];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSString *host = [url host];
    if ([host isEqualToString:@"sina"]) {        
        [snsService sinaParseAuthorizationResponseURL:[url query]];
    } else if ([host isEqualToString:@"qq"]) {
        [snsService qqParseAuthorizationResponseURL:[url query]];
    }
    
    return YES;
}

#pragma mark - User Service Delegate
- (void)checkDeviceResult:(int)result
{
    [self addMainView];

    NSString *defaultCity = [locationService getDefaultCity];    
    if (defaultCity == nil) {
        CityPickerViewController *cityController = [[CityPickerViewController alloc]initWithCityName:defaultCity hasLeftButton:NO];
        cityController.delegate = locationService;
        [[[tabBarController viewControllers] objectAtIndex:0] pushViewController:cityController animated:YES];  
        [cityController release];
    }
}

- (void)loginUserResult:(int)result
{
    switch (result) {
        case LOGIN_RESULT_SUCCESS:
            [self dismissRegisterView];
            break;
            
        case ERROR_NETWORK:
            [UIUtils alert:NSLS(@"kSystemFailure")];
            break;
            
        case LOGIN_RESULT_ID_NOT_MATCH:
            [UIUtils alert:NSLS(@"kLoginIdNotMatch")];
            break;
            
        case ERROR_LOGINID_EXIST:
            [UIUtils alert:NSLS(@"kLoginIdExist")];
            break;
            
        default:
            [UIUtils alert:[NSString stringWithFormat:NSLS(@"kLoginGeneralError"), result]];
            break;
    }
}

#pragma Register View Management

- (void)doRegisterWithPlaceName:(NSString*)placeName
{
    if ([placeName length] > 0){
        self.dataForRegistration = placeName;                
    }
    
    [self removeEnterAppView];
    [self addRegisterView];
}

- (BOOL)hasDataForRegistration
{
    return ([dataForRegistration length] > 0);
}

- (void)addEnterAppView {
    self.enterController = [[EnterPlaceAppController alloc] init];
    enterController.delegate = self;
    [window addSubview:enterController.view];
}

- (void)removeEnterAppView {
    [enterController.view removeFromSuperview];
    self.enterController = nil;
}

- (void)addRegisterView {
    self.registerController = [[RegisterController alloc] init];
    [window addSubview:registerController.view];
}

- (void)removeRegisterView {
    [registerController.view removeFromSuperview];
    self.registerController = nil;
}

- (void)addMainView {
    // Init tab bar and window
	[self initTabViewControllers];
    [tabBarController.view removeFromSuperview];
	[window addSubview:tabBarController.view];
}

- (void)removeMainView {
    [tabBarController.view removeFromSuperview];
}

- (void)dismissRegisterView{
    [self removeRegisterView];
    [self addMainView];
}


#pragma mark Local Notification Handler

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {		
    
	NSLog(@"didReceiveLocalNotification, application state is %d", app.applicationState);	
	if (app.applicationState == UIApplicationStateActive){		
		// if application is in active state, simulate to popup an alert box
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:GlobalGetAppName() 
															message:notif.alertBody 
														   delegate:self 
												  cancelButtonTitle:NSLS(@"Close") 
												  otherButtonTitles:notif.alertAction, nil];
		[alertView show];
		[alertView release];
	}
	else {		
		// TO DO, And Local Notification Handling Code Here
	}	
}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController 
{
    [GroupBuyReport reportTabBarControllerClick:self.tabBarController];
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed 
{    
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
	// release UI objects
    [registerController release];
    [tabBarController release];
    [enterController release];
    [window release];
	
	// release data objects
	[dataManager release];
    [localDataService release];
    [locationService release];
    [snsService release];
    [dataForRegistration release];
    [messageService release];
    [appService release];
    [reviewRequest release];
    [productService release];
	
    [super dealloc];
}

#pragma mark Mob Click Delegates

- (NSString *)appKey
{
	return kMobClickKey;	// shall be changed for each application
}

#pragma Local Data Service Delegate

- (void)followPlaceDataRefresh
{
    NSLog(@"<followPlaceDataRefresh>");
}


@end

