//
//  DFTextMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFTipMessageCell.h"

#import "DFTipMessage.h"

#import "MLLabel+Size.h"


#define TipCellHeight 30
#define ContentLabelFont [UIFont systemFontOfSize:11]
#define CellWidth [UIScreen mainScreen].bounds.size.width
#define ContentLabelMaxWidth [UIScreen mainScreen].bounds.size.width*0.8

#define ContentLabelVerticalPadding 20

@interface DFTipMessageCell()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation DFTipMessageCell

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
    self.backgroundColor =[UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.backgroundColor = [UIColor lightGrayColor];
        _contentLabel.layer.cornerRadius = 3;
        _contentLabel.layer.masksToBounds = YES;
        _contentLabel.font = ContentLabelFont;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
}


-(void) updateWithMessage:(DFTipMessage *) tipMessage
{
    
    CGFloat x, y ,width ,height;
    
    CGSize size = [MLLabel getViewSizeByString:tipMessage.content maxWidth:ContentLabelMaxWidth font:ContentLabelFont lineHeight:1.0 lines:0];
    
    width = size.width+6;
    height = size.height+3;
    x = (CellWidth - width)/2;
    y = ContentLabelVerticalPadding;
    _contentLabel.frame = CGRectMake(x, y, width, height);
    _contentLabel.text = tipMessage.content;
    
    
}


+(CGFloat) getCellHeight:(DFTipMessage *) tipMessage
{
    
    CGSize size = [MLLabel getViewSizeByString:tipMessage.content maxWidth:ContentLabelMaxWidth font:ContentLabelFont lineHeight:1.0 lines:0];

    return size.height + 2* ContentLabelVerticalPadding;
}
@end
