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
#import "ContollerConstants.h"
#import "FileUtil.h"
#import "SelectItemViewController.h"
#import "TextEditorViewController.h"
#import "VariableConstants.h"
#import "CityPickerViewController.h"
#import "PasswordInputController.h"
#import "NewUserRegisterController.h"
#import "GroupBuyUserService.h"
#import "GroupBuyNetworkConstants.h"
#import "GroupBuySNSService.h"

#import "CommonProductListController.h"
#import "ProductPriceDataLoader.h"
#import "GroupBuyControllerExt.h"
#import "UIImageUtil.h"
#import "UITableViewCellUtil.h"
#import "UINavigationBarExt.h"

#define FIRST_CELL_IMAGE    @"tu_56.png"
#define MIDDLE_CELL_IMAGE   @"tu_69.png"
#define LAST_CELL_IMAGE     @"tu_86.png"

#define TABLE_VIEW_FRAME        CGRectMake(8, 8, 304, 300)

enum{
    ACTION_SELECT_AVATAR,
    ACTION_SHARE_APP
};

enum{
    
    SECTION_INFO,
//    SECTION_SETTING,
    SECTION_SNS,
    SECTION_HISTORY,
    SECTION_FEEDBACK,
    SECTION_NUM
    
};

enum{
    ROW_NICKNAME,
    ROW_PASSWORD,
    ROW_CITY,
    ROW_INFO_NUM,
    
    // not used now
    ROW_GENDER,
    ROW_MOBILE,
};

enum{
    ROW_FEEDBACK,
    ROW_SHARE,
    ROW_FEEDBACK_NUM
};

enum{
    ROW_FAVORITE,
    ROW_HISTORY,
    ROW_HISTORY_NUM
};

//enum{
//    ROW_CITY,
//    ROW_SETTING_NUM
//};

enum{
    ROW_SINA,
    ROW_QQ,
    ROW_SNS_NUM,
    ROW_RENREN,
};

@implementation MyInfoController
@synthesize avatarImageView;
@synthesize tableBackgroundImageView;
@synthesize logoutButton;

@synthesize loginIdLabel;
@synthesize loginIdTypeLabel;
@synthesize avatarView;
@synthesize topBackgroundImageView;
@synthesize nicknameLabel;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

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
    
    self.navigationItem.title = @"我的设置";
    
    [self setGroupBuyNavigationTitle:self.navigationItem.title];
    [self setGroupBuyNavigationRightButton:@"保存" action:@selector(clickSave:)];
    
//    [self setFirstCellImageByView:[UIImage strectchableImageView:@"tu_56.png" viewWidth:300]];
//    [self setMiddleCellImageByView:[UIImage strectchableImageView:@"tu_69.png" viewWidth:300]];
//    [self setLastCellImageByView:[UIImage strectchableImageView:@"tu_68.png" viewWidth:300]];

    [self.topBackgroundImageView setImage:[UIImage strectchableTopImageName:@"tu_201.png"]];
    [self.tableBackgroundImageView setImage:[UIImage strectchableTopImageName:@"tu_203.png"]];
    
    logoutButton.hidden = YES;
    [self setBackgroundImageName:@"background.png"];
    
    self.navigationItem.hidesBackButton = YES;
    
    [super viewDidLoad];
    
    [self updateLoginId];
    [self updateImageView];
    [self initLogoutButton];
}

- (void)viewDidAppear:(BOOL)animated
{
//    GlobalSetNavBarBackground(@"navigationbar.png");
    
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
    [topBackgroundImageView release];
    topBackgroundImageView = nil;
    [self setTopBackgroundImageView:nil];
    [self setTableBackgroundImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [avatarImageView release];
    [logoutButton release];
    [topBackgroundImageView release];
    [topBackgroundImageView release];
    [tableBackgroundImageView release];
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
            return @"基本信息";
            
        case SECTION_SNS:
            return @"绑定账户";
            
//        case SECTION_SETTING:
//            return @"主要设置";

        case SECTION_HISTORY:
            return @"访问记录";
            
        case SECTION_FEEDBACK:
            return @"服务支持";
            
        default:            
            return 0;
    }
    
}

#define SECTION_HEIGHT 40

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    
    UIView* view = [[[UIView alloc] init] autorelease];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, SECTION_HEIGHT)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:190/255.0 green:184/255.0 blue:175/255.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    [view addSubview:label];
    [label release];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return SECTION_HEIGHT;
}

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
    return 74/2;    // the height of background image
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

        case SECTION_FEEDBACK:
            return ROW_FEEDBACK_NUM;
            
        case SECTION_HISTORY:
            return ROW_HISTORY_NUM;
            
        default:            
            return 0;
    }    
}

