//
//  DFBaseCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseCellAdapter.h"


@interface DFBaseCellAdapter()

@end


@implementation DFBaseCellAdapter


-(CGFloat) getCellHeight:(DFBaseMessage *)message
{
    if (message.cellHeight != 0) {
        //NSLog(@"直接获取高度 %f", message.cellHeight);
        return message.cellHeight;
    }
    CGFloat height = [self getCellHeightByCount:message];
    message.cellHeight = height;
    //NSLog(@"计算获取高度 %f", message.cellHeight);

    return height;
}

-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message
{
    return 0.0;
}

-(UITableViewCell *) getCell:(UITableView *) tableView
{
    return nil;
}

-(void) updateCell:(UITableViewCell *) cell message:(DFBaseMessage *)message
{
    
}
@end
