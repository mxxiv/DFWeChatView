//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFTipCellAdapter.h"

#define CellIdentifier @"TIP_CELL_IDENTIFIER"

@interface DFTipCellAdapter()

@end


@implementation DFTipCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message{
    return [DFTipMessageCell getCellHeight:message];
}

-(UITableViewCell *) getCell:(UITableView *) tableView
{
    
    DFTipMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFTipMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFTipMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
