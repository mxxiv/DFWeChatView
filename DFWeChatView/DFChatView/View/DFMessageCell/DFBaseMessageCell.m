//
//  DFBaseMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseMessageCell.h"
#import "DFBaseMessage.h"

#import "UIImageView+WebCache.h"

#import "DFToolUtil.h"

#import "MLLabel+Size.h"

#define TimeLabelFont [UIFont systemFontOfSize:11]

#define NickLabelFont [UIFont systemFontOfSize:12]

#define StatusViewSize 20

#define UserNickLabelHeight 20

@implementation DFBaseMessageCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bIsMenuShow = NO;
        
        [self addNotify];
        [self initBaseCell];
    }
    return self;
}

-(void)dealloc
{
    [self removeNotify];
}


-(void) addNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMenuShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMenuHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
}

-(void) removeNotify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}



-(void) initBaseCell

{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor =[UIColor clearColor];
    
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.backgroundColor = [UIColor colorWithWhite:245/255.0 alpha:1.0];
        _timeLabel.layer.cornerRadius = 3;
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.font = TimeLabelFont;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.hidden = YES;
    }
    
    
    if (_userAvatarView == nil) {
        _userAvatarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_userAvatarView];
        _userAvatarView.layer.borderWidth = 0.4;
        _userAvatarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    
    if (_userNickLabel == nil) {
        _userNickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNickLabel.font = NickLabelFont;
        _userNickLabel.textColor = [UIColor colorWithWhite:180/255.0 alpha:1.0];
        _userNickLabel.hidden = YES;
        [self.contentView addSubview:_userNickLabel];
    }
    
    
    if (_messageStatusView == nil) {
        _messageStatusView = [[DFMessageStatusView alloc] initWithFrame:CGRectMake(0, 0, StatusViewSize, StatusViewSize)];
        [self.contentView addSubview:_messageStatusView];
    }
    
    
}


-(void) updateWithMessage:(DFBaseMessage *) message
{
    _message = message;
    
    CGFloat x, y ,width ,height;
    
    //时间
    if (message.bShowTime) {
        _timeLabel.hidden = NO;
        
        NSString *time = [DFToolUtil preettyTime:message.ts];
        CGSize size = [MLLabel getViewSizeByString:time font:TimeLabelFont];
        width = size.width+6;
        height = size.height+3;
        x= (CellWidth - width)/2;
        y= (TimeLabelSpace - height)/2;
        _timeLabel.frame = CGRectMake(x, y, width, height);
        _timeLabel.text = time;
    }else{
        _timeLabel.hidden = YES;
    }
    
    
    //用户头像
    if (message.bIsMe) {
        x = CellWidth - Padding - UserAvatarSize;
    }else{
        x = Padding;
    }
    
    if (message.bShowTime) {
        y = TimeLabelSpace;
    }else{
        y=0;
    }
    
    width = UserAvatarSize;
    height = width;
    
    _userAvatarView.frame = CGRectMake(x, y, width, height);
    [_userAvatarView sd_setImageWithURL:[NSURL URLWithString:message.userAvatar]];
    
    
    
    
    // 昵称
    if (!message.bIsMe && message.bShowUserNick) {
        x = CGRectGetMaxX(_userAvatarView.frame) + 13;
        y = CGRectGetMinY(_userAvatarView.frame) +2;
        height = 15;
        width = CellWidth - x - 30;
        _userNickLabel.frame = CGRectMake(x, y, width, height);
        _userNickLabel.hidden = NO;
        _userNickLabel.text = message.userNick;
    }else{
        _userNickLabel.hidden = YES;
    }
    
    
    [_messageStatusView changeStatus:message.messageStatus];
    
}


-(void)updateStatusViewFrame:(UIView *)view bIsMe:(BOOL)bIsMe xOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset
{
    CGFloat x,y;
    if (bIsMe) {
        x= CGRectGetMinX(view.frame)-StatusViewXOffset-xOffset;
    }else{
        x= CGRectGetMaxX(view.frame)+StatusViewXOffset+xOffset;
    }
    
    y = CGRectGetMidY(view.frame)-StatusViewYOffset-yOffset;
    _messageStatusView.center = CGPointMake(x, y);
}


-(void)updateStatusViewFrame:(UIView *)view bIsMe:(BOOL)bIsMe
{
    [self updateStatusViewFrame:view bIsMe:bIsMe xOffset:0 yOffset:0];
}


+(CGFloat) getBaseCellHeight:(DFBaseMessage *) message
{
    CGFloat height = CellBottomSpace;
    //时间
    if (message.bShowTime) {
        height+=TimeLabelSpace;
    }
    
    if (!message.bIsMe && message.bShowUserNick) {
        
        height+= UserNickLabelHeight;
    }
    
    
    return  height;
    
}

-(CGFloat)getUserNickLabelOffset
{
    if (!_message.bIsMe && _message.bShowUserNick) {
        
        return UserNickLabelHeight;
    }else{
        return 0;
    }
    
}



#pragma mark - Menu

-(void) onMenuShow:(NSNotification *) notify
{
    [self onMenuShow];
}

-(void) onMenuHide:(NSNotification *) notify
{
    [self onMenuHide];
}

-(void) onMenuShow
{
    
}

-(void) onMenuHide
{
    
}

-(BOOL) canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    NSArray *selectors = [self getMenuActionSelector];
    if (selectors == nil) {
        return NO;
    }
    
    for (NSString *s in selectors) {
        if (action == NSSelectorFromString(s)) {
            return YES;
        }
    }
    return NO;
}

-(NSArray *) getMenuActionSelector
{
    return nil;
}


@end
