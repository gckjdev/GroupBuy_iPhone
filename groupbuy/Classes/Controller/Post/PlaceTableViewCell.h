//
//  PlaceTableViewCell.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceTableViewCellDelegate <NSObject>

- (void)clickActionButton:(id)sender atRow:(NSUInteger)row;

@end

@interface PlaceTableViewCell : UITableViewCell {
    
    IBOutlet UIButton   *actionButton;
    UILabel *placeNameLabel;
    UILabel *placeDescLabel;
    NSUInteger rowNumber;
    id<PlaceTableViewCellDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UIButton   *actionButton;
@property (nonatomic, retain) IBOutlet UILabel *placeNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *placeDescLabel;
@property (nonatomic, assign) NSUInteger rowNumber;
@property (nonatomic, assign) id<PlaceTableViewCellDelegate> delegate;

- (IBAction)clickActionButton:(id)sender;

@end
