//
//  CreatePostController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "SelectPlaceController.h"
#import "Place.h"


@interface CreatePostController : PPTableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, SelectPlaceControllerDelegate> {
    
    Place *place;
    NSString *srcPostId;
    NSString *srcPlaceId;
    NSString *replyPostId;
    
    UIButton *syncSNSButton;
    UIButton *selectPlaceButton;
    UIButton *selectPhotoButton;
    UIButton *selectCameraButton;
    UITextView *contentTextView;
    
    NSMutableArray *photoArray;
    UISegmentedControl *contentTypeSegControl;
    UIImageView *contentImageView;
    BOOL            syncSNSStatus;
    
}
@property (nonatomic, retain) IBOutlet UIButton *syncSNSButton;
@property (nonatomic, retain) IBOutlet UIButton *selectPlaceButton;
@property (nonatomic, retain) IBOutlet UIButton *selectPhotoButton;
@property (nonatomic, retain) IBOutlet UIButton *selectCameraButton;
@property (nonatomic, retain) IBOutlet UITextView *contentTextView;

@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) NSString *srcPostId;
@property (nonatomic, retain) NSString *srcPlaceId;
@property (nonatomic, retain) NSString *replyPostId;

@property (nonatomic, retain) NSMutableArray *photoArray;
@property (nonatomic, retain) IBOutlet UISegmentedControl *contentTypeSegControl;
@property (nonatomic, retain) IBOutlet UIImageView *contentImageView;

- (UIImage*)getImage;
- (void)setImage:(UIImage*)image;

- (IBAction)clickSyncSNSButton:(id)sender;
- (IBAction)clickSelectPhoto:(id)sender;
- (IBAction)clickTakePhoto:(id)sender;
- (IBAction)clickSegControl:(id)sender;

- (IBAction)clickTag:(id)sender;

@end