- (void)setNickNameCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kNickName");
    
    NSString* nickName = [[userService user] nickName];
    if ([nickName length] == 0){
        cell.detailTextLabel.text = @"未设置";        
    }
    else{
        cell.detailTextLabel.text = [[userService user] nickName];        
    }    

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [PPViewController groupbuyAccessoryView];

}

- (void)setPasswordCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    
    NSString* password = [[userService user] password];
    if ([password length] == 0){
        cell.textLabel.text = @"密码";
        cell.detailTextLabel.text = @"电子邮件未注册";        
    }
    else{
        cell.textLabel.text = @"修改密码";
        cell.detailTextLabel.text = @"";        
    }    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [PPViewController groupbuyAccessoryView];

}


- (void)setMobileCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kMobile");
    cell.detailTextLabel.text = [[userService user] mobile];    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [PPViewController groupbuyAccessoryView];

}

- (void)setGenderCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kGender");
    cell.detailTextLabel.text = [self genderTextByGender:[[userService user] gender]];    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [PPViewController groupbuyAccessoryView];

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

- (void)setCityCell:(UITableViewCell*)cell
{
    cell.textLabel.text = @"城市";    
    cell.detailTextLabel.text = [GlobalGetLocationService() getDefaultCity];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;    
    cell.accessoryView = [PPViewController groupbuyAccessoryView];

}

- (void)setCellInfo:(UITableViewCell*)cell text:(NSString*)text
{
    cell.textLabel.text = text;    
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   
    cell.accessoryView = [PPViewController groupbuyAccessoryView];

}

- (void)setSinaCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kSinaWeibo");
    
    BOOL bindFlag = [userService hasUserBindSina];
    cell.detailTextLabel.text = [self getBindText:bindFlag];
    if (bindFlag){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = [PPViewController groupbuyAccessoryView];
    }
}

- (void)setQQCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kQQWeibo");
    
    BOOL bindFlag = [userService hasUserBindQQ];
    cell.detailTextLabel.text = [self getBindText:bindFlag];
    if (bindFlag){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = [PPViewController groupbuyAccessoryView];
    }
    
}

