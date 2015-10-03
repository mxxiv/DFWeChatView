//
//  DFPluginsManager.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "DFBaseCellAdapter.h"

//default adapters
#import "DFTipCellAdapter.h"
#import "DFTextCellAdapter.h"
#import "DFEmotionCellAdapter.h"
#import "DFImageCellAdapter.h"
#import "DFVoiceCellAdapter.h"
#import "DFShareCellAdapter.h"
#import "DFRedBagCellAdapter.h"




@interface DFCellAdapterManager : NSObject


+(instancetype) sharedInstance;

-(void) registerAdapter:(MessageType) messageType adapter:(DFBaseCellAdapter *) adapter;


-(DFBaseCellAdapter *) getAdapter:(MessageType) messageType;

@end
