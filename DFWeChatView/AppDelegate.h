//
//  AppDelegate.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/17.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ViewController2.h"
#import "ViewController3.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong,nonatomic) ViewController *controller;

@property (strong,nonatomic) ViewController2 *controller2;

@property (strong,nonatomic) ViewController3 *controller3;

@property (strong, nonatomic) UIWindow *window;


@end

