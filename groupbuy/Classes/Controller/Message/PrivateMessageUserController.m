//
//  PrivateMessageUserController.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PrivateMessageUserController.h"
#import "PrivateMessageManager.h"
#import "PrivateMessage.h"
#import "PrivateMessageUser.h"
#import "NetworkRequestResultCode.h"
#import "UserService.h"
#import "MessageService.h"
#import "PrivateMessageUserTableViewCell.h"
#import "PrivateMessageListController.h"

@implementation PrivateMessageUserController

@synthesize superController;

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
    [superController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)downloadMessageFinish:(int)result;
{    
    if (result == ERROR_SUCCESS){
        self.dataList = [PrivateMessageManager getAllMessageUser];
        [self.dataTableView reloadData];
    }
    
    if ([self isReloading]){
        [self dataSourceDidFinishLoadingNewData];
    }
}

- (void)requestPrivateMessageListFromServer:(BOOL)isRequestLastest
{
    MessageService *messageService = GlobalGetMessageService();
    [messageService downloadNewMessage:self];
}

- (void)initDataList
{
    self.dataList = [PrivateMessageManager getAllMessageUser];
//    [self requestPostListFromServer:YES];    
}

#pragma Pull Refresh Delegate
- (void) reloadTableViewDataSource
{
    [self requestPrivateMessageListFromServer:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    supportRefreshHeader = YES;
    
    [self initDataList];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];

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
	
	NSString *sectionHeader = [groupData titleForSection:section];	
	
	//	switch (section) {
	//		case <#constant#>:
	//			<#statements#>
	//			break;
	//		default:
	//			break;
	//	}
	
	return sectionHeader;
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
	
	return [PrivateMessageUserTableViewCell getCellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;		// default implementation
	
	// return [groupData totalSectionCount];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // tag_more_rows
    return [[self dataList] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [PrivateMessageUserTableViewCell getCellIdentifier];
	PrivateMessageUserTableViewCell *cell = (PrivateMessageUserTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [PrivateMessageUserTableViewCell createCell];
	}
	
	// set text label
	int row = [indexPath row];	
	int count = [dataList count];
	if (row >= count){
		NSLog(@"[WARN] cellForRowAtIndexPath, row(%d) > data list total number(%d)", row, count);
		return cell;
	}
	
    //	[self setCellBackground:cell row:row count:count];        
	
	PrivateMessageUser* user = [dataList objectAtIndex:row];
    [cell setCellInfoWithMessageUser:user];    
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    // tag_more_rows
    if ([self isMoreRow:indexPath.row]){
        [self.moreLoadingView startAnimating];
        [self requestPrivateMessageListFromServer:NO];
        return;
    }
    
	if (indexPath.row > [dataList count] - 1)
		return;

    PrivateMessageUser* user = [dataList objectAtIndex:indexPath.row];
    PrivateMessageListController* controller = [[PrivateMessageListController alloc] init];
    controller.messageUserId = user.userId;
    controller.messageUserNickName = user.userNickName;
    [self.superController.navigationController pushViewController:controller animated:YES];
    [controller release];
}


@end
