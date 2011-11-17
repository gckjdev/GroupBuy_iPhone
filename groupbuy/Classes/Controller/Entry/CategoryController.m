//
//  CategoryController.m
//  groupbuy
//
//  Created by  on 11-9-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CategoryController.h"
#import "CommonProductListController.h"
#import "ProductPriceDataLoader.h"
#import "CategoryTopScoreController.h"
#import "GroupBuyNetworkConstants.h"
#import "groupbuyAppDelegate.h"
#import "GroupBuyControllerExt.h"

@implementation CategoryController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
}

#pragma mark - View lifecycle

- (void)loadCategory
{
    [self showActivityWithText:@"加载数据中..."];
    CategoryService *service = GlobalGetCategoryService();
    [service getAllCategory:self];    
}

- (void)getAllCategoryFinish:(int)result jsonArray:(NSArray *)jsonArray
{
    [self hideActivity];
    
    self.dataList = jsonArray;
    [self.dataTableView reloadData];
    
    if (self.dataList == nil || [self.dataList count] == 0){
        NSLog(@"<warning> no category data, result = %d", result);
//        self.dataList = [CategoryManager getAllGroupBuyCategories];
    }
}

- (void)viewDidLoad
{
    [self setGroupBuyNavigationTitle:@"分类排行"];
    [self setBackgroundImageName:@"background.png"];
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    [self loadCategory];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.dataList == nil){
        CategoryService *service = GlobalGetCategoryService();
        [service getAllCategory:self];
    }
    
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

- (void)showProductByCategory:(NSIndexPath *)indexPath
{
    NSDictionary *category = [self.dataList objectAtIndex:indexPath.row];
    NSString *categoryName = [category objectForKey:PARA_CATEGORY_NAME];
    NSString *categoryId = [category objectForKey:PARA_CATEGORY_ID];
    //NSString *categoryId = [CategoryManager getGroupBuyCategoryIdByName:categoryName];
    
    CategoryTopScoreController *controller = [[[CategoryTopScoreController alloc] init] autorelease];
           
    controller.categoryId = categoryId;
    controller.categoryName = categoryName;
    
    [controller setGroupBuyNavigationBackButton];    
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    NSDictionary *category = [self.dataList objectAtIndex:indexPath.row];
    NSString *name = [category objectForKey:PARA_CATEGORY_NAME];
    NSNumber *n = [category objectForKey:PARA_CATEGORY_PRODUCTS_NUM];
    NSString *number = [NSString stringWithFormat:@"(%@)", n];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", name, number];
    //cell.textLabel.text = name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"(%@)               ", number];
    
    int cellHeight = 56;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    CGSize size = [name sizeWithFont:nameLabel.font];
    CGFloat x = 10;
    CGFloat y = (cellHeight - size.height) / 2;
    nameLabel.frame = CGRectMake(x, y, size.width, size.height);
    nameLabel.text = name;
    nameLabel.textColor = [UIColor colorWithRed:111/255.0 green:104/255.0 blue:94/255.0 alpha:1.0];
    [cell.contentView addSubview:nameLabel];
    [nameLabel release];
    
    x = x + size.width + 5;
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0];
    size = [number sizeWithFont:numberLabel.font];
    y = (cellHeight - size.height) / 2;
    numberLabel.frame = CGRectMake(x, y, size.width, size.height);
    numberLabel.text = number;
    numberLabel.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:numberLabel];
    [numberLabel release];
    
    // add line image
    UIImage* dotlineImage = [UIImage imageNamed:@"tu_179.png"];
    UIImageView* dotlineImageView = [[UIImageView alloc] initWithImage:dotlineImage];
    dotlineImageView.frame = CGRectMake(7, cellHeight - dotlineImage.size.height, cell.contentView.bounds.size.width-7*2, dotlineImage.size.height);
    [cell.contentView addSubview:dotlineImageView];
    [dotlineImageView release];
    
    [cell setAccessoryView:[PPViewController groupbuyAccessoryView]];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *categoryName = [self.dataList objectAtIndex:indexPath.row];
    [self showProductByCategory:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

@end
