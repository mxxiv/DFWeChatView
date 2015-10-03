//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFEmotionCellAdapter.h"

#import "DFEmotionMessageCell.h"

#define CellIdentifier @"EMOTION_CELL_IDENTIFIER"

@interface DFEmotionCellAdapter()

@end


@implementation DFEmotionCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message
{
    return [DFEmotionMessageCell getCellHeight:message];
}

-(DFBaseMessageCell *) getCell:(UITableView *) tableView
{
    
    DFEmotionMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFEmotionMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFBaseMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
