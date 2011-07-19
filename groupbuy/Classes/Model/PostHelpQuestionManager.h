//
//  PostHelpQuestionManager.h
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PostHelpQuestionManager : NSObject {
    
    NSMutableArray  *questionList;
    NSMutableArray  *answerList;
}

@property (nonatomic, retain) NSMutableArray  *questionList;
@property (nonatomic, retain) NSMutableArray  *answerList;

- (NSString*)genderatePost;
- (BOOL)validateAnswer;

@end
