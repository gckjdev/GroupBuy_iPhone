//
//  MyInfoController
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import "MyInfoController.h"
#import "UserManager.h"
#import "groupbuyAppDelegate.h"
#import "User.h"
#import "UserService.h"
#import "HJManagedImageV.h"
#import "UserService.h"
#import "ContollerConstants.h"
#import "FileUtil.h"
#import "PlaceSNSService.h"
#import "SelectItemViewController.h"
#import "TextEditorViewController.h"
#import "VariableConstants.h"

enum{
    
    SECTION_INFO,
    SECTION_SNS,
    SECTION_NUM
    
};

enum{
    ROW_NICKNAME,
    ROW_GENDER,
    ROW_MOBILE,
    ROW_INFO_NUM    
};

enum{
    ROW_SINA,
    ROW_QQ,
    ROW_SNS_NUM,
    ROW_RENREN,
};

@implementation MyInfoController
@synthesize avatarImageView;
@synthesize logoutButton;

@synthesize loginIdLabel;
@synthesize loginIdTypeLabel;
@synthesize avatarView;
@synthesize nicknameLabel;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

enum{
    ROW_MALE,
    ROW_FEMALE
};

- (NSString*)rowToGender:(int)row
{
    if (row == ROW_MALE){
        return GENDER_MALE;
    }
    else
        return GENDER_FEMALE;
}

- (int)genderToRow:(NSString*)gender
{
    if ([gender isEqualToString:GENDER_MALE]){
        return ROW_MALE;
    }
    else{
        return ROW_FEMALE;
    }
}

- (NSString*)genderTextByRow:(int)row
{
    if (ROW_MALE == row)
        return NSLS(@"Male");
    else
        return NSLS(@"Female");
}

- (NSString*)genderTextByGender:(NSString*)gender
{
    if ([gender isEqualToString:GENDER_MALE])
        return NSLS(@"Male");
    else
        return NSLS(@"Female");
}


- (void)updateLoginId
{
    UserService *userService = GlobalGetUserService();
    NSString* displayId = [userService getLoginIdForDisplay];
    loginIdLabel.text = displayId;
}

- (void)updateImageView
{
    UserService *userService = GlobalGetUserService();    
    
    // clear cache
    [self.avatarImageView clear];    
    
    // set new
    self.avatarImageView.url = [userService getUserAvatarURL];
    
    [GlobalGetImageCache() manage:self.avatarImageView];    
}

- (void)initLogoutButton
{
    [logoutButton setTitle:NSLS(@"Logout") forState:UIControlStateNormal];
//    logoutButton.hidden = YES;  // don't show it at this momement to make the app clear
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self updateLoginId];
    [self updateImageView];
    [self initLogoutButton];
    
    [self setNavigationRightButton:NSLS(@"Save") action:@selector(clickSave:)];
    
    self.dataTableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateImageView];
    [super viewDidAppear:animated];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setAvatarImageView:nil];
    [self setLogoutButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [avatarImageView release];
    [logoutButton release];
    [super dealloc];
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
        case SECTION_INFO:
            return @"";
            
        case SECTION_SNS:
            return @"";
            
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
        case SECTION_INFO:
            return 60;
            
        case SECTION_SNS:
            return 60;
            
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
        case SECTION_INFO:
            return ROW_INFO_NUM;
            break;
            
        case SECTION_SNS:
            return ROW_SNS_NUM;
            break;
            
        default:            
            return 0;
    }    
}

- (void)setNickNameCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kNickName");
    cell.detailTextLabel.text = [[userService user] nickName];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setMobileCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kMobile");
    cell.detailTextLabel.text = [[userService user] mobile];    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setGenderCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kGender");
    cell.detailTextLabel.text = [self genderTextByGender:[[userService user] gender]];    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (NSString*)getBindText:(BOOL)bindFlag
{
    if (bindFlag){
        return NSLS(@"kBind");
    }
    else{
        return NSLS(@"kNotBind");        
    }
}

- (UITableViewCellAccessoryType)getBindAccessoryType:(BOOL)bindFlag
{
    if (bindFlag){
        return UITableViewCellAccessoryNone;
    }
    else{
        return UITableViewCellAccessoryDisclosureIndicator;
    }
}


- (void)setSinaCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kSinaWeibo");
    
    BOOL bindFlag = [userService hasUserBindSina];
    cell.detailTextLabel.text = [self getBindText:bindFlag];
    cell.accessoryType = [self getBindAccessoryType:bindFlag];    
}

- (void)setQQCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kQQWeibo");
    
    BOOL bindFlag = [userService hasUserBindQQ];
    cell.detailTextLabel.text = [self getBindText:bindFlag];
    cell.accessoryType = [self getBindAccessoryType:bindFlag];    
    
}

- (void)setRenrenCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kRenren");
    
    BOOL bindFlag = [userService hasUserBindRenren];
    cell.detailTextLabel.text = [self getBindText:bindFlag];
    cell.accessoryType = [self getBindAccessoryType:bindFlag];    
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"InfoCell";
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	
    switch (indexPath.section) {
        case SECTION_INFO:
        {
            switch (indexPath.row) {
                case ROW_NICKNAME:
                    [self setNickNameCell:cell];
                    break;

                case ROW_MOBILE:
                    [self setMobileCell:cell];
                    break;
                    
                case ROW_GENDER:
                    [self setGenderCell:cell];
                    break;

                default:
                    break;
            }
        }
            break;
            
        case SECTION_SNS:
        {
            switch (indexPath.row) {
                case ROW_SINA:
                    [self setSinaCell:cell];
                    break;
                    
                case ROW_QQ:
                    [self setQQCell:cell];
                    break;
                    
                case ROW_RENREN:
                    [self setRenrenCell:cell];
                    break;

                default:
                    break;
            }
        }
            break;
            
        default:            
            break;
    }        
	
	return cell;
	
}

