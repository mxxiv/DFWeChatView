//
//  DFTextMessage.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseMessage.h"

@interface DFShareMessage : DFBaseMessage

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *thumb;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *link;


@end
