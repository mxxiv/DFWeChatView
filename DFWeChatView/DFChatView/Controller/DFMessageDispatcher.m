//
//  DFMessageDispatcher.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFMessageDispatcher.h"
#import "Key.h"
#import <UIKit/UIKit.h>

@implementation DFMessageDispatcher


static  DFMessageDispatcher *_dispather=nil;

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_dispather == nil) {
            _dispather = [[DFMessageDispatcher alloc] init];
        }
    }
    return _dispather;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNotify];
    }
    return self;
}

-(void)dealloc
{
    [self removeNotify];
    
}
-(void) addNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputTextMessage:) name:NOTIFY_TEXT_MESSAGE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputEmotionMessage:) name:NOTIFY_EMOTION_MESSAGE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputImageMessage:) name:NOTIFY_IMAGE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputVoiceMessage:) name:NOTIFY_VOICE_MESSAGE object:nil];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onImageClicked:) name:NOTIFY_IMAGE_CLIECKED object:nil];
}

-(void) removeNotify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_TEXT_MESSAGE object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_EMOTION_MESSAGE object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_IMAGE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_VOICE_MESSAGE object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_IMAGE_CLIECKED object:nil];
}


#pragma mark - Method

//普通文本
-(void) onInputTextMessage:(NSNotification *) notify
{
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DFMessageDispatcherDelegate)] && [_delegate respondsToSelector:@selector(onSendTextMessage:)]) {
        
        DFTextInput *textInput = [[DFTextInput alloc] init];
        textInput.text = [notify.userInfo objectForKey:@"text"];
        [_delegate onSendTextMessage:textInput];
    }
    
}

//动画表情
-(void) onInputEmotionMessage:(NSNotification *) notify
{

    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DFMessageDispatcherDelegate)] && [_delegate respondsToSelector:@selector(onSendEmotionMessage:)]) {
        DFEmotionInput *emotionInput = [[DFEmotionInput alloc] init];
        emotionInput.item = [notify.userInfo objectForKey:@"item"];
        [_delegate onSendEmotionMessage:emotionInput];
    }
    
}


//图片
-(void) onInputImageMessage:(NSNotification *) notify
{
    
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DFMessageDispatcherDelegate)] && [_delegate respondsToSelector:@selector(onSendImageMessage:)]) {
        
        DFImageInput *imageInput = [[DFImageInput alloc] init];
        imageInput.asset = [notify.userInfo objectForKey:@"asset"];
        [_delegate onSendImageMessage:imageInput];
    }
    
}


//语音
-(void) onInputVoiceMessage:(NSNotification *) notify
{
    
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DFMessageDispatcherDelegate)] && [_delegate respondsToSelector:@selector(onSendVoiceMessage:)]) {
        
        DFVoiceInput *voiceInput = [[DFVoiceInput alloc] init];
        voiceInput.localPath = [notify.userInfo objectForKey:@"voice"];
        voiceInput.length = [[notify.userInfo objectForKey:@"length"] unsignedIntegerValue];
        
        [_delegate onSendVoiceMessage:voiceInput];
    }
    
}





//图片点击
-(void) onImageClicked:(NSNotification *) notify
{
    
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DFMessageDispatcherDelegate)] && [_delegate respondsToSelector:@selector(onClickImageMessage:imageView:)]) {

        NSDictionary *dic = notify.userInfo;
        NSUInteger rowIndex = [[dic objectForKey:@"rowIndex"] unsignedIntegerValue];
        UIImageView *imageView = (UIImageView *)[dic objectForKey:@"imageView"];
        
        [_delegate onClickImageMessage:rowIndex imageView:imageView];
    }
    
}


@end
