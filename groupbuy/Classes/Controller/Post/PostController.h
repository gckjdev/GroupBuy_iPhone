//
//  PostController.h
//  Dipan
//
//  Created by qqn_pipi on 11-5-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"


@interface PostController : PPTableViewController <PostTableViewCellDelegate> {
    
    Post        *post;
    UIToolbar   *actionToolbar;
}
@property (nonatomic, retain) IBOutlet UIToolbar *actionToolbar;

@property (nonatomic, retain) Post        *post;

@end
