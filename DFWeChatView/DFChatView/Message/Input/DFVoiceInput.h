//
//  DFVoiceInput.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/9/12.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseInput.h"

@interface DFVoiceInput : DFBaseInput

@property (nonatomic, strong) NSString *localPath;
@property (nonatomic, assign) NSUInteger length;
@end
