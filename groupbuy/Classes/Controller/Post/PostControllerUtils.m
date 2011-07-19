//
//  PostControllerUtils.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PostControllerUtils.h"
#import "ResultUtils.h"
#import "Post.h"
#import "PostController.h"
#import "PlaceManager.h"
#import "LocalDataService.h"

PostControllerUtils* shareUtil;

@implementation PostControllerUtils

@synthesize placeId;
@synthesize placeName;
@synthesize viewController;

- (void)dealloc
{
    [placeId release];
    [placeName release];
    [viewController release];
    [super dealloc];
}

+ (PostControllerUtils*)shareUtil
{
    if (shareUtil == nil){
        shareUtil = [[PostControllerUtils alloc] init];
    }
    
    return shareUtil;
}

+ (void)setCellStyle:(UITableViewCell*)cell
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;		    
    cell.textLabel.textColor = [UIColor colorWithRed:0x3e/255.0 green:0x34/255.0 blue:0x53/255.0 alpha:1.0];    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0x84/255.0 green:0x79/255.0 blue:0x94/255.0 alpha:1.0];			

}

+ (void)setCellInfo:(UITableViewCell*)cell 
        textContent:(NSString*)textContent 
       userNickName:(NSString*)userNickName 
         createDate:(NSDate*)createDate
         totalReply:(int)totalReply
{
    cell.textLabel.text = textContent;
    cell.detailTextLabel.numberOfLines = 3;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"By : %@\nDate : %@\nTotal Reply : %d",
                                 userNickName,
                                 [createDate description],
                                 totalReply
                                 ];
    
}

+ (void)setCellInfoWithPost:(Post*)post cell:(UITableViewCell*)cell
{
    
    [PostControllerUtils setCellInfo:cell
                         textContent:post.textContent
                        userNickName:post.userNickName
                          createDate:post.createDate
                          totalReply:[post.totalReply intValue]];
    
}

+ (void)setCellInfoWithDict:(NSDictionary*)dict cell:(UITableViewCell*)cell
{
    [PostControllerUtils setCellInfo:cell
                         textContent:[ResultUtils textContent:dict]
                        userNickName:[ResultUtils nickName:dict]
                          createDate:[ResultUtils createDate:dict]
                          totalReply:[ResultUtils totalReply:dict]];
}

+ (void)gotoPostController:(UIViewController*)superController post:(Post*)post
{
    PostController *vc = [[PostController alloc] init];
    vc.post = post;
    superController.hidesBottomBarWhenPushed = YES;
    [superController.navigationController pushViewController:vc animated:YES];
    [vc release];

}

+ (CGFloat)getCellHeight
{
    return 100.0f;
}

+ (void)askFollowPlace:(NSString*)placeId placeName:(NSString*)placeName viewController:(PPViewController*)viewController
{
    if ([PlaceManager isPlaceFollowByUser:placeId] == YES){
        NSLog(@"<askFollowPlace> but place(%@,%@) has been followed by user", placeId, placeName);
        return;
    }
    
    NSString* message = [NSString stringWithFormat:NSLS(@"kAskFollowPlace"), placeName];
    PostControllerUtils* shareUtil = [PostControllerUtils shareUtil];
    shareUtil.viewController = viewController;
    shareUtil.placeId = placeId;
    shareUtil.placeName = placeName;
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:message                                                        
                                                       delegate:[PostControllerUtils shareUtil]
                                              cancelButtonTitle:NSLS(@"Cancel")
                                              otherButtonTitles:NSLS(@"Yes"), nil];
    
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    enum{
        BUTTON_CANCEL,
        BUTTON_YES
    };
    
    if (buttonIndex == BUTTON_YES){
        LocalDataService* localService = GlobalGetLocalDataService();
        [localService userFollowPlace:placeId placeName:placeName viewController:viewController];
    }
}

+ (NSString*)getLastPostId:(NSArray*)dataList
{
    NSString* postId = nil;
    int count = [dataList count];
    if (count > 0){
        Post* post = [dataList objectAtIndex:count-1];
        postId = post.postId;
    }
    
    return postId;
}

@end
