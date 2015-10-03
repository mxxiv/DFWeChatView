//
//  ViewController.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/17.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "ViewController.h"

#import "DFSandboxHelper.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@property (nonatomic, strong) DFMessageDispatcher *dispatcher;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initPlugins];
        
        [self initEmotions];
        
        [self initCellAdapters];
    }
    return self;
}


-(void) initPlugins
{
    DFPluginsManager *manager = [DFPluginsManager sharedInstance];
    
    DFPhotoAlbumPlugin *photoAlbumPlugin = [[DFPhotoAlbumPlugin alloc] init];
    photoAlbumPlugin.parentController = self;
    [manager addPlugin:photoAlbumPlugin];
    
    DFPhotoCameraPlugin *photoCameraPlugin = [[DFPhotoCameraPlugin alloc] init];
    photoCameraPlugin.parentController = self;
    [manager addPlugin:photoCameraPlugin];
    
    
    DFVideoShortPlugin *videoShortPlugin = [[DFVideoShortPlugin alloc] init];
    [manager addPlugin:videoShortPlugin];
    
    
    
    DFVideoChatPlugin *videoChatPlugin = [[DFVideoChatPlugin alloc] init];
    [manager addPlugin:videoChatPlugin];
    
    [manager addPlugin:videoChatPlugin];
    [manager addPlugin:videoChatPlugin];
    [manager addPlugin:videoChatPlugin];
    [manager addPlugin:videoChatPlugin];
    [manager addPlugin:videoChatPlugin];
    [manager addPlugin:videoChatPlugin];
    
}


-(void) initEmotions
{
    DFEmotionsManager *manager = [DFEmotionsManager sharedInstance];
    
    DFEmojiEmotion *emoji = [[DFEmojiEmotion alloc] init];
    [manager addEmotion:emoji];
    
    [self addPackageEmotions];
}


-(void) initCellAdapters
{
    DFCellAdapterManager *manager = [DFCellAdapterManager sharedInstance];
    
    [manager registerAdapter:MessageTypeTip adapter:[[DFTipCellAdapter alloc] init]];
    [manager registerAdapter:MessageTypeText adapter:[[DFTextCellAdapter alloc] init]];
    [manager registerAdapter:MessageTypeEmotion adapter:[[DFEmotionCellAdapter alloc] init]];
    [manager registerAdapter:MessageTypeImage adapter:[[DFImageCellAdapter alloc] init]];
    [manager registerAdapter:MessageTypeShare adapter:[[DFShareCellAdapter alloc] init]];
    [manager registerAdapter:MessageTypeREDBAG adapter:[[DFRedBagCellAdapter alloc] init]];
    [manager registerAdapter:MessageTypeVoice adapter:[[DFVoiceCellAdapter alloc] init]];
    
}

