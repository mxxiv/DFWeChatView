//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFShareCellAdapter.h"
#import "DFShareMessageCell.h"

#define CellIdentifier @"SHARE_CELL_IDENTIFIER"

@interface DFShareCellAdapter()

@end


@implementation DFShareCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message{
    return [DFShareMessageCell getCellHeight:message];
}

-(DFBaseMessageCell *) getCell:(UITableView *) tableView
{
    
    DFShareMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFShareMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFBaseMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
