//
//  DFImageInput.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/9/12.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseInput.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DFImageInput : DFBaseInput

@property (nonatomic, strong) ALAsset *asset;

@end
