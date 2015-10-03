//
//  DFPhotoAlbumPlugin.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVideoShortPlugin.h"

@implementation DFVideoShortPlugin


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [super setIcon:@"sharemore_sight"];
        [super setName:@"小视频"];
    }
    return self;
}

@end
