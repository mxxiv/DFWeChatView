//
//  DFTextMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFShareMessageCell.h"

#import "DFShareBubbleView.h"

#import "DFShareMessage.h"

#import "UIImageView+WebCache.h"

#import "MLLabel+Size.h"

#define TitleTextFont [UIFont systemFontOfSize:15]
#define DescTextFont [UIFont systemFontOfSize:12]

#define ThumbSize 60
#define UnitPadding 5

@interface DFShareMessageCell()


@property (strong,nonatomic) DFShareBubbleView *bubbleView;


@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *descLabel;

@property (strong,nonatomic) UIImageView *thumbView;

@end

@implementation DFShareMessageCell

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
        _bubbleView = [[DFShareBubbleView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_bubbleView];
    }
    
    if (_titleLabel == nil) {
        _titleLabel =[[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = TitleTextFont;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        [_bubbleView.contentView addSubview:_titleLabel];
    }

    if (_descLabel == nil) {
        _descLabel =[[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.font = DescTextFont;
        _descLabel.textColor = [UIColor lightGrayColor];
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descLabel.numberOfLines = 0;
        [_bubbleView.contentView addSubview:_descLabel];
    }
    
    if (_thumbView == nil) {
        _thumbView =[[UIImageView alloc] initWithFrame:CGRectZero];
        [_bubbleView.contentView addSubview:_thumbView];
    }


}


-(void) updateWithMessage:(DFShareMessage *) shareMessage
{
    [super updateWithMessage:shareMessage];
    
    CGFloat x, y ,width ,height;
    
    CGSize size = [MLLabel getViewSizeByString:shareMessage.title maxWidth:MaxBubbleWidth-BubbleContentPadding font:TitleTextFont];


    //气泡
    width = MaxBubbleWidth;
    height = size.height+UnitPadding+ThumbSize+BubbleContentPadding;
    y= CGRectGetMinY(self.userAvatarView.frame)-2+ [self getUserNickLabelOffset];
    if (shareMessage.bIsMe) {
        x= CGRectGetMinX(self.userAvatarView.frame) - Padding - width;
        _bubbleView.direction = BubbleDirectionRight;
    }else{
        x= CGRectGetMaxX(self.userAvatarView.frame) + Padding;
        _bubbleView.direction = BubbleDirectionLeft;
    }
    _bubbleView.frame = CGRectMake(x, y, width, height);
    
    [super updateStatusViewFrame:_bubbleView bIsMe:shareMessage.bIsMe];
    
    
    
    x = 0;
    y = 0;
    width = size.width;
    height = size.height;
    _titleLabel.frame = CGRectMake(x, y, width, height);
    _titleLabel.text = shareMessage.title;
    
    y = CGRectGetMaxY(_titleLabel.frame) + UnitPadding;
    width = ThumbSize;
    height = width;
    _thumbView.frame = CGRectMake(x, y, width, height);
    [_thumbView sd_setImageWithURL:[NSURL URLWithString:shareMessage.thumb]];
    
    x = CGRectGetMaxX(_thumbView.frame) + UnitPadding;
    y = CGRectGetMinY(_thumbView.frame);
    width = MaxBubbleWidth-BubbleContentPadding - ThumbSize - UnitPadding;
    height = ThumbSize;
    _descLabel.frame = CGRectMake(x, y, width, height);
    
    _descLabel.text = shareMessage.desc;
    
}


+(CGFloat) getCellHeight:(DFShareMessage *) shareMessage
{
    CGFloat height = [DFBaseMessageCell getBaseCellHeight:shareMessage];
    

    CGSize size = [MLLabel getViewSizeByString:shareMessage.title maxWidth:MaxBubbleWidth-BubbleContentPadding font:TitleTextFont];

    height += size.height + UnitPadding+ThumbSize+BubbleContentPadding;
    
    return height;
    
}
@end
