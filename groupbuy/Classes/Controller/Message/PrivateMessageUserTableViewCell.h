//
//  PrivateMessageUserTableViewCell.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrivateMessageUser;
@class HJManagedImageV; 

@interface PrivateMessageUserTableViewCell : UITableViewCell {
    
    HJManagedImageV *userAvatarView;
    UILabel *userNickNameLabel;
    UILabel *contentLable;
    UILabel *createDateLabel;
}

+ (NSString*)getCellIdentifier;
+ (PrivateMessageUserTableViewCell*)createCell;
+ (CGFloat)getCellHeight;
- (void)setCellInfoWithMessageUser:(PrivateMessageUser*)user;

@property (nonatomic, retain) IBOutlet HJManagedImageV *userAvatarView;
@property (nonatomic, retain) IBOutlet UILabel *userNickNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *contentLable;
@property (nonatomic, retain) IBOutlet UILabel *createDateLabel;
@end
