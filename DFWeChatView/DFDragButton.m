//
//  DFDragButton.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/5/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFDragButton.h"

@implementation DFDragButton

//- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    return YES;
//}
//
//
//
//
//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGFloat boundsExtension = 5.0f;
//    CGRect outerBounds = CGRectInset(self.bounds, -1 * boundsExtension, -1 * boundsExtension);
//    
//    BOOL touchOutside = !CGRectContainsPoint(outerBounds, [touch locationInView:self]);
//    if(touchOutside)
//    {
//        //NSLog(@"tttt outside");
//        
//        BOOL previousTouchInside = CGRectContainsPoint(outerBounds, [touch previousLocationInView:self]);
//        if(previousTouchInside)
//        {
//            //NSLog(@"Sending UIControlEventTouchDragExit");
//            [self sendActionsForControlEvents:UIControlEventTouchDragExit];
//        }
//        else
//        {
//           //NSLog(@"Sending UIControlEventTouchDragOutside");
//            [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
//        }
//    }else{
//        //NSLog(@"tttt inside");
//        
//        
//        BOOL previousTouchInside = CGRectContainsPoint(outerBounds, [touch previousLocationInView:self]);
//        if(!previousTouchInside)
//        {
//            //NSLog(@"Sending UIControlEventTouchDragExit");
//            [self sendActionsForControlEvents:UIControlEventTouchDragEnter];
//        }
//        else
//        {
//            //NSLog(@"Sending UIControlEventTouchDragOutside");
//            [self sendActionsForControlEvents:UIControlEventTouchDragInside];
//        }
//
//        
//        
//    }
//    return YES;
//}
@end
