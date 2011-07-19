//
//  PostActionCell.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PostActionCell.h"


@implementation PostActionCell
@synthesize likeButton;
@synthesize sendMessageButton;
@synthesize delegate;
@synthesize indexPath;

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
    [likeButton release];
    [sendMessageButton release];
    [indexPath release];
    [super dealloc];
}

- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;		   
}

- (void)awakeFromNib{
    [self setCellStyle];
}

+ (PostActionCell*)createCell:(id<PostActionCellDelegate>)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PostActionCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"<createPostActionCell> but cannot find cell object");
        return nil;
    }
    
    ((PostActionCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    
    return (PostActionCell*)[topLevelObjects objectAtIndex:0];
}

+ (NSString*)getCellIdentifier
{
    return @"PostActionCell";
}

+ (CGFloat)getCellHeight
{
    return 44.0f;
}

- (IBAction)clickLikeButton:(id)sender
{
    if ([delegate respondsToSelector:@selector(clickLikeButton:atIndexPath:)]){
        [delegate clickLikeButton:sender atIndexPath:indexPath];
    }
}

- (IBAction)clickSendMessageButton:(id)sender
{
    if ([delegate respondsToSelector:@selector(clickSendMessageButton:atIndexPath:)]){
        [delegate clickSendMessageButton:sender atIndexPath:indexPath];
    }    
}

@end
