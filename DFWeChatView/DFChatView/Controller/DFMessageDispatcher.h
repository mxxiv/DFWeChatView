//
//  DFMessageDispatcher.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//messages
#import "DFTextMessage.h"
#import "DFEmotionMessage.h"
#import "DFImageMessage.h"
#import "DFVoiceMessage.h"


#import "DFTextInput.h"
#import "DFImageInput.h"
#import "DFEmotionInput.h"
#import "DFVoiceInput.h"


@protocol DFMessageDispatcherDelegate <NSObject>

@optional

//普通文本(带[...]小表情)
-(void) onSendTextMessage:(DFTextInput *) textInput;

//大表情(gif动画)
-(void) onSendEmotionMessage:(DFEmotionInput *) emotionInput;

//图片
-(void) onSendImageMessage:(DFImageInput *) imageInput;

//语音
-(void) onSendVoiceMessage:(DFVoiceInput *) voiceInput;



//点击图片消息
-(void) onClickImageMessage:(NSUInteger) rowIndex imageView:(UIImageView *) imageView;


@end

@interface DFMessageDispatcher : NSObject


+(instancetype) sharedInstance;


@property (assign, nonatomic) id<DFMessageDispatcherDelegate> delegate;


@end
