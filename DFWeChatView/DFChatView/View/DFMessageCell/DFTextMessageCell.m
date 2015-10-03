//
//  DFTextMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFTextMessageCell.h"

#import "DFTextMessage.h"

#import "MLLabel+Size.h"


#import "DFEmotionsManager.h"
#import "NSString+MLExpression.h"

#define MsgViewLineHeightMulti 1.2f

#define TextBubbleMinWidth 30

#define TextFont [UIFont systemFontOfSize:16]


#import "DFTextBubbleView.h"

@interface DFTextMessageCell()<DFBaseBubbleViewDelegate>

@property (strong,nonatomic) MLLinkLabel *textView;

@property (strong,nonatomic) DFTextBubbleView *bubbleView;


@property (strong,nonatomic) UIMenuItem *copeeItem;
@property (strong,nonatomic) UIMenuItem *forwardItem;
@property (strong,nonatomic) UIMenuItem *collectItem;
@property (strong,nonatomic) UIMenuItem *translateItem;
@property (strong,nonatomic) UIMenuItem *cancelItem ;
@property (strong,nonatomic) UIMenuItem *moreItem;

@end

@implementation DFTextMessageCell

#pragma mark - Lifecycle
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
        _bubbleView = [[DFTextBubbleView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_bubbleView];
        _bubbleView.delegate = self;
        
    }
    
    if (_textView == nil) {
        _textView =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _textView.textColor = [UIColor blackColor];
        _textView.font = TextFont;
        _textView.numberOfLines = 0;
        //_textView.textAlignment = NSTextAlignmentLeft;
        _textView.adjustsFontSizeToFitWidth = NO;
        _textView.textInsets = UIEdgeInsetsZero;
        _textView.lineHeightMultiple = MsgViewLineHeightMulti;
        
        _textView.dataDetectorTypes = MLDataDetectorTypeAll;
        _textView.allowLineBreakInsideLinks = NO;
        _textView.linkTextAttributes = nil;
        _textView.activeLinkTextAttributes = nil;
        [_bubbleView.contentView addSubview:_textView];
    }
    
}




-(void) updateWithMessage:(DFTextMessage *) textMessage
{
    [super updateWithMessage:textMessage];
    
    CGFloat x, y ,width ,height;
    
    //计算文字需要的范围
    NSAttributedString *text = [textMessage.text expressionAttributedStringWithExpression: [[DFEmotionsManager sharedInstance] sharedMLExpression]];
    CGSize textSize = textMessage.size;
    
    if (textSize.width == 0) {
        textSize = [MLLabel getViewSize:text maxWidth:MaxBubbleWidth-BubbleContentPadding font:TextFont lineHeight:MsgViewLineHeightMulti lines:0];
    }
    
    NSLog(@"直接获取高度");
    
    
    //气泡
    width = BubbleContentPadding + textSize.width;
    height = BubbleContentPadding + textSize.height;
    y= CGRectGetMinY(self.userAvatarView.frame)-2 + [self getUserNickLabelOffset];
    if (textMessage.bIsMe) {
        x= CGRectGetMinX(self.userAvatarView.frame) - Padding - width;
        _bubbleView.direction = BubbleDirectionRight;
    }else{
        x= CGRectGetMaxX(self.userAvatarView.frame) + Padding;
        _bubbleView.direction = BubbleDirectionLeft;
    }
    _bubbleView.frame = CGRectMake(x, y, width, height);
    
    
    [super updateStatusViewFrame:_bubbleView bIsMe:textMessage.bIsMe];
    
    
    //文字
    x = 0;
    y = 0;
    width = textSize.width;
    height = textSize.height;
    _textView.frame = CGRectMake(x, y, width, height);
    //[_textView showMessage:textMessage.text];
    
    _textView.attributedText = text;
    [_textView sizeToFit];
    
    
}


