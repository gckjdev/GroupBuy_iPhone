//
//  SelectPostPhotoController.h
//  Dipan
//
//  Created by qqn_pipi on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "PostService.h"

@interface SelectPostPhotoController : PPViewController <UIActionSheetDelegate, PostServiceDelegate> {
    
    UIView *selectPhotoLabel;
    UIButton *imageBackgroundButton;
    UIButton *submitButton;
    UIImageView *photoImageView;
    
    CGRect  initImageRect;
}

+ (SelectPostPhotoController*)showSelectPostPhotoController:(UIViewController*)viewController;
@property (nonatomic, retain) IBOutlet UIView *selectPhotoLabel;
@property (nonatomic, retain) IBOutlet UIButton *imageBackgroundButton;

@property (nonatomic, retain) IBOutlet UIButton *submitButton;
@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;

- (IBAction)clickSubmitButton:(id)sender;
- (IBAction)clickImageButton:(id)sender;

@end
