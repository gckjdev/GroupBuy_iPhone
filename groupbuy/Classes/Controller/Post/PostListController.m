//
//  PostListController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-14.
//  Copyright 2011骞�__MyCompanyName__. All rights reserved.
//

#import "CreatePostController.h"
#import "PostListController.h"
#import "PostManager.h"
#import "UserManager.h"
#import "PlaceManager.h"
#import "Post.h"
#import "LocalDataService.h"
#import "groupbuyAppDelegate.h"
#import "UserFollowPlaceRequest.h"
#import "UserUnfollowPlaceRequest.h"
#import "PostController.h"
#import "PostControllerUtils.h"
#import "PostTableViewCell.h"
#import "PrivateMessageControllerUtils.h"

enum {
    SECTION_PLACE,
    SECTION_POSTS,
    SECTION_NUM
};

@implementation PostListController

@synthesize place;

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
    [place release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadPostList
{
    // load post list from local DB
    self.dataList = [PostManager getPostByPlace:place.placeId];
    LocalDataService* dataService = GlobalGetLocalDataService();
    [dataService requestLatestPlacePostData:self placeId:place.placeId];
}

- (void)loadPostListFromDB
{
    self.dataList = [PostManager getPostByPlace:place.placeId];    
}

- (void)refreshUI
{
    self.dataList = [PostManager getPostByPlace:place.placeId];    
    [self.dataTableView reloadData];
}

- (void)placePostDataRefresh:(int)result
{
    [self refreshUI];
}

- (void)viewDidLoad
{
    // set right button
    UIBarButtonItem *newPostButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(clickCreatePost:)];
    self.navigationItem.rightBarButtonItem = newPostButton;
    [newPostButton release];
    
    // set left button
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    
    // set title
    self.navigationItem.title = NSLS(@"kPlacePostTitle");
    
    [super viewDidLoad];
    self.dataTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}



- (void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    [self loadPostList];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    switch (section) {
        case SECTION_PLACE:
            return @"";
            
        default:
            return NSLS(@"kPlacePosts");
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	return [self getSectionView:tableView section:section];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return sectionImageHeight;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//	return [self getFooterView:tableView section:section];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//	return footerImageHeight;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// return [self getRowHeight:indexPath.row totalRow:[dataList count]];
	// return cellImageHeight;
	
    switch (indexPath.section) {
        case SECTION_PLACE:
            return 60;
            
        default:
            return [PostTableViewCell getCellHeight];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_NUM;		// default implementation
	
	// return [groupData totalSectionCount];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case SECTION_PLACE:
            return 1;
            
        default:
            return [dataList count];			// default implementation
    }
	
	// return [groupData numberOfRowsInSection:section];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.section) {
        case SECTION_PLACE:
        {
            static NSString *CellIdentifier = @"PlaceTableViewCell";
            PlaceTableViewCell *cell = (PlaceTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                [self loadCellFromNib:@"PlaceTableViewCell"];
                cell = placeCell;				
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [PostControllerUtils setCellStyle:cell];                
                
            }   
            
            cell.placeNameLabel.text = place.name;
            cell.placeDescLabel.text = place.desc;                      
            if ([PlaceManager isPlaceFollowByUser:place.placeId]){
                [cell.actionButton setTitle:NSLS(@"kUnfollow") forState:UIControlStateNormal];                
            }
            else{
                [cell.actionButton setTitle:NSLS(@"kFollow") forState:UIControlStateNormal];
            }
            cell.rowNumber = indexPath.row;
            cell.delegate = self;
            
            return cell;
        }
            break;
            
        default:
        {
            NSString *CellIdentifier = [PostTableViewCell getCellIdentifier];
            PostTableViewCell *cell = (PostTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [PostTableViewCell createCell:self];
            }
            
            // set text label
            int row = [indexPath row];	
            int count = [dataList count];
            if (row >= count){
                NSLog(@"[WARN] cellForRowAtIndexPath, row(%d) > data list total number(%d)", row, count);
                return cell;
            }
            
            //	[self setCellBackground:cell row:row count:count];
            
            Post* post = [dataList objectAtIndex:row];
            [cell setCellInfoWithPost:post indexPath:indexPath];
            
            return cell;
        
        }
    }
    
    
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
    
    switch (indexPath.section) {
        case SECTION_PLACE:
            break;
            
        default:
            [PostControllerUtils gotoPostController:self 
                                               post:[dataList objectAtIndex:indexPath.row]];
            break;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
				
	}
	
}

