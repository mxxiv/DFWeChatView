//
//  ViewController3.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/5/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "ViewController3.h"

#import "DFDragButton.h"

@implementation ViewController3

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    DFDragButton *_inputVoiceBtn = [[DFDragButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    _inputVoiceBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_inputVoiceBtn];
    [_inputVoiceBtn addTarget:self action:@selector(onVoiceButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
//    [_inputVoiceBtn addTarget:self action:@selector(onVoiceButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
//    [_inputVoiceBtn addTarget:self action:@selector(onVoiceButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//    [_inputVoiceBtn addTarget:self action:@selector(onVoiceButtonDragExit:) forControlEvents:UIControlEventTouchDragExit];
//    [_inputVoiceBtn addTarget:self action:@selector(onVoiceButtonDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    
    [_inputVoiceBtn addTarget:self action:@selector(btnDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [_inputVoiceBtn addTarget:self action:@selector(btnDragged:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    
    [_inputVoiceBtn addTarget:self action:@selector(btnTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_inputVoiceBtn addTarget:self action:@selector(btnTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpOutside];

}




 - (void)btnDragged:(UIButton *)sender withEvent:(UIEvent *)event {
         UITouch *touch = [[event allTouches] anyObject];
        CGFloat boundsExtension = 5.0f;
         CGRect outerBounds = CGRectInset(sender.bounds, -1 * boundsExtension, -1 * boundsExtension);
         BOOL touchOutside = !CGRectContainsPoint(outerBounds, [touch locationInView:sender]);
         if (touchOutside) {
                 BOOL previewTouchInside = CGRectContainsPoint(outerBounds, [touch previousLocationInView:sender]);
                 if (previewTouchInside) {
                         // UIControlEventTouchDragExit
                     [self onVoiceButtonDragExit];
                     } else {
                             // UIControlEventTouchDragOutside
                         
                         }
            } else {
                     BOOL previewTouchOutside = !CGRectContainsPoint(outerBounds, [touch previousLocationInView:sender]);
                    if (previewTouchOutside) {
                            // UIControlEventTouchDragEnter
                        [self onVoiceButtonDragEnter];
                        } else {
                                 // UIControlEventTouchDragInside
                             }
                 }
     }




 - (void)btnTouchUp:(UIButton *)sender withEvent:(UIEvent *)event {
         UITouch *touch = [[event allTouches] anyObject];
         CGFloat boundsExtension = 5.0f;
         CGRect outerBounds = CGRectInset(sender.bounds, -1 * boundsExtension, -1 * boundsExtension);
         BOOL touchOutside = !CGRectContainsPoint(outerBounds, [touch locationInView:sender]);
         if (touchOutside) {
                 // UIControlEventTouchUpOutside
             [self onVoiceButtonTouchUpOutside];
             } else {
                     // UIControlEventTouchUpInside
                 [self onVoiceButtonTouchUpInside];
                 }
     }



-(void) onVoiceButtonTouchDown:(UIButton *) button
{
    NSLog(@"touch down");
}

-(void) onVoiceButtonTouchUpOutside
{
    NSLog(@"touch up outside");
}



-(void) onVoiceButtonTouchUpInside
{
    NSLog(@"touch up inside");
}

-(void) onVoiceButtonDragExit
{
    NSLog(@"drag exit");
}


-(void) onVoiceButtonDragEnter
{
    NSLog(@"drag enter");
}



@end
