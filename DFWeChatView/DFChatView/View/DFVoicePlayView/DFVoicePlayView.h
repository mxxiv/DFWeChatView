//
//  DFVoicePlayView.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/5/23.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFVoiceMessage.h"


@interface DFVoicePlayView : UIButton

-(void) updateWithVoiceMessage:(DFVoiceMessage *) voiceMessage;
-(void) stopPlaying;

@end
