//
//  PlaceTableViewCell.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaceTableViewCell.h"


@implementation PlaceTableViewCell

@synthesize actionButton;
@synthesize placeNameLabel;
@synthesize placeDescLabel;
@synthesize rowNumber;
@synthesize delegate;

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

- (void)awakeFromNib{
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)dealloc
{
    [actionButton release];
    [placeNameLabel release];
    [placeDescLabel release];
    [super dealloc];
}

- (IBAction)clickActionButton:(id)sender
{
    if (delegate != nil && [delegate respondsToSelector:@selector(clickActionButton:atRow:)]){
        [delegate clickActionButton:sender atRow:rowNumber];
    }
}

@end
