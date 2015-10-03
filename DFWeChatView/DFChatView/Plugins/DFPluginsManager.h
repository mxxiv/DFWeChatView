//
//  DFPluginsManager.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/19.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "DFBasePlugin.h"

//default plugins
#import "DFPhotoAlbumPlugin.h"
#import "DFPhotoCameraPlugin.h"
#import "DFVideoChatPlugin.h"
#import "DFVideoShortPlugin.h"




@interface DFPluginsManager : NSObject


+(instancetype) sharedInstance;

-(void) addPlugin:(DFBasePlugin *) plugin;

-(NSMutableArray *) getPlugins;

-(void) setParentController:(UIViewController *) controller;

@end
