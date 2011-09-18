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

- (void)viewDidLoad
{
    [self setBackgroundImageName:@"background.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.dataList = [CategoryManager getAllGroupBuyCategories];
    CategoryService *service = GlobalGetCategoryService();
    [service getAllCategory:self];
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

- (void)getAllCategoryFinish:(int)result jsonArray:(NSArray *)jsonArray
{
    self.dataList = jsonArray;
    [self.dataTableView reloadData];
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
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *category = [self.dataList objectAtIndex:indexPath.row];
    NSString *name = [category objectForKey:PARA_CATEGORY_NAME];
    NSNumber *number = [category objectForKey:PARA_CATEGORY_PRODUCTS_NUM];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)", name, [number longValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *categoryName = [self.dataList objectAtIndex:indexPath.row];
    [self showProductByCategory:indexPath];
}

@end
