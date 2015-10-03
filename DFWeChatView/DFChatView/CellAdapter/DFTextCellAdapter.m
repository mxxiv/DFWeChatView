//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFTextCellAdapter.h"
#import "DFTextMessageCell.h"

#define CellIdentifier @"TEXT_CELL_IDENTIFIER"

@interface DFTextCellAdapter()

@end


@implementation DFTextCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message{
    return [DFTextMessageCell getCellHeight:message];
}

-(DFBaseMessageCell *) getCell:(UITableView *) tableView
{
    
    DFTextMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFBaseMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
