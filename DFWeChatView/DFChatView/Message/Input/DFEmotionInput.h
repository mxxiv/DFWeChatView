//
//  DFEmotionInput.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/9/12.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseInput.h"

#import "DFPackageEmotionItem.h"

@interface DFEmotionInput : DFBaseInput

@property (nonatomic, strong) DFPackageEmotionItem *item;

@end
