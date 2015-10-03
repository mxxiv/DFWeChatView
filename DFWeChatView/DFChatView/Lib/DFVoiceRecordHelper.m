//
//  DFVoiceRecordHelper.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/27.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFVoiceRecordHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface DFVoiceRecordHelper()

@end


@implementation DFVoiceRecordHelper

-(void) start
{
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    
    NSDictionary *setting = [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithFloat: 44100.0],AVSampleRateKey, [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey, [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey, [NSNumber numberWithInt: 2], AVNumberOfChannelsKey, [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey, [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,nil];
}


-(void) stop
{
    
}



@end
