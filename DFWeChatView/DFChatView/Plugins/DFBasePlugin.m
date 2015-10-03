//
//  DFBasePlugin.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBasePlugin.h"

@implementation DFBasePlugin

- (instancetype)init
{
    self = [super init];
    if (self) {
        _icon = @"";
        _name = @"";
    }
    return self;
}

-(void) onClick
{
    
}
@end
