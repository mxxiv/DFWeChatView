//
//  DFBaseMessageCell.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DFBaseMessage.h"

#import "DFMessageStatusView.h"

#define CellWidth [UIScreen mainScreen].bounds.size.width
#define MaxBubbleWidth CellWidth*0.7


#define UserAvatarSize 48

#define Padding 8
#define BubblePadding 10


#define TimeLabelSpace 40
#define CellBottomSpace 10


#define StatusViewXOffset 10
#define StatusViewYOffset 5


@interface DFBaseMessageCell : UITableViewCell

@property (strong, nonatomic) DFBaseMessage *message;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UILabel *userNickLabel;

@property (strong, nonatomic) UIImageView *userAvatarView;

@property (strong, nonatomic) DFMessageStatusView *messageStatusView;


@property (assign, nonatomic) BOOL bIsMenuShow;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void) updateWithMessage:(DFBaseMessage *) message;

-(void) updateStatusViewFrame:(UIView *)view bIsMe:(BOOL)bIsMe;

-(void) updateStatusViewFrame:(UIView *)view bIsMe:(BOOL)bIsMe xOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset;

-(void) onMenuShow;

-(void) onMenuHide;

-(NSArray *) getMenuActionSelector;

+(CGFloat) getBaseCellHeight:(DFBaseMessage *) message;

-(CGFloat) getUserNickLabelOffset;


@end