-(void) addPackageEmotions
{
    //
    NSString *docPath = [DFSandboxHelper getDocPath];
    
    // NSLog(@"%@",docPath);
    
    NSString *emotionsPath = [NSString stringWithFormat:@"%@/%@",docPath, @"Emotions"];
    
    // NSLog(@"%@",emotionsPath);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *dirs = [manager contentsOfDirectoryAtPath:emotionsPath error:nil];
    
    for (NSString *dir in dirs) {
        
        if (![dir isEqualToString:@".DS_Store"]) {
            
            
            NSString *rootPath = [NSString stringWithFormat:@"%@/%@",emotionsPath, dir];
            
            
            NSString *configPath = [NSString stringWithFormat:@"%@/%@.json",rootPath, dir];
            
            //NSLog(@"%@",configPath);
            BOOL isDir = NO;
            if ([manager fileExistsAtPath:configPath isDirectory: &isDir]) {
                NSString *content = [NSString stringWithContentsOfFile:configPath encoding:NSUTF8StringEncoding error:nil];
                
                NSDictionary *dic = [self dictionaryWithJsonString:content];
                //NSLog(@"%@",dic);
                
                
                NSString *iconPath = [NSString stringWithFormat:@"%@/icon@%dx.png",rootPath, (int)[UIScreen mainScreen].scale];
                
                NSMutableArray *items = [NSMutableArray array];
                NSArray *emotions = [dic objectForKey:@"emotions"];
                for (NSDictionary *itemDic in emotions) {
                    DFPackageEmotionItem *item = [[DFPackageEmotionItem alloc] initWithDic:itemDic rootPath:rootPath];
                    [items addObject:item];
                }
                
                
                
                DFPackageEmotion *emotion = [[DFPackageEmotion alloc] initWithIcon:iconPath total:[[dic objectForKey:@"count"] integerValue] items:items];
                [[DFEmotionsManager sharedInstance] addEmotion:emotion];
            }
            
        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊天";
    
    _dispatcher =[[DFMessageDispatcher alloc] init];
    _dispatcher.delegate = self;
    
    [self test];
    //[self addTemp];
    
    DFTipMessage *message = [[DFTipMessage alloc] init];
    message.content = @"Allen加入了讨论组";
    [super addMessage:message];
    
}

-(BOOL)showUserNick
{
    return YES;
}

-(void) test
{
    [self addTemp];
    
    
    DFRedBagMessage *bagMessage = [[DFRedBagMessage alloc] init];
    bagMessage.bIsMe = YES;
    bagMessage.ts = [[NSDate date] timeIntervalSinceNow];
    bagMessage.title = @"1,000,000 RMB";
    bagMessage.desc = @"点击领取红包";
    bagMessage.sign = @"年终奖";
    [super addMessage:bagMessage];
    [self setUserAvatar:bagMessage];
    
    
    
    
    DFShareMessage *shareMessage = [[DFShareMessage alloc] init];
    shareMessage.bIsMe = NO;
    shareMessage.ts = [[NSDate date] timeIntervalSinceNow];
    shareMessage.title = @"快快来参加我的活动啦 快来报名参加不见不散";
    shareMessage.thumb = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3521510885,2343345810&fm=58";
    shareMessage.desc=@"一起去吃大餐 快来参加我们的活动吧 详情请点击 更多内容请猛戳这里";
    shareMessage.userNick = @"王老五";
    shareMessage.bShowUserNick = YES;
    [super addMessage:shareMessage];
    [self setUserAvatar:shareMessage];
    
    
    
    DFImageMessage *imageMessage = [[DFImageMessage alloc] init];
    imageMessage.bIsMe = YES;
    imageMessage.ts = [[NSDate date] timeIntervalSinceNow];
    imageMessage.localPath = @"scenery.jpg";
    imageMessage.width = 300;
    imageMessage.height = 300;
    
    [super addMessage:imageMessage];
    [self setUserAvatar:imageMessage];
    
    
    
    DFShareMessage *shareMessage2 = [[DFShareMessage alloc] init];
    shareMessage2.bIsMe = YES;
    shareMessage.ts = [[NSDate date] timeIntervalSinceNow];
    shareMessage2.title = @"周日大夫山骑单车";
    shareMessage2.thumb = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3521510885,2343345810&fm=58";
    shareMessage2.desc=@"一起集合 快来报名参加 不见不散";
    
    [super addMessage:shareMessage2];
    [self setUserAvatar:shareMessage2];
    
    
    
    
    //[self addTemp];
    
    DFRedBagMessage *bagMessage2 = [[DFRedBagMessage alloc] init];
    bagMessage2.bIsMe = NO;
    bagMessage2.ts = [[NSDate date] timeIntervalSinceNow];
    bagMessage2.title = @"新年快乐 恭喜发财";
    bagMessage2.desc = @"点击领取红包";
    bagMessage2.sign = @"新年红包";
    bagMessage2.userNick = @"王老五";
    bagMessage2.bShowUserNick = YES;
    [super addMessage:bagMessage2];
    [self setUserAvatar:bagMessage2];
    
    [self addTemp];
    
    
}

-(void) addTemp
{
    //临时
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@"hello world!"];
    [array addObject:@"我是你的小苹果 呵呵呵呵 小苹果 傻逼 程序猿"];
    [array addObject:@"即时通信 不丢消息 哈哈"];
    [array addObject:@"顶你个肺"];
    
    [array addObject:@"有那么好？"];
    [array addObject:@"我是你的小苹果 呵呵呵呵 小苹果 傻逼 程序猿 18680551234"];
    
    [array addObject:@"傻逼程序猿"];
    [array addObject:@"乔布斯定义了手机 罗永浩定义了傻逼 @Allen "];
    
    
    [array addObject:@"让天下没有难约的炮 http://www.baidu.com"];
    [array addObject:@"梦想还是要有的 万一实现了呢[亲亲]"];
    
    for (NSString *str in array) {
        DFTextMessage *textMessage = [[DFTextMessage alloc] init];
        //textMessage.messageStatus = MessageStatusSending;
        textMessage.text = str;
        textMessage.ts = 1400009000000;
        //textMessage.previousTs=123457;
        int y = (arc4random() % 2) + 1;
        
        textMessage.bIsMe = y==1?YES:NO;
        
        textMessage.userNick = @"小苹果";
        
        textMessage.bShowUserNick = YES;
        
        [super addMessage:textMessage];
        [self setUserAvatar:textMessage];
        
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark - DFMessageDispatcherDelegate

-(void)onSendTextMessage:(DFTextInput *)textInput
{
    
    DFTextMessage *textMessage = [[DFTextMessage alloc] init];
    textMessage.text = textInput.text;
    textMessage.bIsMe = YES;
    textMessage.ts = [[NSDate date] timeIntervalSince1970]*1000;
    [self setUserAvatar:textMessage];
    long long messageId = textMessage.ts;
    textMessage.messageId = messageId;
    [super addMessage:textMessage];
    
    //测试代码 应该是socket收到发消息回执后再消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*3), dispatch_get_main_queue(), ^{
        
        [super changeMessageStatus:MessageStatusSent messageId:messageId];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*0.1), dispatch_get_main_queue(), ^{
            
            [super changeMessageStatus:MessageStatusFailed messageId:messageId];
        });
    });
    
}

