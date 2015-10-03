//
//  DFPluginsManager.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFCellAdapterManager.h"

@interface DFCellAdapterManager()


@property (strong, nonatomic) NSMutableDictionary *dic;


@end


@implementation DFCellAdapterManager

static  DFCellAdapterManager *_manager=nil;


#pragma mark - Lifecycle

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_manager == nil) {
            _manager = [[DFCellAdapterManager alloc] init];
        }
    }
    return _manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
    }
    return self;
}



#pragma mark - Method


-(void) registerAdapter:(MessageType) messageType adapter:(DFBaseCellAdapter *) adapter{
    [_dic setObject:adapter forKey:[NSNumber numberWithInteger:messageType]];
}


-(DFBaseCellAdapter *) getAdapter:(MessageType) messageType
{
    return [_dic objectForKey:[NSNumber numberWithInteger:messageType]];
}

@end
