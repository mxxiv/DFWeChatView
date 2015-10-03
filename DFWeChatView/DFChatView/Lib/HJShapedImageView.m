//
//  ShapedImageView.m
//  ShapedImageView
//
//  Created by Sword on 11/16/14.
//  Copyright (c) 2014 Sword. All rights reserved.
//

#import "HJShapedImageView.h"

@interface HJShapedImageView()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end

@implementation HJShapedImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale; //非常关键设置自动拉伸的效果且不变形
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
    
}

-(void)layoutSubviews
{
    _maskLayer.frame = self.bounds;
    _contentLayer.frame = self.bounds;
    
}

- (void)setImage:(UIImage *)image
{
    if (image == nil) {
        return;
    }
    _contentLayer.contents = (id)image.CGImage;
}

-(void)setMask:(NSString *)mask
{
    _maskLayer.contents = (id)[UIImage imageNamed:mask].CGImage;
}

@end
