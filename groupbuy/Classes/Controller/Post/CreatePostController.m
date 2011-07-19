//
//  CreatePostController.m
//  Dipan
//
//  Created by qqn_pipi on 11-5-13.
//  Copyright 2011骞�__MyCompanyName__. All rights reserved.
//

#import "CreatePostController.h"
#import "CreatePostRequest.h"
#import "PostManager.h"
#import "UserManager.h"
#import "Post.h"
#import "AppManager.h"
#import "UIImageUtil.h"
#import "SelectPlaceController.h"

#define MAX_POST_TEXT_LEN 140

enum{
    SELECT_TEXT,
    SELECT_PHOTO
};

@implementation CreatePostController
@synthesize syncSNSButton;
@synthesize selectPlaceButton;
@synthesize selectPhotoButton;
@synthesize selectCameraButton;
@synthesize contentTextView;
@synthesize photoArray;
@synthesize contentTypeSegControl;
@synthesize contentImageView;
@synthesize place;
@synthesize srcPlaceId;
@synthesize srcPostId;
@synthesize replyPostId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [place release];
    [srcPlaceId release];
    [srcPostId release];
    [photoArray release];
    [syncSNSButton release];
    [selectPlaceButton release];
    [selectPhotoButton release];
    [selectCameraButton release];
    [contentTextView release];
    [contentTypeSegControl release];
    [contentImageView release];
    [replyPostId release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)createTitleToolbar
{    
    NSArray *items = [NSArray arrayWithObjects:NSLS(@"kTextContent"), NSLS(@"kPhotoContent"), nil]; 
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:items];
    
    segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [segControl addTarget:self 
                   action:@selector(clickSegControl:) 
         forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segControl;    
    [segControl release];
}

- (void)initData
{
    syncSNSStatus = NO;
    
    self.photoArray = [[NSMutableArray alloc] init];
}

- (void)setSyncSNSButtonInfo
{
    if (syncSNSStatus){
        [self.syncSNSButton setTitle:NSLS(@"kSyncSNSYes") forState:UIControlStateNormal];        
    }
    else{
        [self.syncSNSButton setTitle:NSLS(@"kSyncSNSNo") forState:UIControlStateNormal];                
    }
}

// whether it's a reply post
- (BOOL)isReply
{
    return [replyPostId length] > 0;
}

- (void)initButtons
{
    [self setSyncSNSButtonInfo];
//    [self.selectCameraButton setTitle:NSLS(@"") forState:UIControlStateNormal];
//    [self.selectPhotoButton setTitle:NSLS(@"") forState:UIControlStateNormal];
//    [self.selectPlaceButton setTitle:NSLS(@"") forState:UIControlStateNormal];
    
    if ([self isReply]){
        selectPlaceButton.hidden = YES; // cannot select place if it's a reply post
    }
}

- (void)setTextViewStatus
{
    if (contentTypeSegControl.selectedSegmentIndex == SELECT_TEXT){
        if ([contentTextView isFirstResponder] == NO){
            [contentTextView becomeFirstResponder];
        }
    }
}

- (void)updateContentTypeSegControlText
{
    int len = [contentTextView.text length];
    NSString* text = [NSString stringWithFormat:NSLS(@"kSegText"), len];
    [contentTypeSegControl setTitle:text forSegmentAtIndex:SELECT_TEXT];
}

- (void)updateContentTypeSegControlPhoto
{
    int len = [photoArray count];
    NSString* text = [NSString stringWithFormat:NSLS(@"kSegPhoto"), len];
    [contentTypeSegControl setTitle:text forSegmentAtIndex:SELECT_PHOTO];
}

- (void)initTextView
{
    contentTextView.delegate = self;
}

