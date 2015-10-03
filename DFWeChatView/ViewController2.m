//
//  ViewController2.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "ViewController2.h"
#import "DFPluginsView.h"

#import "DFEmotionsView.h"

#import "HJShapedImageView.h"


#import "DFTextBubbleView.h"

@interface ViewController2 ()

@property (strong,nonatomic) DFPluginsView *pluginsView;

@property (strong,nonatomic) DFEmotionsView *emotionsView;


@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor =[UIColor whiteColor];
//    
//    _pluginsView = [[DFPluginsView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 216.0)];
//    //[self.view addSubview:_pluginsView];
//    
//    
//    
//    _emotionsView = [[DFEmotionsView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 216.0)];
//    [self.view addSubview:_emotionsView];
    
//    HJShapedImageView *shapedImageView = [[HJShapedImageView alloc] initWithFrame:CGRectMake(150, 100, 60, 150)];
//    shapedImageView.image = [UIImage imageNamed:@"scenery.jpg"];
//    [self.view addSubview:shapedImageView];

    DFTextBubbleView *bubble = [[DFTextBubbleView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:bubble];
    
    bubble.direction = BubbleDirectionLeft;
    bubble.frame = CGRectMake(40, 90, 200, 120);
    
    //bubble.backgroundColor =[UIColor redColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
