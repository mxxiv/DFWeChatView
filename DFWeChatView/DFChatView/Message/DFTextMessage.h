//
//  DFTextMessage.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseMessage.h"

@interface DFTextMessage : DFBaseMessage

@property (strong, nonatomic) NSString *text;

@property (assign, nonatomic) CGSize size;

@end
