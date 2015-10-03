//
//  DFTextMessage.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseMessage.h"

@interface DFVoiceMessage : DFBaseMessage

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *url;
@property (assign, nonatomic) NSUInteger length;

@end
