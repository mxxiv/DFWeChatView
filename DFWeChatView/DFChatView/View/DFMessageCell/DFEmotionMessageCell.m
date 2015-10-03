//
//  DFTextMessageCell.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/22.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFEmotionMessageCell.h"
#import "DFEmotionMessage.h"

#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

#import "UIImageView+WebCache.h"

#import "DFSandboxHelper.h"

#import "DFToolUtil.h"

#define EmotionItemSize 130

#define EmotionItemOffset 5


@interface DFEmotionMessageCell()

@property (nonatomic,strong) FLAnimatedImageView *emotionImageView;

@end

@implementation DFEmotionMessageCell

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
    if (_emotionImageView == nil) {
        _emotionImageView = [[FLAnimatedImageView alloc] init];
        [self addSubview:_emotionImageView];
    }
}


-(void) updateWithMessage:(DFEmotionMessage *) emotionMessage
{
    [super updateWithMessage:emotionMessage];
    
    CGFloat x, y ,width ,height;
    
    width = EmotionItemSize;
    height = EmotionItemSize;
    
    y = CGRectGetMinY(self.userAvatarView.frame) + EmotionItemOffset + [self getUserNickLabelOffset];
    
    if (emotionMessage.bIsMe) {
        x = CGRectGetMinX(self.userAvatarView.frame) - Padding - EmotionItemSize;
    }else{
        x = CGRectGetMaxX(self.userAvatarView.frame) + Padding;
    }
    
    DFPackageEmotionItem *item = emotionMessage.emotionItem;
    
    NSData *data = nil;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (item.localGif != nil) {
        data = [NSData dataWithContentsOfFile:item.localGif];
    }else if(item.remoteGif != nil){
        
        NSString *key = [DFToolUtil md5:item.remoteGif];
        NSString *dirPath = [NSString stringWithFormat:@"%@/%@",[DFSandboxHelper getDocPath], @"/gifCache/"];
        BOOL isDir = YES;
        if (![manager fileExistsAtPath:dirPath isDirectory:&isDir]) {
            [manager createDirectoryAtPath:dirPath attributes:nil];
        }
        
        NSString *filePath = [NSString stringWithFormat:@"%@%@",dirPath, key];
        
        if ([manager fileExistsAtPath:filePath]) {
            data = [NSData dataWithContentsOfFile:filePath];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSData  *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.remoteGif]];
                [data writeToFile:filePath atomically:YES];
                [self performSelectorOnMainThread:@selector(updateImageView:) withObject:data waitUntilDone:NO];
            });
            
                    }
    }
    if (data != nil) {
        FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
        
        _emotionImageView.animatedImage = image;
    }

    _emotionImageView.frame = CGRectMake(x, y, width, height);
    
    
    [super updateStatusViewFrame:_emotionImageView bIsMe:emotionMessage.bIsMe];
}


-(void) updateImageView:(NSData *) data
{
    FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
    
    _emotionImageView.animatedImage = image;
}


+(CGFloat) getCellHeight:(DFEmotionMessage *) emotionMessage
{
    CGFloat height = [DFBaseMessageCell getBaseCellHeight:emotionMessage];
    
    height+= EmotionItemOffset+EmotionItemSize;
    
    return height;
    
}
@end
