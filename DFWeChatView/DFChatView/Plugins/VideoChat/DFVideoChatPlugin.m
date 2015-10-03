//
//  DFPhotoAlbumPlugin.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVideoChatPlugin.h"

@implementation DFVideoChatPlugin


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [super setIcon:@"sharemore_videovoip"];
        [super setName:@"视频聊天"];
    }
    return self;
}

@end