-(void)onSendEmotionMessage:(DFEmotionInput *)emotionInput
{
    
    DFEmotionMessage *emotionMessage = [[DFEmotionMessage alloc] init];
    emotionMessage.emotionItem = emotionInput.item;
    emotionMessage.ts = [[NSDate date] timeIntervalSince1970]*1000;
    int y = (arc4random() % 2) + 1;
    emotionMessage.bIsMe = y==1?YES:NO;
    
    [self setUserAvatar:emotionMessage];
    
    [super addMessage:emotionMessage];

}

-(void)onSendImageMessage:(DFImageInput *)imageInput
{
    CGImageRef ref = [imageInput.asset aspectRatioThumbnail];
    //NSLog(@"%@",[asset valueForProperty:ALAssetPropertyAssetURL]);
    DFImageMessage *imageMessage = [[DFImageMessage alloc] init];
    imageMessage.image = [UIImage imageWithCGImage:ref];
    imageMessage.ts = [[NSDate date] timeIntervalSince1970]*1000;
    imageMessage.bIsMe = YES;
    imageMessage.width = CGImageGetWidth(ref);
    imageMessage.height = CGImageGetHeight(ref);
    [self setUserAvatar:imageMessage];
    
    [super addMessage:imageMessage];
}

-(void)onSendVoiceMessage:(DFVoiceInput *)voiceInput
{
    DFVoiceMessage *voiceMessage = [[DFVoiceMessage alloc] init];
    voiceMessage.path = voiceInput.localPath;
    voiceMessage.url = @"http://coder-file.oss-cn-hangzhou.aliyuncs.com/avatar/20150523003929662742.caf";
    voiceMessage.length = voiceInput.length;
    voiceMessage.ts = [[NSDate date] timeIntervalSince1970]*1000;
    int y = (arc4random() % 2) + 1;
    voiceMessage.bIsMe = y==1?YES:NO;
    [self setUserAvatar:voiceMessage];
    
    [super addMessage:voiceMessage];
}





-(void)onClickImageMessage:(long long)messageId
{
    
}



-(NSMutableArray *)loadHistoryMessages:(long long)messageId
{
    NSMutableArray *array = [NSMutableArray array];
    
    DFTextMessage *textMessage = [[DFTextMessage alloc] init];
    textMessage.messageStatus = MessageStatusSent;
    textMessage.text = @"hello allen";
    textMessage.ts = [[NSDate date] timeIntervalSince1970]*1000 - 1000000;
    int y = (arc4random() % 2) + 1;
    textMessage.bIsMe = y==1?YES:NO;
    [self setUserAvatar:textMessage];
    
    [array addObject:textMessage];
    
    return  array;
    
}



-(void) setUserAvatar:(DFBaseMessage *) message
{
    if (message.bIsMe) {
        message.userAvatar = @"http://coder-file.oss-cn-hangzhou.aliyuncs.com/avatar/1.jpeg";
        
    }else{
        message.userAvatar = @"http://coder-file.oss-cn-hangzhou.aliyuncs.com/avatar/2.jpg";
        
    }

}
@end