#pragma Button Action

- (void)clickCreatePost:(id)sender
{
    CreatePostController* vc = [[CreatePostController alloc] init];
    vc.place = self.place;
    vc.navigationItem.title = NSLS(@"kCreatePostTitle");
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)followPlace:(NSString*)userId placeId:(NSString*)placeId
{
    NSString* appId = [AppManager getPlaceAppId];
    
    [self showActivityWithText:NSLS(@"kFollowingPlace")];
    dispatch_async(workingQueue, ^{
        
        UserFollowPlaceOutput* output = [UserFollowPlaceRequest send:SERVER_URL userId:userId placeId:placeId appId:appId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivity];
            if (output.resultCode == ERROR_SUCCESS){               
                // save place data locally
                [PlaceManager userFollowPlace:userId place:place];
                [self.dataTableView reloadData];

            }
            else if (output.resultCode == ERROR_NETWORK){
                [UIUtils alert:NSLS(@"kSystemFailure")];
            }
            else{
                // other error TBD
            }
        });        
    });    
    
}

- (void)unfollowPlace:(NSString*)userId placeId:(NSString*)placeId
{
    NSString* appId = [AppManager getPlaceAppId];
    
    [self showActivityWithText:NSLS(@"kUnfollowingPlace")];
    dispatch_async(workingQueue, ^{
        
        UserUnfollowPlaceOutput* output = [UserUnfollowPlaceRequest send:SERVER_URL userId:userId placeId:placeId appId:appId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivity];
            if (output.resultCode == ERROR_SUCCESS){               
                // save place data locally
                [PlaceManager userUnfollowPlace:userId placeId:placeId];
                [self.dataTableView reloadData];
                
            }
            else if (output.resultCode == ERROR_NETWORK){
                [UIUtils alert:NSLS(@"kSystemFailure")];
                // for test, TO BE REMOVED
                
            }
            else{
                // other error TBD
                // for test, TO BE REMOVED
            }
        });        
    });    
    
}

- (IBAction)clickFollow:(id)sender
{
    NSString* userId = [UserManager getUserId];
    [self followPlace:userId placeId:place.placeId];
}

- (IBAction)clickUnFollow:(id)sender
{
    NSString* userId = [UserManager getUserId];
    [self unfollowPlace:userId placeId:place.placeId];
}

- (void)clickActionButton:(id)sender atRow:(NSUInteger)row
{
    NSString* userId = [UserManager getUserId];    
    if ([PlaceManager isPlaceFollowByUser:place.placeId]){
        [self unfollowPlace:userId placeId:place.placeId];
    }
    else{
        [self followPlace:userId placeId:place.placeId];    
    }
}

- (void)clickBack:(id)sender
{
    int count = [self.navigationController.viewControllers count];
    if (count >= 2){
        UIViewController* vc = [self.navigationController.viewControllers objectAtIndex:count-2];
        vc.hidesBottomBarWhenPushed = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickPlaceNameButton:(id)sender atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [dataList count])
        return;
    
    Post* post = [dataList objectAtIndex:indexPath.row];
    [PostControllerUtils askFollowPlace:post.placeId placeName:post.placeName  viewController:self];
    
    
    
}

- (void)clickUserAvatarButton:(id)sender atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [dataList count])
        return;
    
    Post* post = [dataList objectAtIndex:indexPath.row];    
    [PrivateMessageControllerUtils showPrivateMessageController:post.userId 
                                                   userNickName:post.userNickName
                                                     userAvatar:post.userAvatar
                                                 viewController:self];      
}

@end
