//
//  HelpWritePostCell.h
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewCell.h"

@protocol HelpWritePostCellDelegate <NSObject>

@optional

- (void)textDidBeginEditing:(id)sender atIndexPath:(NSIndexPath*)indexPath;
- (void)textDidEndOnExit:(id)sender atIndexPath:(NSIndexPath*)indexPath;
- (void)textDidChange:(id)sender atIndexPath:(NSIndexPath*)indexPath;

@end

@interface HelpWritePostCell : PPTableViewCell {
    
    UILabel *questionLabel;
    UITextField *answerTextField;
}

+ (HelpWritePostCell*)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITextField *answerTextField;

- (IBAction)textDidBeginEditing:(id)sender;
- (IBAction)textDidEndOnExit:(id)sender;
- (IBAction)textDidChange:(id)sender;

@end
