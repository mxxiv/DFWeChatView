//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFImageCellAdapter.h"

#import "DFImageMessageCell.h"

#define CellIdentifier @"IMAGE_CELL_IDENTIFIER"

@interface DFImageCellAdapter()

@end


@implementation DFImageCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message
{
    return [DFImageMessageCell getCellHeight:message];
}

-(DFBaseMessageCell *) getCell:(UITableView *) tableView
{
    
    DFImageMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFImageMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFBaseMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
