//
//  NewMakeFriendPostMainController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "UIRectTextView.h"
#import "HelpWritePostController.h"

@interface NewMakeFriendPostMainController : PPViewController <UITextViewDelegate, HelpWritePostControllerDelegate> {
    
    UILabel *newPostLabel;
    UIRectTextView *postContentTextView;
    UIButton *referButton;
    UIButton *helpButton;
}
@property (nonatomic, retain) IBOutlet UILabel *newPostLabel;
@property (nonatomic, retain) IBOutlet UIRectTextView *postContentTextView;
@property (nonatomic, retain) IBOutlet UIButton *referButton;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;

- (IBAction)clickReferButton:(id)sender;
- (IBAction)clickHelpButton:(id)sender;
- (IBAction)clickNext:(id)sender;

@end
