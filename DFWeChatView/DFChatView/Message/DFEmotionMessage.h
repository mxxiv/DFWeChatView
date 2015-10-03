//
//  DFTextMessage.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseMessage.h"
#import "DFPackageEmotionItem.h"

@interface DFEmotionMessage : DFBaseMessage

@property (strong, nonatomic)  DFPackageEmotionItem *emotionItem;

@end