- (void)viewDidLoad
{
        
    [self initData];
    
//    [self createTitleToolbar];
    [self initButtons];
    [self initTextView];
    [self updateContentTypeSegControlText];
    [self updateContentTypeSegControlPhoto];
    [self setNavigationLeftButton:NSLS(@"Back") action:@selector(clickBack:)];
    [self setNavigationRightButton:NSLS(@"kSavePost") action:@selector(clickSavePost:)];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setTextViewStatus];    
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [self setSyncSNSButton:nil];
    [self setSelectPlaceButton:nil];
    [self setSelectPhotoButton:nil];
    [self setSelectCameraButton:nil];
    [self setContentTextView:nil];
    [self setContentTypeSegControl:nil];
    [self setContentImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// this shall be moved to a SyncSNSService
- (void)syncSNS:(NSString*)textContent
{
    User* user = [UserManager getUser];
    if (user.sinaAccessToken != nil && [user.sinaAccessToken length] > 0 && user.sinaAccessTokenSecret){
//        [SinaService createWeiboWith:textContent accessToken:user.sinaAccessToken tokenSecret:user.sinaAccessTokenSecret];
    }
    if (user.qqAccessToken != nil && [user.qqAccessToken length] > 0 && user.qqAccessTokenSecret){
//        [QQService createWeiboWith:textContent accessToken:user.qqAccessToken tokenSecret:user.qqAccessTokenSecret];        
    }
}

- (void)createPost:(int)contentType textContent:(NSString*)textContent
          latitude:(double)latitude longitude:(double)longitude
      userLatitude:(double)userLatitude userLongitude:(double)userLongitude
           syncSNS:(BOOL)syncSNS placeId:(NSString*)placeId
             image:(UIImage*)image
         srcPostId:(NSString*)srcPostIdVal
       replyPostId:(NSString*)replyPostIdVal

{
    User* user = [UserManager getUser];
    NSString* appId = [AppManager getPlaceAppId];
    
        
    [self showActivityWithText:NSLS(@"kCreatingPost")];
    dispatch_async(workingQueue, ^{

        // for test image upload
        
        
        CreatePostOutput* output = [CreatePostRequest send:SERVER_URL 
                                                    userId:user.userId 
                                                     appId:appId 
                                               contentType:contentType 
                                               textContent:textContent 
                                                  latitude:latitude 
                                                 longitude:longitude 
                                              userLatitude:userLatitude 
                                             userLongitude:userLongitude 
                                                   syncSNS:syncSNS 
                                                   placeId:placeId
                                                     image:image
                                                 srcPostId:srcPostIdVal
                                               replyPostId:replyPostIdVal];
        
        if (syncSNS){
            [self syncSNS:textContent];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideActivity];
            if (output.resultCode == ERROR_SUCCESS){               
                // save post data locally
                [PostManager createPost:output.postId placeId:placeId userId:user.userId textContent:textContent imageURL:output.imageURL contentType:contentType createDate:output.createDate longitude:longitude latitude:latitude userLongitude:userLongitude userLatitude:userLatitude totalView:output.totalView totalForward:output.totalForward totalQuote:output.totalQuote totalReply:output.totalReply totalRelated:0
                           userNickName:user.nickName 
                              placeName:place.name
                              srcPostId:srcPostId
                            replyPostId:replyPostId
                             userAvatar:user.avatar
                             userGender:user.gender
                                 useFor:POST_FOR_PLACE];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if (output.resultCode == ERROR_NETWORK){
                [UIUtils alert:NSLS(@"kSystemFailure")];
            }
            else{
                [UIUtils alert:NSLS(@"kUnknowFailure")];
                // other error TBD
            }
        });        
    });    
    
}

- (int)getContentType
{
    int contentType = CONTENT_TYPE_TEXT;
    if (photoArray != nil && [photoArray count] > 0){
        contentType = CONTENT_TYPE_TEXT_PHOTO;
    }
    
    return contentType;
}

- (BOOL)validatePost
{
    if ([self getImage] == nil && [contentTextView.text length] <= 0){
        [self popupUnhappyMessage:NSLS(@"kNoContentInPost") title:@""];
        return NO;
    }
    
    if ([contentTextView.text length] > MAX_POST_TEXT_LEN){
        [self popupUnhappyMessage:NSLS(@"kExceedContentLength") title:@""];
        return NO;
    }
    
    return YES;
}

