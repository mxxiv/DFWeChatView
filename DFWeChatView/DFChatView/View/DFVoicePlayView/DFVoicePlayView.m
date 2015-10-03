//
//  DFVoicePlayView.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/5/23.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVoicePlayView.h"

#import "DFVoicePlayManager.h"

#define PlayIconSize 22
#define PlayIconPadding 18


@interface DFVoicePlayView()

@property (strong,nonatomic) UIImageView *playingView;


@property (assign, nonatomic) BOOL isPlaying;

@property (strong, nonatomic) DFVoiceMessage *voiceMessage;

@property (strong,nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSUInteger playCount;

@end



@implementation DFVoicePlayView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        
        _isPlaying = NO;
    }
    return self;
}


-(void) initView
{
    
    [self addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_playingView == nil) {
        _playingView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_playingView];
    }
}


-(void)updateWithVoiceMessage:(DFVoiceMessage *)voiceMessage
{
    _voiceMessage = voiceMessage;
    
    CGFloat x, y ,width ,height;
    
    width = PlayIconSize;
    height = width;
    y = 15;
    if (voiceMessage.bIsMe) {
        x = self.frame.size.width - width - PlayIconPadding;
        _playingView.image = [UIImage imageNamed:@"SenderVoiceNodePlaying"];
    }else{
        x = PlayIconPadding;
        _playingView.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
    }
    
    _playingView.frame = CGRectMake(x, y, width, height);
}



-(void) onClickButton:(id)sender
{
    
    if (_isPlaying) {
        [self stopPlaying];
    }else{
        [self startPlaying];
    }
}


-(void) onPlay:(NSTimer *) timer
{
    _playCount++;
    
    NSUInteger index = _playCount %3;
    if (index == 0) {
        index = 3;
    }
    
    if (_voiceMessage.bIsMe) {
        _playingView.image = [UIImage imageNamed:[NSString stringWithFormat:@"SenderVoiceNodePlaying00%lu", (unsigned long)index]];
    }else{
        _playingView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ReceiverVoiceNodePlaying00%lu", (unsigned long)index]];
        
    }
    
}


-(void) startPlaying
{
    _isPlaying = YES;
    _playCount = 0;
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onPlay:) userInfo:nil repeats:YES];
    }
    
    [[DFVoicePlayManager sharedInstance] play:self voiceMessage:_voiceMessage];
    
}

-(void)stopPlaying
{
    _isPlaying = NO;
    [_timer invalidate];
    _timer = nil;
    _playCount = 0;
    if (_voiceMessage.bIsMe) {
        _playingView.image = [UIImage imageNamed:@"SenderVoiceNodePlaying"];
    }else{
        _playingView.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
    }
    
    [[DFVoicePlayManager sharedInstance] stopPlay];
    
}
@end