- (void)clickBindSina
{
    UserService *userService = GlobalGetUserService();
    if ([userService hasUserBindSina])
        return;
    
    PlaceSNSService *snsService = GlobalGetSNSService();
    [snsService sinaInitiateLogin:self];
}

- (void)clickBindQQ
{
    UserService *userService = GlobalGetUserService();
    if ([userService hasUserBindQQ])
        return;
    
    PlaceSNSService *snsService = GlobalGetSNSService();
    [snsService qqInitiateLogin:self];    
}

- (void)clickBindRenren
{
    
}

// delegate to change text for TextEditController
- (void)textChanged:(NSString*)newText
{
    UserService* userService = GlobalGetUserService();                    

    switch (selectSection) {
        case SECTION_INFO:
            switch (selectRow) {
                case ROW_NICKNAME:
                {
                    if ([newText length] == 0){
                        [self popupMessage:NSLS(@"kNickNameNotNull") title:@""];
                        return;
                    }
                    [userService updateUserNickName:newText];
                }
                    break;
                    
                case ROW_MOBILE:
                {
                    [userService updateUserMobile:newText];                    
                }
                    break;                                        
                    
                default:
                    break;
            }
            
            break;
    }
}


- (BOOL)shouldContinueAfterRowSelect:(int)row
{
    UserService* userService = GlobalGetUserService();  
    [userService updateUserGender:[self rowToGender:row]];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [self updateSelectSectionAndRow:indexPath];
    
    switch (indexPath.section) {
        case SECTION_INFO:
        {
            switch (indexPath.row) {
                case ROW_NICKNAME:
                {
                    UserService* userService = GlobalGetUserService();                    
                    
                    TextEditorViewController* vc = [[TextEditorViewController alloc] init];
                    vc.isSingleLine = YES;
                    vc.delegate = self;
                    vc.inputText = [[userService user] nickName];
                    vc.navigationItem.title = NSLS(@"kEnterNickNameTitle");
                    vc.view.backgroundColor = [UIColor whiteColor]; // to be removed
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                    break;
                    
                case ROW_MOBILE:
                {
                    UserService* userService = GlobalGetUserService();                    
                    
                    TextEditorViewController* vc = [[TextEditorViewController alloc] init];
                    vc.isSingleLine = YES;
                    vc.inputText = [[userService user] mobile];
                    vc.inputPlaceHolder = NSLS(@"kEnterMobileNumber");
                    vc.isNumber = YES;
                    vc.delegate = self;
                    vc.navigationItem.title = NSLS(@"kEnterMobileTitle");
                    vc.view.backgroundColor = [UIColor whiteColor]; // to be removed
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                    break;
                    
                case ROW_GENDER:
                {
                    UserService* userService = GlobalGetUserService();                    
                    
                    SelectItemViewController* vc = [[SelectItemViewController alloc] init];
                    [vc setDataList:[NSArray arrayWithObjects:
                                     [self genderTextByRow:ROW_MALE], 
                                     [self genderTextByRow:ROW_FEMALE], nil]];
                    
                    [vc setInputSelectRow:[self genderToRow:[userService.user gender]]];	
                    vc.delegate = self;
                    vc.navigationItem.title = NSLS(@"kSetGender");
                    vc.view.backgroundColor = [UIColor whiteColor]; // to be removed
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                    break;

                default:
                    break;
            }
        }
            break;
            
        case SECTION_SNS:
        {
            switch (indexPath.row) {
                case ROW_SINA:
                    [self clickBindSina];
                    break;
                    
                case ROW_QQ:
                    [self clickBindQQ];                     
                    break;
                    
                case ROW_RENREN:
                    [self clickBindRenren];
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:            
            break;
    }        

    
}


#pragma mark - Button Action

- (IBAction)clickLogout:(id)sender {

    
    UserService* userService = GlobalGetUserService();
    [userService logoutUser];
    
    groupbuyAppDelegate *delegate = (groupbuyAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate removeMainView];
    [delegate addRegisterView];
}



SaveUserSuccessHandler saveSuccessHandler = ^(PPViewController* viewController){ // no use now

    MyInfoController *vc = (MyInfoController*)viewController;
    
    [vc.dataTableView reloadData];
    [vc updateImageView];
};

- (void)clickSave:(id)sender
{
    // send request to server
    UserService *userService = GlobalGetUserService();
    [userService updateUserToServer:self successHandler:^(PPViewController* viewController){        
        MyInfoController *vc = (MyInfoController*)viewController;        
        [vc.dataTableView reloadData];
        [vc updateImageView];
    }];
}

- (IBAction)clickAvatar:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLS(@"kSelectFromAlbum"), NSLS(@"kTakePhoto"), nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (void)setUserAvatar:(UIImage*)image
{    
    UserService* userService = GlobalGetUserService();
    [userService updateUserAvatar:image];    
    
    // update GUI
    [self updateImageView];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil){
        [self setUserAvatar:image];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    enum{
        BUTTON_SELECT_ALBUM,
        BUTTON_TAKE_PHOTO,
        BUTTON_CANCEL
    };
    
    switch (buttonIndex) {
        case BUTTON_SELECT_ALBUM:
            [self selectPhoto];
            break;
            
        case BUTTON_TAKE_PHOTO:
            [self takePhoto];
            break;

        default:
            break;
    }
}


@end