- (void)setRenrenCell:(UITableViewCell*)cell
{
    UserService *userService = GlobalGetUserService();
    cell.textLabel.text = NSLS(@"kRenren");
    
    BOOL bindFlag = [userService hasUserBindRenren];
    cell.detailTextLabel.text = [self getBindText:bindFlag];
    if (bindFlag){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = [PPViewController groupbuyAccessoryView];
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"InfoCell";
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = nil;
	
    switch (indexPath.section) {
        case SECTION_INFO:
        {
            switch (indexPath.row) {
                case ROW_NICKNAME:
                    [self setNickNameCell:cell];
                    break;
                    
                case ROW_PASSWORD:
                    [self setPasswordCell:cell];
                    break;                    

                case ROW_MOBILE:
                    [self setMobileCell:cell];
                    break;
                    
                case ROW_GENDER:
                    [self setGenderCell:cell];
                    break;

                case ROW_CITY:
                    [self setCityCell:cell];
                    break;

                default:
                    break;
            }
        }
            break;

        case SECTION_HISTORY:
        {
            switch (indexPath.row) {
                case ROW_HISTORY:
                    [self setCellInfo:cell text:@"团购浏览记录"];
                    break;
                    
                case ROW_FAVORITE:
                    [self setCellInfo:cell text:@"团购收藏记录"];
                    break;
            }
        }
            break;
            
        case SECTION_FEEDBACK:
        {
            switch (indexPath.row) {
                case ROW_FEEDBACK:
                    [self setCellInfo:cell text:@"问题反馈，支持和建议"];
                    break;
                    
                case ROW_SHARE:
                    [self setCellInfo:cell text:@"分享应用给朋友"];
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
    
    cell.textLabel.textColor = [UIColor colorWithRed:111/255.0 green:104/255.0 blue:94/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:163/255.0 green:155/255.0 blue:143/255.0 alpha:1.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];

    int count = [self tableView:self.dataTableView numberOfRowsInSection:indexPath.section];
    [cell setCellBackgroundForRow:indexPath.row rowCount:count singleCellImage:nil firstCellImage:FIRST_CELL_IMAGE  middleCellImage:MIDDLE_CELL_IMAGE lastCellImage:LAST_CELL_IMAGE cellWidth:300];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    CGRect frame = cell.frame;
//    frame.size.width = 200;
//    frame.origin.x = 100;
//    cell.frame = frame;    
    
	return cell;
	
}

- (void)clickCity
{
    NSString* city = [GlobalGetLocationService() getDefaultCity];
    CityPickerViewController* vc = [[CityPickerViewController alloc] initWithCityName:city hasLeftButton:YES];
    vc.delegate = self;
    [vc enableGroupBuySettings];    
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController presentModalViewController:vc animated:YES];
    [vc release];
}

-(void) dealWithPickedCity:(NSString *)city
{
    [GlobalGetLocationService() setDefaultCity:city];    
}

- (void)actionDone:(int)resultCode
{
    if (resultCode == 0){
        [[self dataTableView] reloadData];
    }
}

- (void)clickBindSina
{
    UserService *userService = GlobalGetUserService();
    if ([userService hasUserBindSina])
        return;
    
    GroupBuySNSService *snsService = GlobalGetGroupBuySNSService();
    [snsService sinaInitiateLogin:self];
}

- (void)clickBindQQ
{
    UserService *userService = GlobalGetUserService();
    if ([userService hasUserBindQQ])
        return;
    
    GroupBuySNSService *snsService = GlobalGetGroupBuySNSService();
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
                        [self popupMessage:@"昵称不能为空吧" title:@""];
                        return;
                    }
                    [userService updateUserNickName:newText];

                    if ([newText length] > 0){
                        [self popupHappyMessage:@"别忘了点击右上角的［保存］按钮保存修改哦" title:nil];
                    }
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
                    vc.allowNull = NO;
                    vc.noRoundRect = YES;
                    [vc setGroupBuyNavigationBackButton];
                    [vc setGroupBuyNavigationTitle:vc.navigationItem.title];
                    [vc setBackgroundImageName:@"background.png"];
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                    break;
                    
                case ROW_PASSWORD:
                {
                    if ([GlobalGetUserService() hasBindEmail]){
                        NSString* password = [[GlobalGetUserService() user] password];
                        PasswordInputController* vc = [[PasswordInputController alloc] initWithPassword:password delegate:self];
                        vc.canReturn = YES;
                        vc.navigationItem.title = NSLS(@"修改密码");
                        [vc setBackgroundImageName:@"background.png"];
                        [vc setGroupBuyNavigationBackButton];
                        [vc setGroupBuyNavigationTitle:vc.navigationItem.title];
                        [vc setCellBackgroundFirstCellImage:FIRST_CELL_IMAGE
                                            middleCellImage:MIDDLE_CELL_IMAGE
                                              lastCellImage:LAST_CELL_IMAGE];
                        [vc setTableViewFrame:CGRectMake(8, 8, 304, 300)];
                        [vc setButtonBackgroundImage:@"tu_126-53.png"];
                        [self.navigationController pushViewController:vc animated:YES];
                        [vc release];                        
                    }
                    else{
                        [NewUserRegisterController showController:nil password:nil superController:self];
                    }                    
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

                case ROW_CITY:
                    [self clickCity];
                    break;

                default:
                    break;
            }
        }
            break;
            
            //	CommonProductListController* favorController = (CommonProductListController*)[UIUtils addViewController:[CommonProductListController alloc]
            //					 viewTitle:@"收藏"				 
            //					 viewImage:@"folder_bookmark_24.png"
            //			  hasNavController:YES			
            //			   viewControllers:controllers];	
            //    favorController.dataLoader = [[ProductFavoriteDataLoader alloc] init];
            //    
            //    CommonProductListController* historyController = (CommonProductListController*)[UIUtils addViewController:[CommonProductListController alloc]
            //					 viewTitle:@"历史"				 
            //					 viewImage:@"storage.png"
            //			  hasNavController:YES			
            //			   viewControllers:controllers];	
            //    historyController.dataLoader = [[ProductHistoryDataLoader alloc] init];
            //    
            //    [UIUtils addViewController:[SettingsController alloc]
            //					 viewTitle:@"设置"				 
            //					 viewImage:@"gear_24.png"
            //			  hasNavController:YES			
            //			   viewControllers:controllers];	
            //        
            //	[UIUtils addViewController:[FeedbackController alloc]
            //					 viewTitle:@"反馈"
            //					 viewImage:@"help_24.png"
            //			  hasNavController:YES			
            //			   viewControllers:controllers];	
            

        case SECTION_HISTORY:
        {
            switch (indexPath.row) {
                case ROW_HISTORY:
                {
                    CommonProductListController* vc = [[CommonProductListController alloc] init];
                    vc.dataLoader = [[[ProductHistoryDataLoader alloc] init] autorelease];
                    vc.navigationItem.title = @"历史记录";
                    [vc setBackgroundImageName:@"background.png"];
                    [vc setGroupBuyNavigationBackButton];            
                    [vc setGroupBuyNavigationTitle:vc.navigationItem.title];
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                    
                }
                    break;
                    
                case ROW_FAVORITE:
                {
                    CommonProductListController* vc = [[CommonProductListController alloc] init];
                    vc.dataLoader = [[[ProductFavoriteDataLoader alloc] init] autorelease];
                    vc.navigationItem.title = @"收藏";
                    [vc setBackgroundImageName:@"background.png"];
                    [vc setGroupBuyNavigationBackButton];    
                    [vc setGroupBuyNavigationTitle:vc.navigationItem.title];
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];                    
                }
                    break;
            }
        }
            break;
            
        case SECTION_FEEDBACK:
        {
            switch (indexPath.row) {
                case ROW_FEEDBACK:
                    [self clickFeedback:nil];
                    break;
                    
                case ROW_SHARE:
                    [self clickSendAppLink:nil];
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
    [self showActivityWithText:@"保存数据中..."];
    UserService *userService = GlobalGetUserService();
    [userService groupBuyUpdateUser:self successHandler:^(PPViewController* viewController, int result){   
        [self hideActivity];
        if (result == 0){
            [userService updateUserPasswordByNewPassword];
            
            MyInfoController *vc = (MyInfoController*)viewController;        
            [vc.dataTableView reloadData];
            [vc updateImageView];
        }        
    }];
}

- (IBAction)clickAvatar:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLS(@"kSelectFromAlbum"), NSLS(@"kTakePhoto"), nil];
    action = ACTION_SELECT_AVATAR;
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
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        [self setUserAvatar:image];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}



