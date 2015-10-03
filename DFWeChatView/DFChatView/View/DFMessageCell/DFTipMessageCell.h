//
//  DFTextMessageCell.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DFBaseMessage.h"

@interface DFTipMessageCell: UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


+(CGFloat) getCellHeight:(DFBaseMessage *) message;

-(void) updateWithMessage:(DFBaseMessage *) message;

@end
