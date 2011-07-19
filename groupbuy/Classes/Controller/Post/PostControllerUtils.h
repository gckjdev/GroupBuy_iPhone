//
//  PostControllerUtils.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPViewController;
@class Post;

@interface PostControllerUtils : NSObject {
 
    NSString* placeId;
    NSString* placeName;
    PPViewController* viewController;
}

@property (nonatomic, retain) NSString* placeId;
@property (nonatomic, retain) NSString* placeName;
@property (nonatomic, retain) PPViewController* viewController;


+ (void)setCellStyle:(UITableViewCell*)cell;
+ (void)setCellInfoWithDict:(NSDictionary*)dict cell:(UITableViewCell*)cell;
+ (void)setCellInfoWithPost:(Post*)post cell:(UITableViewCell*)cell;
+ (void)gotoPostController:(UIViewController*)superController post:(Post*)post;
+ (CGFloat)getCellHeight;
   
+ (void)askFollowPlace:(NSString*)placeId placeName:(NSString*)placeName viewController:(PPViewController*)viewController;

+ (NSString*)getLastPostId:(NSArray*)dataList;

@end
