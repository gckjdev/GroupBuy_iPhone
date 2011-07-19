//
//  PPImageView.m
//  Dipan
//
//  Created by penglzh on 11-6-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PPImageView.h"


@implementation PPImageView

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    
    // Retrieve the touch point 检索接触点
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    
    startLocation = pt;
    
    [[self superview] bringSubviewToFront:self];
    
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    
    // Move relative to the original touch point 相对以前的触摸点进行移动
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    
    CGRect frame = [self frame];
    
    frame.origin.x += pt.x - startLocation.x;
    
    frame.origin.y += pt.y - startLocation.y;
    
    [self setFrame:frame];
    
}

@end
