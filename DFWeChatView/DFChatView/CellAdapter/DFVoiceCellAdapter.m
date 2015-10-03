//
//  DFTextCellAdapter.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVoiceCellAdapter.h"
#import "DFVoiceMessageCell.h"

#define CellIdentifier @"VOICE_CELL_IDENTIFIER"

@interface DFVoiceCellAdapter()

@end


@implementation DFVoiceCellAdapter


-(CGFloat) getCellHeightByCount:(DFBaseMessage *)message{
    return [DFVoiceMessageCell getCellHeight:message];
}

-(DFBaseMessageCell *) getCell:(UITableView *) tableView
{
    
    DFVoiceMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[DFVoiceMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    return cell;
}

-(void) updateCell:(DFBaseMessageCell *) cell message:(DFBaseMessage *)message
{
    [cell updateWithMessage:message];
}

@end
