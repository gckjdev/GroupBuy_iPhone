//
//  HelpWritePostCell.m
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HelpWritePostCell.h"


@implementation HelpWritePostCell
@synthesize questionLabel;
@synthesize answerTextField;

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
    [questionLabel release];
    [answerTextField release];
    [super dealloc];
}

+ (HelpWritePostCell*)createCell:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HelpWritePostCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <HelpWritePostCell> but cannot find cell object from Nib");
        return nil;
    }
    
    ((PPTableViewCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    
    return (HelpWritePostCell*)[topLevelObjects objectAtIndex:0];
}

+ (NSString*)getCellIdentifier
{
    return @"HelpWritePostCell";
}

+ (CGFloat)getCellHeight
{
    return 75.0f;
}

- (IBAction)textDidBeginEditing:(id)sender
{
    if ([delegate respondsToSelector:@selector(textDidBeginEditing:atIndexPath:)]){
        [delegate textDidBeginEditing:sender atIndexPath:indexPath];
    }
}

- (IBAction)textDidEndOnExit:(id)sender
{
    if ([delegate respondsToSelector:@selector(textDidEndOnExit:atIndexPath:)]){
        [delegate textDidEndOnExit:sender atIndexPath:indexPath];
    }        
}

- (IBAction)textDidChange:(id)sender
{
    if ([delegate respondsToSelector:@selector(textDidChange:atIndexPath:)]){
        [delegate textDidChange:sender atIndexPath:indexPath];
    }            
}

@end
