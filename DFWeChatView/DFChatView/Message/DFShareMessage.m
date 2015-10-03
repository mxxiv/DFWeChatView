//
//  DFTextMessage.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFShareMessage.h"

@implementation DFShareMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageType = MessageTypeShare;
    }
    return self;
}

@end
