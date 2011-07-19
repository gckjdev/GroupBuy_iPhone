//
//  PrivateMessageTableViewCell.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrivateMessage;

@interface PrivateMessageTableViewCell : UITableViewCell {
    
    UILabel *messageLabel;
    UILabel *dateLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;

+ (NSString*)getCellIdentifier;
+ (PrivateMessageTableViewCell*)createCell;
+ (CGFloat)getCellHeight;
- (void)setCellInfoWithMessage:(PrivateMessage*)message;

@end
