//
//  PostController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PostController.h"
#import "CreatePostController.h"
#import "UserManager.h"
#import "AppManager.h"
#import "GetPostRelatedPostRequest.h"
#import "ResultUtils.h"
#import "PostControllerUtils.h"
#import "PostTableViewCell.h"
#import "MoreTableViewCell.h"
#import "PrivateMessageControllerUtils.h"

enum{
    SECTION_POST_ITSELF,
    SECTION_RELATED_POST,
    SECTION_NUM
};


@implementation PostController

@synthesize actionToolbar;
@synthesize post;

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
    [post release];
    [actionToolbar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)postDataRefresh:(GetPostRelatedPostOutput*)output
{    
    if (output.resultCode == ERROR_SUCCESS){
        self.dataList = output.postArray;
        [self.dataTableView reloadData];
    }
    else{
        // TODO show error here
        NSLog(@"fail to get post related post, result code=%d", output.resultCode);            
    }
    
    if ([self isReloading]){
        [self dataSourceDidFinishLoadingNewData];
    }
}

- (void)loadPostRelatedPost
{
    if ([UserManager isUserRegistered] == NO)
        return;
    
    NSString* userId = [UserManager getUserId];
    NSString* appId = [AppManager getPlaceAppId];
    
    dispatch_async(workingQueue, ^{        
        GetPostRelatedPostOutput* output = [GetPostRelatedPostRequest send:SERVER_URL userId:userId 
                                                                     appId:appId 
                                                                    postId:post.srcPostId
                                                             excludePostId:post.postId
                                                           beforeTimeStamp:@""];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postDataRefresh:output];
        });
    });
    
}

#pragma Pull Refresh Delegate
- (void) reloadTableViewDataSource
{
    [self loadPostRelatedPost];
}


- (void)initActionToolbar
{	
    UIBarButtonItem* replyButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                    UIBarButtonSystemItemReply target:self action:@selector(replyPost)] autorelease];
        
    UIBarItem* spaceButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                         UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];    
    
    actionToolbar.items = [NSArray arrayWithObjects:replyButton, spaceButton, nil];
}

- (void)viewDidLoad
{
    supportRefreshHeader = YES;    
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    [self setNavigationRightButton:NSLS(@"kReply") action:@selector(clickReply:)];
        
    self.navigationItem.title = NSLS(@"kPostRelatedPostTitle");
    
    [self initActionToolbar];    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadPostRelatedPost];

}

- (void)viewDidAppear:(BOOL)animated
{    
    
    self.hidesBottomBarWhenPushed = YES;
    [super viewDidAppear:YES];
}

- (void)viewDidUnload
{
    
    [self setActionToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    [super viewDidDisappear:animated];
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
        case SECTION_POST_ITSELF:
            return @"";
            
        case SECTION_RELATED_POST:
            return NSLS(@"kRelatedPost");
            
        default:            
            return 0;
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
    switch (indexPath.section) {
        case SECTION_POST_ITSELF:
            return [PostTableViewCell getCellHeight];
            
        case SECTION_RELATED_POST:
            return [PostTableViewCell getCellHeight];
            
        default:            
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return SECTION_NUM;			

}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case SECTION_POST_ITSELF:
            return 1;
            break;
            
        case SECTION_RELATED_POST:
            return [dataList count];
            break;

        default:            
            return 0;
    }    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [PostTableViewCell getCellIdentifier];
	PostTableViewCell *cell = (PostTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [PostTableViewCell createCell:self];
        cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
    switch (indexPath.section) {
        case SECTION_POST_ITSELF:
        {
            [cell setCellInfoWithPost:post indexPath:indexPath];
        }
            break;
            
        case SECTION_RELATED_POST:
        {
            int row = [indexPath row];	
            int count = [dataList count];
            if (row >= count){
                NSLog(@"[WARN] cellForRowAtIndexPath, row(%d) > data list total number(%d)", row, count);
                return cell;
            }            
            
            NSDictionary* dict = [dataList objectAtIndex:row];
            [cell setCellInfoWithDict:dict indexPath:indexPath];
                    
        }
            break;
            
        default:            
            break;
    }    

	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row > [dataList count] - 1)
		return;
	    
}

- (void)clickPlaceNameButton:(id)sender atIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.section) {
        case SECTION_POST_ITSELF:
        {
            [PostControllerUtils askFollowPlace:post.placeId
                                      placeName:post.placeName
                                 viewController:self];            

        }
            break;
            
        case SECTION_RELATED_POST:
        {
            if (indexPath.row >= [dataList count])
                return;        
            
            NSDictionary* postDict = [dataList objectAtIndex:indexPath.row];
            [PostControllerUtils askFollowPlace:[ResultUtils placeId:postDict]
                                      placeName:[ResultUtils placeName:postDict]
                                 viewController:self];            
        }
            break;
            
        default:            
            break;
    }    
    
}

- (void)clickUserAvatarButton:(id)sender atIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.section) {
        case SECTION_POST_ITSELF:
        {
            [PrivateMessageControllerUtils showPrivateMessageController:post.userId  
                                                           userNickName:post.userNickName
                                                             userAvatar:post.userAvatar
                                                         viewController:self];  
        }
            break;
            
        case SECTION_RELATED_POST:
        {
            if (indexPath.row >= [dataList count])
                return;        
            
            NSDictionary* postDict = [dataList objectAtIndex:indexPath.row];
            [PrivateMessageControllerUtils showPrivateMessageController:[ResultUtils userId:postDict] 
                                                           userNickName:[ResultUtils nickName:postDict]
                                                             userAvatar:[ResultUtils userAvatar:postDict]
                                                         viewController:self];  
        }
            break;
            
        default:            
            break;
    }    
    
}


#pragma Button Actions

- (void)replyPost
{
    needRefreshNow = YES;   // when back to this view, refresh to view the latest post
    
    CreatePostController* vc = [[CreatePostController alloc] init];
    vc.srcPostId = post.srcPostId;
    vc.srcPlaceId = post.placeId;
    vc.replyPostId = post.postId;
    vc.navigationItem.title = NSLS(@"kReplyPostTitle");
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)clickReply:(id)sender
{
    [self replyPost];
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

@end
