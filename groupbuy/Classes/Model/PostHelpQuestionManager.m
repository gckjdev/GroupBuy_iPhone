//
//  PostHelpQuestionManager.m
//  Dipan
//
//  Created by qqn_pipi on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PostHelpQuestionManager.h"
#import "LocaleUtils.h"

@implementation PostHelpQuestionManager

@synthesize questionList;
@synthesize answerList;

- (id)init
{
    self = [super init];
    self.questionList = [[NSMutableArray alloc] initWithObjects:
                         NSLS(@"kQuestionInterest"), 
                         NSLS(@"kQuestionLife"), 
                         NSLS(@"kQuestionFuture"), 
                         nil];
    
    self.answerList = [[NSMutableArray alloc] initWithObjects:
                       @"", @"", @"", nil];
    
    return self;
}

- (void)dealloc
{
    [answerList release];
    [questionList release];
    [super dealloc];
}

- (BOOL)validateAnswer
{
    BOOL notEmpty = NO;
    for (NSString* answer in answerList){
        if ([answer length] > 0){
            notEmpty = YES;
            break;
        }
    }
    
    return notEmpty;
}

- (NSString*)genderatePost
{
    NSString* post = @"";
    int i = 0;
    for (NSString* answer in answerList){
        if ([answer length] > 0){
            post = [post stringByAppendingFormat:@"%@%@,", [questionList objectAtIndex:i], answer];
        }
        i++;                                                           
    }
    
    post = [post stringByAppendingString:NSLS(@"kQuestionWant")];
    
    return post;
}

@end