+(CGFloat) getCellHeight:(DFTextMessage *) textMessage
{
    CGFloat height = [DFBaseMessageCell getBaseCellHeight:textMessage];
    
    //计算文字需要的范围
    NSAttributedString *text = [textMessage.text expressionAttributedStringWithExpression: [[DFEmotionsManager sharedInstance] sharedMLExpression]];
    CGSize textSize = [MLLinkLabel getViewSize:text maxWidth:MaxBubbleWidth-BubbleContentPadding font:TextFont lineHeight:MsgViewLineHeightMulti lines:0];
    textMessage.size = textSize;
    
    NSLog(@"生成高度");
    
    if (textSize.width < TextBubbleMinWidth) {
        textSize.width = TextBubbleMinWidth;
    }
    
    height += BubbleContentPadding + textSize.height;
    
    return height;
    
}


#pragma mark - Method

-(void) onMenuShow
{
    if (self.bIsMenuShow) {
        _bubbleView.selected = YES;
    }
}

-(void) onMenuHide
{
    if (self.bIsMenuShow) {
        _bubbleView.selected = NO;
    }
    self.bIsMenuShow = NO;
}

-(NSArray *)getMenuActionSelector
{
    return @[@"menuCopy:", @"menuTranslate:", @"menuCancel:", @"menuForward:", @"menuCollect:", @"menuMore:"];
}

- (void)menuCopy:(id)sender
{
    DFTextMessage *textMessage = (DFTextMessage *)self.message;
    [UIPasteboard generalPasteboard].string = textMessage.text;
}

- (void)menuForward:(id)sender
{
    NSLog(@"forward.....");
}

- (void)menuCollect:(id)sender
{NSLog(@"collect.....");
}

- (void)menuTranslate:(id)sender
{
    NSLog(@"translate.....");
}

- (void)menuCancel:(id)sender
{
    NSLog(@"cancel.....");
}

- (void)menuMore:(id)sender
{
    NSLog(@"more.....");
}



#pragma mark - DFBaseBubbleViewDelegate

-(void) onLongPress
{
    [self showMenu];
}

-(void) onTap
{
    if (self.bIsMenuShow) {
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuVisible:NO animated:YES];
    }
}

-(void) showMenu
{
    self.bIsMenuShow = YES;
    
    [self becomeFirstResponder];
    
    [self initMenuItem];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (self.message.bIsMe) {
        [menu setMenuItems:@[_copeeItem,_forwardItem, _collectItem, _cancelItem, _translateItem,_moreItem]];
    }else{
        [menu setMenuItems:@[_copeeItem,_forwardItem, _collectItem, _translateItem,_moreItem]];
    }
    
    CGFloat x, y, width,height;
    x = 0;
    y = 0;
    width = _bubbleView.frame.size.width;
    height = _bubbleView.frame.size.height;
    [menu setTargetRect:CGRectMake(x, y, width, height) inView:_bubbleView];
    [menu setMenuVisible:YES animated:YES];
    [menu setArrowDirection:UIMenuControllerArrowDown];
}

-(void) initMenuItem
{
    if (_copeeItem == nil) {
        _copeeItem = [[UIMenuItem alloc] initWithTitle:@"复制"action:@selector(menuCopy:)];
    }
    if (_forwardItem == nil) {
        _forwardItem = [[UIMenuItem alloc] initWithTitle:@"转发"action:@selector(menuForward:)];
    }
    if (_collectItem == nil) {
        _collectItem = [[UIMenuItem alloc] initWithTitle:@"收藏"action:@selector(menuCollect:)];
    }
    
    if (_translateItem == nil) {
        _translateItem = [[UIMenuItem alloc] initWithTitle:@"翻译"action:@selector(menuTranslate:)];
    }
    if (_cancelItem == nil) {
        _cancelItem = [[UIMenuItem alloc] initWithTitle:@"撤回"action:@selector(menuCancel:)];
    }
    
    if (_moreItem == nil) {
        _moreItem = [[UIMenuItem alloc] initWithTitle:@"更多..."action:@selector(menuMore:)];
    }
    
}

@end