- (void)clickSavePost:(id)sender
{
    if ([self validatePost] == NO)
        return;
    
    int contentType = [self getContentType];
    NSString* textContent = contentTextView.text;
    
    double userLongitude = 113.11f;     // TBD
    double userLatitude = 153.22f;
    
    NSString* placeId = nil;
    if (place != nil){
        placeId = place.placeId;
    }
    else{
        placeId = srcPlaceId;
    }
    
    UIImage* image = [self getImage];
    
    // for test
    // syncSNSStatus = NO;
    
    [self createPost:contentType textContent:textContent 
            latitude:[place.latitude doubleValue] 
           longitude:[place.longitude doubleValue] 
        userLatitude:userLatitude userLongitude:userLongitude 
             syncSNS:syncSNSStatus placeId:placeId 
               image:image
           srcPostId:srcPostId
         replyPostId:replyPostId];
}

- (IBAction)clickSyncSNSButton:(id)sender
{
    syncSNSStatus = ! syncSNSStatus;
    [self setSyncSNSButtonInfo];
}

- (IBAction)clickSegControl:(id)sender
{
    switch (contentTypeSegControl.selectedSegmentIndex){
        case SELECT_TEXT:
        {
            contentImageView.hidden = YES;
            contentTextView.hidden = NO;
        }
            break;
        case SELECT_PHOTO:            
        {
            contentImageView.hidden = NO;
            contentTextView.hidden = YES;
        }
            break;
        default:
            break;
    }

}

#pragma mark - Image Related Methods

- (void)setImage:(UIImage*)image
{
    if (photoArray != nil){
        [photoArray removeAllObjects];
        [photoArray addObject:image];
        
        CGRect origRect = contentTextView.frame;
        CGRect retRect = [UIImage shrinkFromOrigRect:origRect imageSize:image.size];
        
        contentImageView.frame = retRect;
        contentImageView.image = image;
        
        [self updateContentTypeSegControlPhoto];
    }
}

- (UIImage*)getImage
{
    if (photoArray != nil && [photoArray count] > 0){
        return [photoArray objectAtIndex:0];
    }
    
    return nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil){
        // save image
        [self setImage:image];
    }

    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)clickSelectPhoto:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];        
    }
    
}

- (IBAction)clickTakePhoto:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];        
    }
    
}

- (void)selectPlace:(Place*)newPlace
{
    self.place = newPlace;
}

- (IBAction)clickSelectPlace:(id)sender
{
    [SelectPlaceController gotoSelectPlaceController:self defaultPlace:place];
}

- (IBAction)clickTag:(id)sender
{
    UIButton* button = sender;
    contentTextView.text = [NSString stringWithFormat:@"[%@] %@", [button titleForState:UIControlStateNormal], contentTextView.text];
    
    [self updateContentTypeSegControlText];    
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateContentTypeSegControlText];
}


//- (IBAction)uploadImage {
//	/*
//	 turning the image into a NSData object
//	 getting the image back out of the UIImageView
//	 setting the quality to 90
//     */
//    
//    CGImageRef screen = UIGetScreenImage();
//    UIImage* image = [UIImage imageWithCGImage:screen];
//    CGImageRelease(screen);
//    
//	NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//	// setting up the URL to post to
//	NSString *urlString = @"http://192.168.1.152:8809/upload";
//    
//    NSLog(@"upload image");
//    
//	// setting up the request object now
//	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
//	[request setURL:[NSURL URLWithString:urlString]];
//	[request setHTTPMethod:@"POST"];
//    
//	/*
//	 add some header info now
//	 we always need a boundary when we post a file
//	 also we need to set the content type
//     
//	 You might want to generate a random boundary.. this is just the same
//	 as my output from wireshark on a valid html post
//     */
//	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
//    
//    // add content type header
//	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//	/*
//	 now lets create the body of the post
//     */
//	NSMutableData *body = [NSMutableData data];
//	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"file\"; filename=\"test.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[NSData dataWithData:imageData]];
//	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//	// setting the body of the post to the reqeust
//	[request setHTTPBody:body];
//    
//	// now lets make the connection to the web
//	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    
//	NSLog(@"upload image, return = %@", returnString);
//}

@end
