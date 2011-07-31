//
//  FeedbackController.h
//  Dipan
//
//  Created by qqn_pipi on 11-4-30.
//  Copyright 2011 QQN-PIPI.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"

@interface FeedbackController : PPViewController <UIActionSheetDelegate> {
 
    UILabel *feedbackLabel;
    UIButton *feedbackButton;
}
@property (nonatomic, retain) IBOutlet UILabel *feedbackLabel;
@property (nonatomic, retain) IBOutlet UIButton *feedbackButton;

- (IBAction)clickFeedback:(id)sender;
- (IBAction)clickSendAppLink:(id)sender;
@end
