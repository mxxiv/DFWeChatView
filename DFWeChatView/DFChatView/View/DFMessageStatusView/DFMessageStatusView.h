//
//  DFMessageStatusView.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/29.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFBaseMessage.h"

@interface DFMessageStatusView : UIView

-(void) changeStatus:(MessageStatus)status;

@end
