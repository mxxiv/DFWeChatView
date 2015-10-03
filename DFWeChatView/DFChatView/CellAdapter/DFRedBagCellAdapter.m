//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFRedBagCellAdapter.h"
#import "DFRedBagMessageCell.h"

#define CellIdentifier @"RED_BAG_CELL_IDENTIFIER"

@interface DFRedBagCellAdapter()

@end


@implementation DFRedBagCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message{
    return [DFRedBagMessageCell getCellHeight:message];
}

-(DFBaseMessageCell *) getCell:(UITableView *) tableView
{
    DFRedBagMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFRedBagMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFBaseMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
