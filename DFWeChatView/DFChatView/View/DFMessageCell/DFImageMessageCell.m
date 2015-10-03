//
//  DFTextMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFImageMessageCell.h"

#import "DFImageMessage.h"

#import "HJShapedImageView.h"

#import "UIImageView+WebCache.h"

#import "Key.h"

#define IMAGE_BUBBLE_WIDTH  MaxBubbleWidth*0.7

@interface DFImageMessageCell()

@property (strong,nonatomic) HJShapedImageView *imgView;


@property (strong,nonatomic) UIButton *clickButton;


@end

@implementation DFImageMessageCell

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
    if (_imgView == nil) {
        _imgView =[[HJShapedImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imgView];
    }
    
    
    if (_clickButton == nil) {
        _clickButton =[[UIButton alloc] initWithFrame:CGRectZero];
        //_clickButton.backgroundColor = [UIColor redColor];
        [_clickButton addTarget:self action:@selector(onImageClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_clickButton];
    }
    
}


-(void) updateWithMessage:(DFImageMessage *) imageMessage
{
    [super updateWithMessage:imageMessage];

    CGFloat x, y ,width ,height;
    
    
    CGFloat rate = imageMessage.width/(double)imageMessage.height;
    
    if (imageMessage.width >= imageMessage.height) {
        if (imageMessage.width > IMAGE_BUBBLE_WIDTH) {
            imageMessage.width = IMAGE_BUBBLE_WIDTH;
            imageMessage.height = imageMessage.width / rate;
        }
        
    }else{
        if (imageMessage.height > IMAGE_BUBBLE_WIDTH) {
            imageMessage.height = IMAGE_BUBBLE_WIDTH;
            imageMessage.width = imageMessage.height * rate;
        }
        
    }
    width = imageMessage.width;
    height =imageMessage.height;
    y= CGRectGetMinY(self.userAvatarView.frame)-2+ [self getUserNickLabelOffset];
    
    if (imageMessage.bIsMe) {
        x= CGRectGetMinX(self.userAvatarView.frame) - Padding - width;
    }else{
        x= CGRectGetMaxX(self.userAvatarView.frame) + Padding;
    }
    
    
    
    if (imageMessage.bIsMe) {
        _imgView.mask = @"SenderTextNodeBkg@2x.png";
    }else{
        _imgView.mask = @"ReceiverTextNodeBkg@2x.png";
    }
    _imgView.frame = CGRectMake(x, y, width, height);
    
    
    _clickButton.tag = imageMessage.rowIndex;
    _clickButton.frame = _imgView.frame;
    
    
    
    [super updateStatusViewFrame:_imgView bIsMe:imageMessage.bIsMe];
    
    
    
    //默认先从url加载
    if (imageMessage.thumbUrl != nil) {
        
        NSString *key = imageMessage.thumbUrl;
        
        SDImageCache *cache = [SDImageCache sharedImageCache];
        
        UIImage *img = [cache imageFromMemoryCacheForKey:key];
        if (img == nil) {
            img = [cache imageFromDiskCacheForKey:key];
        }
        
        if (img == nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:key]]];
                [cache storeImage:img forKey:key toDisk:YES];
                [self performSelectorOnMainThread:@selector(updateImageView:) withObject:img waitUntilDone:NO];
            });
            
        }else{
            
            _imgView.image = img;
        }
        
        return;
    }
    
    
    if (imageMessage.image != nil) {
        _imgView.image = imageMessage.image;
        return;
    }
    
    if (imageMessage.localPath != nil) {
        _imgView.image = [UIImage imageNamed:imageMessage.localPath];
    }
    
    //_imgView.backgroundColor = [UIColor redColor];
    
}

-(void) updateImageView:(UIImage *) img
{
    _imgView.image = img;
}


-(void) onImageClicked:(UIButton *) sender
{
    NSLog(@"%ld", (long)sender.tag);
    
    NSDictionary *dic = @{@"rowIndex":[NSNumber numberWithLongLong:sender.tag], @"imageView": _imgView};
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_IMAGE_CLIECKED object:nil userInfo:dic];
}


+(CGFloat) getCellHeight:(DFImageMessage *) imageMessage
{
    CGFloat height = [DFBaseMessageCell getBaseCellHeight:imageMessage];
    
    CGFloat rate = imageMessage.width/(double)imageMessage.height;
    if (imageMessage.width > IMAGE_BUBBLE_WIDTH) {
        imageMessage.width = IMAGE_BUBBLE_WIDTH;
        imageMessage.height = imageMessage.width / rate;
    }
    height += imageMessage.height;
    
    return height;
    
}
@end
