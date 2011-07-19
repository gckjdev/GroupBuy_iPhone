//
//  PostActionCell.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostActionCellDelegate <NSObject>

- (void)clickLikeButton:(id)sender atIndexPath:(NSIndexPath*)indexPath;

- (void)clickSendMessageButton:(id)sender atIndexPath:(NSIndexPath*)indexPath;

@end

@interface PostActionCell : UITableViewCell {
    
    UIButton *likeButton;
    UIButton *sendMessageButton;
    NSIndexPath *indexPath;
    
    id<PostActionCellDelegate> delegate;
}

+ (PostActionCell*)createCell:(id<PostActionCellDelegate>)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
@property (nonatomic, retain) IBOutlet UIButton *likeButton;
@property (nonatomic, retain) IBOutlet UIButton *sendMessageButton;
@property (nonatomic, assign) id<PostActionCellDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (IBAction)clickLikeButton:(id)sender;
- (IBAction)clickSendMessageButton:(id)sender;

@end
