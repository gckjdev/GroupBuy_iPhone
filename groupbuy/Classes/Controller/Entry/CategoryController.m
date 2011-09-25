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
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    CGSize size = [name sizeWithFont:nameLabel.font];
    CGFloat x = 10;
    CGFloat y = (56 - size.height) / 2;
    nameLabel.frame = CGRectMake(x, y, size.width, size.height);
    nameLabel.text = name;
    [cell.contentView addSubview:nameLabel];
    
    x = x + size.width + 5;
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.textColor = [UIColor grayColor];
    size = [number sizeWithFont:numberLabel.font];
    y = (56 - size.height) / 2;
    numberLabel.frame = CGRectMake(x, y, size.width, size.height);
    numberLabel.text = number;
    [cell.contentView addSubview:numberLabel];
    
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
