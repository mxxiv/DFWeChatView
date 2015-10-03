//
//  DFVoicePlayManager.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/5/23.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVoicePlayManager.h"
#import "AFSoundManager.h"

@interface DFVoicePlayManager()

@property (nonatomic, strong) DFVoicePlayView *previousView;

@end


@implementation DFVoicePlayManager

static  DFVoicePlayManager *_manager=nil;

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_manager == nil) {
            _manager = [[DFVoicePlayManager alloc] init];
        }
    }
    return _manager;
}


-(void)play:(DFVoicePlayView *)view voiceMessage:(DFVoiceMessage *)voiceMessage
{
    if (_previousView != nil && view != _previousView) {
        [_previousView stopPlaying];
    }
    _previousView = view;
    
    
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:voiceMessage.url andBlock:^(NSInteger percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (finished) {
            [_previousView stopPlaying];
        }
    } isFileChanged:YES];
}

-(void)stopPlay
{
    [[AFSoundManager sharedManager] stop];
}


@end
