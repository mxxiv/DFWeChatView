//
//  DFTextMessage.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//


#import "DFBaseMessage.h"
#import <UIKit/UIKit.h>

@interface DFImageMessage : DFBaseMessage

@property (strong, nonatomic) NSString *localPath;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *thumbUrl;
@property (strong, nonatomic) NSString *preloadUrl;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) NSInteger height;
@property (strong, nonatomic) UIImage *image;

@end
