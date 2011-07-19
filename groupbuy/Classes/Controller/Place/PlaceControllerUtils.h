//
//  PlaceControllerUtils.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Place;

@interface PlaceControllerUtils : NSObject {
    
}

+ (void)setCellStyle:(UITableViewCell*)cell;
+ (void)setCellInfoWithDict:(NSDictionary*)dict cell:(UITableViewCell*)cell;
+ (void)setCellInfoWithPlace:(Place*)place cell:(UITableViewCell*)cell;
+ (void)gotoPlacePostListController:(UIViewController*)superController place:(Place*)place;

+ (NSString*)getLastPlaceId:(NSArray*)dataList;

@end
