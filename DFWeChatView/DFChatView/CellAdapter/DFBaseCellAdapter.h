//
//  DFBaseCellAdapter.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "DFBaseMessage.h"
#import "DFBaseMessageCell.h"


@interface DFBaseCellAdapter : NSObject

-(CGFloat) getCellHeight:(DFBaseMessage *) message;

-(UITableViewCell *) getCell:(UITableView *) tableView;

-(void) updateCell:(UITableViewCell *) cell message:(DFBaseMessage *)message;

@end
