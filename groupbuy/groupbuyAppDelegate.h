//
//  groupbuyAppDelegate.h
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright QQN-PIPI.com 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataUtil.h"
#import "PPApplication.h"
#import "MobClick.h"
#import "LocalDataService.h"
#import "LocationService.h"
#import "RegisterController.h"
#import "EnterPlaceAppController.h"
#import "AppManager.h"
#import "UserService.h"
#import "CategoryService.h"
#import "PPTabBarController.h"

// TODO remove all depedency class header files

@class GroupBuySNSService;
@class MessageService;
@class PostService;
@class AppService;
@class ProductService;
@class ReviewRequest;
@class UserShopItemService;
@class ShoppingListController;

#define _THREE20_		1
#define kAppId			@"456494464"					// To be changed for each project
#define kMobClickKey	@"4e2d3cc0431fe371c3000029"		// To be changed for each project

#define MAKE_FRIEND_PLACEID @"GroupBuy"

@interface groupbuyAppDelegate : PPApplication <UIApplicationDelegate, UITabBarControllerDelegate, MobClickDelegate, EnterPlaceAppDelegate,
LocalDataServiceDelegate, UserServiceDelegate, CityPickerDelegate> {
    
    UIWindow			*window;
    PPTabBarController	*tabBarController;
	CoreDataManager		*dataManager;	
    
    LocalDataService    *localDataService;
    LocationService     *locationService;
    UserService         *userService;
    RegisterController  *registerController;
    GroupBuySNSService  *snsService;
    MessageService      *messageService;
    PostService         *postService;
    AppService          *appService;    
    ProductService      *productService;
    CategoryService     *categoryService;
    UserShopItemService *userShopService;
    
    ReviewRequest           *reviewRequest;
    EnterPlaceAppController *enterController;    
    ShoppingListController   *shoppingListController;
    NSString                *dataForRegistration;
    
    UIBackgroundTaskIdentifier backgroundTask;
}

@property (nonatomic, retain) IBOutlet UIWindow				*window;
@property (nonatomic, retain) IBOutlet PPTabBarController	*tabBarController;
@property (nonatomic, retain) CoreDataManager				*dataManager;
@property (nonatomic, retain) LocalDataService              *localDataService;
@property (nonatomic, retain) LocationService               *locationService;
@property (nonatomic, retain) UserService                   *userService;
@property (nonatomic, retain) GroupBuySNSService            *snsService;
@property (nonatomic, retain) MessageService                *messageService;
@property (nonatomic, retain) PostService                   *postService;
@property (nonatomic, retain) AppService                    *appService;
@property (nonatomic, retain) ProductService                *productService;
@property (nonatomic, retain) CategoryService               *categoryService;
@property (nonatomic, retain) UserShopItemService           *userShopService;
@property (nonatomic, retain) RegisterController            *registerController;
@property (nonatomic, retain) EnterPlaceAppController       *enterController;    
@property (nonatomic, retain) NSString                      *dataForRegistration;
@property (nonatomic, retain) ReviewRequest                 *reviewRequest;


- (BOOL)hasDataForRegistration;
- (void)addEnterAppView;
- (void)removeEnterAppView;
- (void)addRegisterView;
- (void)removeRegisterView;
- (void)addMainView;
- (void)removeMainView;
- (void)dismissRegisterView;



@end


