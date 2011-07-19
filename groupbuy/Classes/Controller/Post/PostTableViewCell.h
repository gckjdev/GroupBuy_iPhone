//
//  PostTableViewCell.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJManagedImageV.h"

@class Post;

@protocol PostTableViewCellDelegate <NSObject>

- (void)clickPlaceNameButton:(id)sender atIndexPath:(NSIndexPath*)indexPath;
- (void)clickUserAvatarButton:(id)sender atIndexPath:(NSIndexPath*)indexPath;
- (void)clickPostImageButton:(id)sender atIndexPath:(NSIndexPath*)indexPath;

@end

@interface PostTableViewCell : UITableViewCell <HJManagedImageVDelegate> {
    
    HJManagedImageV *userAvatarImage;
    UILabel *userNickNameLabel;
    UILabel *createDateLabel;
    UILabel *textContentLabel;
    UILabel *totalReplyLabel;
    HJManagedImageV *contentImage;
    UIButton *placeNameButton;
    UILabel *placeNameLabel;
    NSIndexPath *indexPath;
    
    id<PostTableViewCellDelegate> delegate;

    IBOutlet UIButton *userAvatarButton;
    IBOutlet UIButton *postImageButton;
}
@property (nonatomic, retain) IBOutlet HJManagedImageV *userAvatarImage;
@property (nonatomic, retain) IBOutlet UILabel *userNickNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *createDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *textContentLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalReplyLabel;
@property (nonatomic, retain) IBOutlet HJManagedImageV *contentImage;
@property (nonatomic, retain) IBOutlet UIButton *placeNameButton;
@property (nonatomic, retain) IBOutlet UILabel *placeNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *postImageButton;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) id<PostTableViewCellDelegate> delegate;

+ (PostTableViewCell*)createCell:(id<PostTableViewCellDelegate>)delegate;
+ (NSString*)getCellIdentifier;

- (void)setCellInfoWithDict:(NSDictionary*)dict indexPath:(NSIndexPath*)indexPath;
- (void)setCellInfoWithPost:(Post*)post indexPath:(NSIndexPath*)indexPath;
+ (CGFloat)getCellHeight;

- (IBAction)clickPlaceNameButton:(id)sender;
- (IBAction)clickUserAvatarButton:(id)sender;
- (IBAction)clickPostImageButton:(id)sender;
@end
