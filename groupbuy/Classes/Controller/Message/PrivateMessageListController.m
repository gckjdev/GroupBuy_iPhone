//
//  PrivateMessageListController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PrivateMessageListController.h"
#import "MessageService.h"
#import "PrivateMessage.h"
#import "NetworkRequestResultCode.h"
#import "PrivateMessageManager.h"
#import "PrivateMessageTableViewCell.h"
#import "PrivateMessageControllerUtils.h"

@implementation PrivateMessageListController

@synthesize superController;
@synthesize messageUserId;
@synthesize messageUserNickName;

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
    [messageUserId release];
    [messageUserNickName release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)downloadMessageFinish:(int)result;
{    
    if (result == ERROR_SUCCESS){
        self.dataList = [PrivateMessageManager getAllMessageByUser:messageUserId];
        [self.dataTableView reloadData];
    }
    
    if ([self isReloading]){
        [self dataSourceDidFinishLoadingNewData];
    }
}

- (void)deleteMessageFinish:(int)result
{
    if (result == ERROR_SUCCESS){
        self.dataList = [PrivateMessageManager getAllMessageByUser:messageUserId];
        [self.dataTableView reloadData];
    }    
}

- (void)requestPrivateMessageListFromServer:(BOOL)isRequestLastest
{
    MessageService *messageService = GlobalGetMessageService();
    [messageService downloadNewMessage:self];
}

- (void)initDataList
{
    self.dataList = [PrivateMessageManager getAllMessageByUser:self.messageUserId];
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
    
    self.navigationItem.title = self.messageUserNickName;
    
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    [self setNavigationRightButton:NSLS(@"kReply") action:@selector(clickReply:)];
    
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
	
	return [PrivateMessageTableViewCell getCellHeight];
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
    
    NSString *CellIdentifier = [PrivateMessageTableViewCell getCellIdentifier];
	PrivateMessageTableViewCell *cell = (PrivateMessageTableViewCell*)[theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [PrivateMessageTableViewCell createCell];
	}
	
	// set text label
	int row = [indexPath row];	
	int count = [dataList count];
	if (row >= count){
		NSLog(@"[WARN] cellForRowAtIndexPath, row(%d) > data list total number(%d)", row, count);
		return cell;
	}
	
    //	[self setCellBackground:cell row:row count:count];        
	
	PrivateMessage* message = [dataList objectAtIndex:row];
    [cell setCellInfoWithMessage:message];    
	
	return cell;
	 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.row > [dataList count] - 1)
		return;    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row > [dataList count] - 1)
		return;    

	if (editingStyle == UITableViewCellEditingStyleDelete) {
        // send delete request
        MessageService *messageService = GlobalGetMessageService();        
        PrivateMessage* message = [dataList objectAtIndex:indexPath.row];
        [messageService deleteMessage:message viewController:self];
	}	
}

- (void)clickReply:(id)sender
{
    [PrivateMessageControllerUtils showPrivateMessageController:messageUserId
                                                   userNickName:messageUserNickName
                                                     userAvatar:nil
                                                 viewController:self];
}


@end
