//
//  PlaceControllerUtils.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaceControllerUtils.h"
#import "Place.h"
#import "PostListController.h"
#import "groupbuyAppDelegate.h"
#import "LocationService.h"

@implementation PlaceControllerUtils

+ (void)setCellStyle:(UITableViewCell*)cell
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;		
    
    cell.textLabel.textColor = [UIColor colorWithRed:0x3e/255.0 green:0x34/255.0 blue:0x53/255.0 alpha:1.0];
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0x84/255.0 green:0x79/255.0 blue:0x94/255.0 alpha:1.0];			
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

}

+ (void)setCellInfoWithDict:(NSDictionary*)dict cell:(UITableViewCell*)cell
{
    
}

+ (void)setCellInfoWithPlace:(Place*)place cell:(UITableViewCell*)cell
{
    LocationService *locationService = GlobalGetLocationService();
    if (locationService.currentLocation == nil){
        cell.textLabel.text = place.name;
        cell.detailTextLabel.text = place.desc;
        return;
    }

    CLLocation* placeLocation = [[CLLocation alloc] initWithLatitude:[place.latitude doubleValue] longitude:[place.longitude doubleValue]];
    int distance = (int)[locationService.currentLocation distanceFromLocation:placeLocation];
         
    NSString *distance_string = [NSString stringWithFormat:NSLS(@"kDistance"), distance];
    cell.textLabel.text = [NSString stringWithFormat:@"%@    (%@)", place.name, distance_string];
    cell.detailTextLabel.text = place.desc;    
                      
    [placeLocation release];                
}

+ (void)gotoPlacePostListController:(UIViewController*)superController place:(Place*)place
{
    PostListController* postListController = [[PostListController alloc] init];
    postListController.place = place;
    //    if (SELECT_NEARBY == segSelectIndex) {
    //        postListController.navigationItem.leftBarButtonItem.title = NSLS(@"kAroundPlace");
    //    } else {
    //        postListController.navigationItem.leftBarButtonItem.title = NSLS(@"kMyPlace");
    //    }
    postListController.navigationItem.title = place.name;
    superController.hidesBottomBarWhenPushed = YES;
    [superController.navigationController pushViewController:postListController animated:YES];
    [postListController release];
}

+ (NSString*)getLastPlaceId:(NSArray*)dataList
{
    NSString* placeId = nil;
    int count = [dataList count];
    if (count > 0){
        Place* place = [dataList objectAtIndex:count-1];
        placeId = place.placeId;
    }
    
    return placeId;
}

@end
