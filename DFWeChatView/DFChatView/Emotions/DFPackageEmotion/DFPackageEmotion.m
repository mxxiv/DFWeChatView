//
//  DFPackageEmotion.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFPackageEmotion.h"
#import "DFPackageEmotionItem.h"
#import "Key.h"

#define EmojiItemSize 60

#define Columns 4
#define Rows 2

@interface DFPackageEmotion()

@property (strong,nonatomic) NSMutableArray *items;
@end




@implementation DFPackageEmotion


- (instancetype)initWithIcon:(NSString *) icon total:(NSInteger) total items: (NSMutableArray *) items;
{
    self = [super init];
    if (self) {
        _items = items;
        
        self.tabIconImage = [UIImage imageWithContentsOfFile:icon];
        self.total = total;
        self.pages = ceil(total/(double)(Columns*Rows));
    }
    return self;
}


-(UIView *) getView
{
    CGFloat x, y, width, height, horizontalSpace, verticalSpace;
    
    horizontalSpace = (EmotionViewPageWidth - EmojiItemSize * Columns)/(Columns+1);
    verticalSpace = (EmotionViewPageHeight - EmojiItemSize * Rows)/(Rows+1);
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.pages * EmotionViewPageWidth, EmotionViewPageHeight)];
    
    //view.backgroundColor =[UIColor redColor];
    
    
    NSInteger index = 1;
    for (int page = 1; page <= self.pages ; page++) {
        
        for (int row = 1; row <= Rows ; row++) {
            
            for (int column = 1; column <= Columns ; column++) {
                
                if (index > self.total) {
                    break;
                }
                x = (page - 1)*EmotionViewPageWidth + horizontalSpace + (column - 1) *(horizontalSpace+EmojiItemSize);
                y = verticalSpace + (row - 1)*(verticalSpace+EmojiItemSize)-10;
                width = EmojiItemSize;
                height = EmojiItemSize;
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
                [view addSubview:btn];
                //btn.backgroundColor = [UIColor darkGrayColor];
                [btn addTarget:self action:@selector(onEmotionClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                DFPackageEmotionItem *item = [_items objectAtIndex:index-1];
                [btn setImage:[UIImage imageWithContentsOfFile:item.localThumb] forState:UIControlStateNormal];
                //NSInteger edge = 18;
                //[btn setImageEdgeInsets:UIEdgeInsetsMake(0, edge, edge, edge)];
                
                UILabel *nameLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, height, width, 15)];
                nameLabel.text = item.name;
                nameLabel.textColor = [UIColor darkGrayColor];
                nameLabel.font = [UIFont systemFontOfSize:10];
                nameLabel.textAlignment = NSTextAlignmentCenter;
                [btn addSubview:nameLabel];
                
                btn.tag = index-1;
                
                index++;
                
            }
            
        }
        
    }
    
    
    
    
    return view;
}

-(void) onEmotionClicked:(UIButton *) btn
{
    DFPackageEmotionItem *item = [_items objectAtIndex:btn.tag];
    NSDictionary *dic = @{@"item":item};
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_EMOTION_MESSAGE object:nil userInfo:dic];
    
}

@end
