//
//  DFVoicePlayManager.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/5/23.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFVoicePlayView.h"
#import "DFVoiceMessage.h"

@interface DFVoicePlayManager : NSObject

+(instancetype) sharedInstance;



-(void) play:(DFVoicePlayView *) view voiceMessage:(DFVoiceMessage *)voiceMessage;
-(void) stopPlay;

@end
