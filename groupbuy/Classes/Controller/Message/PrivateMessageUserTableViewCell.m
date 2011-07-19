//
//  PrivateMessageUserTableViewCell.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PrivateMessageUserTableViewCell.h"
#import "PrivateMessageUser.h"
#import "HJManagedImageV.h"
#import "PPApplication.h"
#import "FileUtil.h"
#import "UserService.h"     // to include DEFAULT_AVATAR

@implementation PrivateMessageUserTableViewCell
@synthesize userAvatarView;
@synthesize userNickNameLabel;
@synthesize contentLable;
@synthesize createDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [userAvatarView release];
    [userNickNameLabel release];
    [contentLable release];
    [createDateLabel release];
    [super dealloc];
}

+ (NSString*)getCellIdentifier
{
    return @"PrivateMessageUserCell";
}

- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;		   
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;        
}

- (void)awakeFromNib{
    [self setCellStyle];
}

+ (PrivateMessageUserTableViewCell*)createCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PrivateMessageUserCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"<createPrivateMessageUserTableViewCell> but cannot find cell object");
        return nil;
    }
    
    return (PrivateMessageUserTableViewCell*)[topLevelObjects objectAtIndex:0];
}

+ (CGFloat)getCellHeight
{
    return 60;
}

- (void)setCellInfoWithMessageUser:(PrivateMessageUser*)user
{
    self.userNickNameLabel.text = user.userNickName;
    self.contentLable.text = user.latestMessageContent;
    self.createDateLabel.text = [user.latestModifyDate description];
    
    [self.userAvatarView clear];
    if ([user.userAvatar length] > 0){
        self.userAvatarView.url = [NSURL URLWithString:user.userAvatar];
    }
    else{
        self.userAvatarView.url = [FileUtil bundleURL:DEFAULT_AVATAR];
    }
    [GlobalGetImageCache() manage:self.userAvatarView];
}

@end
