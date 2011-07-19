//
//  HelpWritePostController.h
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "PostHelpQuestionManager.h"

@protocol HelpWritePostControllerDelegate <NSObject>

- (void)helpWritePostDone:(NSString*)postText;

@end

@interface HelpWritePostController : PPTableViewController {
    PostHelpQuestionManager *manager;
    id<HelpWritePostControllerDelegate> delegate;
}

+ (HelpWritePostController*)showHelpWritePostController:(UIViewController<HelpWritePostControllerDelegate>*)superController;
@property (nonatomic, assign) id<HelpWritePostControllerDelegate> delegate;

@end
