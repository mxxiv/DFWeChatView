//
//  DFBaseMessage.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/21.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


typedef NS_ENUM(NSUInteger, MessageType){
    MessageTypeTip = 1,
    MessageTypeText = 11,
    MessageTypeImage,
    MessageTypeEmotion,
    MessageTypeVoice,
    MessageTypeVideo,
    MessageTypeLocation,
    MessageTypeNAMECARD,
    MessageTypeTRANSFER,
    MessageTypeREDBAG,
    MessageTypeGIFT,
    MessageTypeCOUPON,
    MessageTypeShare,
    MessageTypeMUSIC,
    MessageTypeSHOP,
};


typedef NS_ENUM(NSUInteger, MessageStatus){
    MessageStatusSending = 1,
    MessageStatusSent,
    MessageStatusFailed,
    MessageStatusReceived,
};


@interface DFBaseMessage : NSObject

@property (assign, nonatomic) long long messageId;

@property (assign, nonatomic) MessageType messageType;

@property (assign, nonatomic) MessageStatus messageStatus;

@property (assign, nonatomic) long long ts;

@property (assign, nonatomic) BOOL bShowTime;

@property (assign, nonatomic) BOOL bShowUserNick;

@property (assign, nonatomic) BOOL bIsMe;

@property (assign, nonatomic) NSInteger userId;

@property (strong, nonatomic) NSString *userNick;

@property (strong, nonatomic) NSString *userAvatar;

@property (assign, nonatomic) CGFloat cellHeight;

@property (assign, nonatomic) NSInteger rowIndex;

@end
