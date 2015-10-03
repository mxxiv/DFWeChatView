//
//  DFTextMessage.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFEmotionMessage.h"

@implementation DFEmotionMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageType = MessageTypeEmotion;
    }
    return self;
}

@end