+ (MyInfoController*)show:(UINavigationController*)navgivationController
{
    MyInfoController* infoController = [[MyInfoController alloc] init];
    [navgivationController pushViewController:infoController animated:NO];
    [infoController release];
    return infoController;
}

- (void)didPasswordChange:(NSString *)newPassword
{   
    NSLog(@"new password = %@", newPassword);
    [GlobalGetUserService() setNewPassword:newPassword];

    if ([newPassword length] > 0){
        [self popupHappyMessage:@"别忘了点击右上角的［保存］按钮保存密码修改哦" title:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{		
	NSLog(@"<sendSms> result=%d", result);	
    GlobalSetNavBarBackground(@"navigationbar.png");
	[self dismissModalViewControllerAnimated:YES];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	NSString* text = nil;
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: canceled";
			break;
		case MFMailComposeResultSaved:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: saved";
			break;
		case MFMailComposeResultSent:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: sent";
			break;
		case MFMailComposeResultFailed:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: failed";
			break;
		default:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: not sent";
			break;
	}
	
	NSLog(@"%@", text);
    GlobalSetNavBarBackground(@"navigationbar.png");    
	[self dismissModalViewControllerAnimated:YES];
    
}


- (IBAction)clickFeedback:(id)sender
{    
    GlobalSetNavBarBackground(nil);
    
    [self sendEmailTo:[NSArray arrayWithObject:@"zz2010.support@gmail.com"] 
		 ccRecipients:nil 
		bccRecipients:nil 
			  subject:NSLS(@"kFeedbackSubject")
				 body:NSLS(@"") 
			   isHTML:NO 
			 delegate:self];
}

- (IBAction)clickSendAppLink:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLS(@"kSendBySMS"), NSLS(@"kSendByEmail"), nil];
    
    action = ACTION_SHARE_APP;

    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    [actionSheet release];
}

- (void)handleSendAppLinkClick:(NSInteger)buttonIndex
{
    NSString* appLink = [UIUtils getAppLink:kAppId];
    NSString* body = [NSString stringWithFormat:NSLS(@"kSendAppLinkBody"), appLink];
    NSString* subject = NSLS(@"kSendAppLinkSubject");
    
    enum{
        BUTTON_SEND_BY_SMS,
        BUTTON_SEND_BY_EMAIL,
        BUTTON_CANCEL
    };
    
    switch (buttonIndex) {
        case BUTTON_SEND_BY_SMS:
        {
            GlobalSetNavBarBackground(nil);
            [self sendSms:@"" body:body];
        }
            break;
            
        case BUTTON_SEND_BY_EMAIL:
        {
            GlobalSetNavBarBackground(nil);
            [self sendEmailTo:nil ccRecipients:nil bccRecipients:nil subject:subject body:body isHTML:NO delegate:self];
        }
            break;
            
        default:
            break;
    }
}

- (void)handleSelectAvatar:(int)buttonIndex
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (action == ACTION_SHARE_APP){
        [self handleSendAppLinkClick:buttonIndex];
    }
    else {
        [self handleSelectAvatar:buttonIndex];
    }
         
}

@end
