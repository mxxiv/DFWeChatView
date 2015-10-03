//
//  DFTextMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVoiceMessageCell.h"

#import "DFVoiceMessage.h"

#import "DFVoiceBubbleView.h"

#import "DFVoicePlayView.h"


#define VoiceBubbleHeight UserAvatarSize+13

#define PlayIconSize 22
#define PlayIconPadding 18

#define LengthLabelHeight 20;
#define LengthLabelWidth 40;

@interface DFVoiceMessageCell()

@property (strong,nonatomic) DFVoiceBubbleView *bubbleView;

@property (strong,nonatomic) DFVoicePlayView *playingView;

@property (strong,nonatomic) UILabel *lengthLabel;

@end

@implementation DFVoiceMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}

-(void) initCell
{
    if (_bubbleView == nil) {
        _bubbleView = [[DFVoiceBubbleView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_bubbleView];
        //_bubbleView.backgroundColor = [UIColor darkGrayColor];
    }
    
    if (_playingView == nil) {
        _playingView = [[DFVoicePlayView alloc] initWithFrame:CGRectZero];
        [_bubbleView addSubview:_playingView];
    }
    
    if (_lengthLabel == nil) {
        _lengthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lengthLabel.textColor = [UIColor lightGrayColor];
        _lengthLabel.font = [UIFont systemFontOfSize:14];
        [_bubbleView addSubview:_lengthLabel];
    }
    
}


-(void) updateWithMessage:(DFVoiceMessage *) voiceMessage
{
    [super updateWithMessage:voiceMessage];
    
    CGFloat x, y ,width ,height;
    
    //气泡
    width = BubbleContentPadding + voiceMessage.length*20;
    if (width < 70) {
        width = 70;
    }
    if (width > MaxBubbleWidth) {
        width = MaxBubbleWidth - 40;
    }
    height = VoiceBubbleHeight;
    y= CGRectGetMinY(self.userAvatarView.frame)-2+ [self getUserNickLabelOffset];
    if (voiceMessage.bIsMe) {
        x= CGRectGetMinX(self.userAvatarView.frame) - Padding - width;
        _bubbleView.direction = BubbleDirectionRight;
    }else{
        x= CGRectGetMaxX(self.userAvatarView.frame) + Padding;
        _bubbleView.direction = BubbleDirectionLeft;
    }
    _bubbleView.frame = CGRectMake(x, y, width, height);
    
    [super updateStatusViewFrame:_bubbleView bIsMe:voiceMessage.bIsMe xOffset:25 yOffset:0];
    
    
    x=0;
    y=0;
    height = height - 10;
    width = width - 10;
    _playingView.frame = CGRectMake(x, y, width, height);
    [_playingView updateWithVoiceMessage:voiceMessage];
    
    y = 20;
    height = LengthLabelHeight;
    width = LengthLabelWidth;
    
    if (voiceMessage.bIsMe) {
        x = 0-width;
        _lengthLabel.textAlignment = NSTextAlignmentRight;
    }else{
        x = CGRectGetWidth(_bubbleView.frame);
        _lengthLabel.textAlignment = NSTextAlignmentLeft;
    }
    _lengthLabel.text = [NSString stringWithFormat:@"%lu''", (unsigned long)voiceMessage.length];
    _lengthLabel.frame = CGRectMake(x, y, width, height);
    
}


+(CGFloat) getCellHeight:(DFVoiceMessage *) voiceMessage
{
    CGFloat height = [DFBaseMessageCell getBaseCellHeight:voiceMessage];
    
    height += VoiceBubbleHeight;
    
    return height;
    
}
@end
