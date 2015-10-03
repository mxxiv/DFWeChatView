//
//  DFChatViewController.m
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/17.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFChatViewController.h"

#import "DFBaseCellAdapter.h"

#import "DFCellAdapterManager.h"

#import "Key.h"

#import "DFRecorderHUD.h"

#import "LCVoice.h"

#import "DFTipCellAdapter.h"
#import "DFTipMessageCell.h"


#define InputToolbarViewHeight (50 + BtnSize*(_lines - 1)*0.5)
#define PluginsViewHeight 216
#define EmotionsViewHeight 216

#define ToolBarObserveKeyPath @"toolbarViewOffsetY"

#define AnimationDuration 0.2500

#define RecorderHudSize 140

#define TIME_SHOW_INTERVAL 3*60*1000

@interface DFChatViewController ()<LCVoiceDelegate>


@property (assign, nonatomic) NSTimeInterval keyboardAnimationDuration;
@property (assign, nonatomic) NSUInteger keyboardAnimationCurve;


@property (assign, nonatomic) CGFloat toolbarViewOffsetY;

@property (assign, nonatomic) NSInteger lines;


@property (strong, nonatomic) DFInputToolbarView *inputToolbarView;

@property (strong, nonatomic) DFMessageTableView *messageTableView;

@property (strong, nonatomic) DFPluginsView *pluginsView;

@property (strong, nonatomic) DFEmotionsView *emotionssView;


@property (strong, nonatomic) UIView *messageTableViewMask;


@property (strong, nonatomic) UIPanGestureRecognizer *tableViewPanGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tableViewTapGestureRecognizer;


@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSMutableDictionary *messageDic;

@property (assign, nonatomic) long long lastTs;


@property (strong, nonatomic) DFRecorderHUD *recorderHud;

@property (strong, nonatomic) LCVoice *lcVoice;
@end


@implementation DFChatViewController


#pragma mark - Lifecycle


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _messages =[NSMutableArray array];
        _messageDic = [NSMutableDictionary dictionary];
        _lastTs = 0;
        
        _lines = 1;
        _keyboardAnimationDuration = 0.25;
        _keyboardAnimationCurve = 7;
        
        _lcVoice = [[LCVoice alloc] init];
        _lcVoice.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    
    [_messageTableViewMask removeGestureRecognizer:_tableViewPanGestureRecognizer];
    [_messageTableViewMask removeGestureRecognizer:_tableViewTapGestureRecognizer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self loadHistoryMessages];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self addNotify];
    
    [self addObserver];
    
    
    
    [self messageTableViewScrollToBottom];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeNotify];
    
    [self removeObserver];
}


-(void) initView
{
    self.view.backgroundColor = [UIColor colorWithWhite:235/255.0 alpha:1.0];
    
    CGFloat x, y ,width,height;
    
    
    //输入工具栏
    x = 0.0f;
    y = CGRectGetHeight(self.view.frame) - InputToolbarViewHeight ;
    width = CGRectGetWidth(self.view.frame);
    height = InputToolbarViewHeight;
    
    if (_inputToolbarView == nil) {
        _inputToolbarView = [DFInputToolbarView sharedInstance];
        _inputToolbarView.frame = CGRectMake(x, y, width, height);
        //_inputToolbarView = [[DFInputToolbarView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_inputToolbarView];
        _inputToolbarView.delegate = self;
        
        _toolbarViewOffsetY = y;
        
    }
    
    //消息表格
    y = 0;
    height = CGRectGetMinY(_inputToolbarView.frame);
    
    if (_messageTableView == nil) {
        _messageTableView = [[DFMessageTableView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_messageTableView];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.messageDelegate = self;
        _messageTableView.backgroundColor =[UIColor clearColor];
        
        if (_messageTableViewMask == nil) {
            _messageTableViewMask = [[UIView alloc] initWithFrame:_messageTableView.frame];
            [self.view addSubview:_messageTableViewMask];
            //_messageTableViewMask.backgroundColor = [UIColor redColor];
            _messageTableViewMask.hidden = YES;
        }
        
        if (_tableViewPanGestureRecognizer == nil) {
            _tableViewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewPanAndTap:)];
            [_messageTableViewMask addGestureRecognizer:_tableViewPanGestureRecognizer];
            _tableViewPanGestureRecognizer.maximumNumberOfTouches = 1;
            
        }
        
        if (_tableViewTapGestureRecognizer == nil) {
            _tableViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewPanAndTap:)];
            [_messageTableViewMask addGestureRecognizer:_tableViewTapGestureRecognizer];
        }
        
        
    }
    
    
    //插件面板
    
    y = CGRectGetMaxY(_inputToolbarView.frame);
    height = PluginsViewHeight;
    if (_pluginsView == nil) {
        _pluginsView = [DFPluginsView sharedInstance:CGRectMake(0, 0, width, height)];
        _pluginsView.frame = CGRectMake(x, y, width, height);
        //_pluginsView = [[DFPluginsView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_pluginsView];
        _pluginsView.hidden = YES;
    }
    
    
    //表情面板
    
    height = EmotionsViewHeight;
    if (_emotionssView == nil) {
        _emotionssView = [DFEmotionsView sharedInstance:CGRectMake(0, 0, width, height)];
        _emotionssView.frame = CGRectMake(x, y, width, height);
        //_emotionssView.frame = CGRectMake(x, y, width, height);
        //_emotionssView = [[DFEmotionsView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_emotionssView];
        _emotionssView.hidden = YES;
    }
    
    
    //录音HUD
    width = RecorderHudSize;
    height = width;
    x = (CGRectGetWidth(self.view.frame) - width)/2;
    y = (CGRectGetHeight(self.view.frame) - height)/2;
    if (_recorderHud == nil) {
        _recorderHud = [[DFRecorderHUD alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_recorderHud];
        _recorderHud.hidden = YES;
    }
    
    [self.view bringSubviewToFront:_inputToolbarView];
    
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




#pragma mark - Notification

-(void) addNotify

{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboradShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboradHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void) removeNotify

{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

-(void) onKeyboradShow:(NSNotification *) notify
{
    [self onKeyboardChange:notify];
    
}


-(void) onKeyboradHide:(NSNotification *) notify
{
    //[self onKeyboardChange:notify];
    
}


-(void) onKeyboardChange:(NSNotification *) notify
{
    NSDictionary *info = notify.userInfo;
    CGRect frame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardAnimationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    _keyboardAnimationCurve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self changeInputToolbarViewOffsetY:(frame.origin.y - InputToolbarViewHeight) ];
}



#pragma mark - Observer

-(void) addObserver
{
    [self addObserver:self forKeyPath:ToolBarObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}


-(void) removeObserver
{
    [self removeObserver:self forKeyPath:ToolBarObserveKeyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:ToolBarObserveKeyPath]) {
        CGFloat newOffsetY = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
        
        [self changeInputToolbarViewPosition:newOffsetY];
    }
    
}

-(void) changeInputToolbarViewOffsetY:(CGFloat) offsetY
{
    [self setValue: [NSNumber numberWithDouble:offsetY] forKey:ToolBarObserveKeyPath];
    
}

-(void) changeInputToolbarViewPosition:(CGFloat) newOffsetY
{
    CGFloat x,y,width,height;
    CGRect frame = _inputToolbarView.frame;
    x = frame.origin.x;
    y = newOffsetY;
    width = frame.size.width;
    height = frame.size.height;
    
    _messageTableViewMask.hidden = !(newOffsetY < (self.view.frame.size.height - InputToolbarViewHeight));
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_keyboardAnimationDuration];
    [UIView setAnimationCurve:_keyboardAnimationCurve];
    
    _inputToolbarView.frame = CGRectMake(x, y, width, height);
    
    //其它几个跟着动
    [self changeMessageTableViewPosition:newOffsetY];
    [self changeEmotionsViewPosition:newOffsetY];
    [self changePluginsViewPosition:newOffsetY];
    
    [UIView commitAnimations];
}

-(void) changeMessageTableViewPosition:(CGFloat) newOffsetY {
    CGFloat x,y,width,height;
    CGRect frame = _messageTableView.frame;
    x = frame.origin.x;
    y = newOffsetY - frame.size.height;
    width = frame.size.width;
    height = frame.size.height;
    _messageTableView.frame = CGRectMake(x, y, width, height);
    
    [self messageTableViewScrollToBottom];
}


-(void) changeEmotionsViewPosition:(CGFloat) newOffsetY {
    CGFloat x,y,width,height;
    CGRect frame = _messageTableView.frame;
    x = frame.origin.x;
    y = newOffsetY + InputToolbarViewHeight;
    width = frame.size.width;
    height = frame.size.height;
    _emotionssView.frame = CGRectMake(x, y, width, height);
}

-(void) changePluginsViewPosition:(CGFloat) newOffsetY {
    CGFloat x,y,width,height;
    CGRect frame = _messageTableView.frame;
    x = frame.origin.x;
    y = newOffsetY + InputToolbarViewHeight;
    width = frame.size.width;
    height = frame.size.height;
    _pluginsView.frame = CGRectMake(x, y, width, height);
}



#pragma mark - DFInputToolbarViewDelegate


-(void)onClickTextAndVoiceBtn
{
    if ([_inputToolbarView getInputToolbarState] != InputToolbarStateText) {
        [self toolbarViewAnimateToBottom];
    }
}


-(void)onClickEmotionsBtn
{
    [self toolbarViewAnimateToMiddle];
    
    _emotionssView.hidden = NO;
    _pluginsView.hidden = YES;
    
}


-(void)onClickPluginsBtn
{
    
    [self toolbarViewAnimateToMiddle];
    
    
    _emotionssView.hidden = YES;
    _pluginsView.hidden = NO;
}




-(void)onMessageSend:(NSString *)message
{
    NSDictionary *dic = @{@"text":message};
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_TEXT_MESSAGE object:nil userInfo:dic];
    
    _lines = 1;
    [self layoutToolbarView];
}

-(void)onTextViewLinesChange:(NSInteger)lines
{
    NSLog(@"lines: %ld", (long)lines);
    
    if (lines > 5) {
        return;
    }
    
    _lines = lines;
    
    [self layoutToolbarView];
}





-(void)onVoiceRecordStart
{
    NSLog(@"start recording");
    
    _recorderHud.hidden = NO;
    [_recorderHud setHudState:RecorderHudStateNormal];
    [_recorderHud setSignalLevel:5];
    
    [self startRecording];
}


-(void) onVoiceRecordFinished
{
    NSLog(@"finish recording");
    _recorderHud.hidden = YES;
    [self stopRecording];

}


-(void)onVoiceRecordCancelled
{
    NSLog(@"cancel recording");
    _recorderHud.hidden = YES;
    
    [_lcVoice stopRecordWithCompletionBlock:^{
        
    }];
    
}

-(void)onVoiceRecordTouchLeave
{
    NSLog(@"leave btn ");
    [_recorderHud setHudState:RecorderHudStateCancel];
}


-(void)onVoiceRecordTouchReturn
{
    NSLog(@"return normal");
    [_recorderHud setHudState:RecorderHudStateNormal];
}





-(void) startRecording
{
    NSString *cafPath = [NSString stringWithFormat:@"%@record_sound.caf", NSTemporaryDirectory()];

    [_lcVoice startRecordWithPath:cafPath];
}


-(void) stopRecording
{
    
    [_lcVoice stopRecordWithCompletionBlock:^{
        if (_lcVoice.recordTime >= 1) {
            NSLog(@"path: %@", _lcVoice.recordPath);

            NSDictionary *dic = @{@"voice":_lcVoice.recordPath,@"length":[NSNumber numberWithFloat:_lcVoice.recordTime]};
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_VOICE_MESSAGE object:nil userInfo:dic];
        }else{
            //提示录音时间太短
        }
    }];
}
#pragma mark - Method MessageTableView

-(void) messageTableViewScrollToBottom
{
    if (_messageTableView.contentSize.height -_messageTableView.bounds.size.height>0) {
        [_messageTableView setContentOffset:CGPointMake(0, _messageTableView.contentSize.height -_messageTableView.bounds.size.height + 50) animated:NO];
    }
    
    //    if (_messages.count > 0) {
    //        [_messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messages.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //    }
    
}

-(void) onTableViewPanAndTap:(UIGestureRecognizer *) gesture
{
    [_inputToolbarView hideKeyboard];
    [self toolbarViewAnimateToBottom];
    
    if ([_inputToolbarView getInputToolbarState] != InputToolbarStateText) {
        [_inputToolbarView setInputToolbarState:InputToolbarStateNone];
    }
}


#pragma mark - Method InputToolbarView

-(void) toolbarViewAnimateToBottom
{
    CGFloat offsetY = CGRectGetHeight(self.view.frame) - InputToolbarViewHeight ;
    [self changeInputToolbarViewPosition:offsetY];
}


-(void) toolbarViewAnimateToMiddle
{
    if ([_inputToolbarView getInputToolbarState] == InputToolbarStateText) {
        return;
    }
    
    CGFloat offsetY = CGRectGetHeight(self.view.frame) - InputToolbarViewHeight - PluginsViewHeight ;
    [self changeInputToolbarViewPosition:offsetY];
}

-(void) layoutToolbarView
{
    CGFloat maxY = CGRectGetMinY(_pluginsView.frame);
    CGFloat x,y,width,height;
    CGRect frame = _inputToolbarView.frame;
    x = frame.origin.x;
    height = InputToolbarViewHeight;
    y = maxY  - height;
    width = frame.size.width;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_keyboardAnimationDuration];
    [UIView setAnimationCurve:_keyboardAnimationCurve];
    
    _inputToolbarView.frame = CGRectMake(x, y, width, height);
    
    [UIView commitAnimations];
    
    [self toolbarViewAnimateToMiddle];
    
}


#pragma mark - Method EmotionsAndPluginsView



#pragma mark - UITableViewDataSource & Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messages count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DFBaseMessage *message = [_messages objectAtIndex:[indexPath row]];
    DFBaseCellAdapter *adapter = [self getAdapter:message.messageType];
    UITableViewCell *cell = [adapter getCell:tableView];
    [adapter updateCell:cell message:message];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DFBaseMessage *message = [_messages objectAtIndex:[indexPath row]];
    DFBaseCellAdapter *adapter = [self getAdapter:message.messageType];
    return [adapter getCellHeight:message];
}


#pragma mark - DFMessageTableViewDelegate

-(void)onPullDown
{
    [self loadHistoryMessages];
    [_messageTableView onLoadFinish];
}

#pragma mark - Method


-(void)reloadData
{
    [_messageTableView reloadData];
}


-(BOOL)showUserNick
{
    return NO;
}

-(void) addMessage:(DFBaseMessage *) message
{
    
    [self addMessage:message updateStatus:YES];
}


-(void)addMessage:(DFBaseMessage *)message updateStatus:(BOOL)updateStatus
{
    message.bShowTime = (message.ts - _lastTs >= TIME_SHOW_INTERVAL)?YES:NO;
    message.bShowUserNick = [self showUserNick];
    
    [_messages addObject:message];
    
    message.rowIndex = _messages.count - 1;
    
    _lastTs = message.ts;
    
    [_messageDic setObject:message forKey:[NSNumber numberWithLongLong:message.messageId]];
    
    if (updateStatus) {
        [self changeMessageStatus:message.messageStatus messageId:message.messageId];
    }else{
        [_messageTableView reloadData];
    }
    
    [self messageTableViewScrollToBottom];
}


-(void) insertMessagesHead:(NSMutableArray *) messages
{
    //NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:0];
    //[_messages insertObjects:messages atIndexes:set];
    
    for (DFBaseMessage *message in messages) {
        message.bShowUserNick = [self showUserNick];
        [_messages insertObject:message atIndex:0];
    }
    
    _lastTs = 0;
    
    NSUInteger rowIndex = 0;
    for (DFBaseMessage *message in _messages) {
        message.bShowTime = (message.ts - _lastTs >= TIME_SHOW_INTERVAL)?YES:NO;
        _lastTs = message.ts;
        [_messageDic setObject:message forKey:[NSNumber numberWithLongLong:message.messageId]];
        
        message.rowIndex = rowIndex;
        rowIndex++;
        
    }
    
    [_messageTableView reloadData];
}


-(DFBaseMessage *)getMessage:(long long)messageId
{
    return [_messageDic objectForKey:[NSNumber numberWithLongLong:messageId]];
}

-(DFBaseMessage *)getMessageByRowIndex:(NSUInteger)rowIndex
{
    return [_messages objectAtIndex:rowIndex];
}


-(void)changeMessageStatus:(MessageStatus)status messageId:(long long)messageId
{
    DFBaseMessage *message = [self getMessage:messageId];
    if (message != nil) {
        message.messageStatus = status;
    }
    [_messageTableView reloadData];
}


-(DFBaseCellAdapter *) getAdapter:(MessageType) messageType
{
    DFCellAdapterManager *manager = [DFCellAdapterManager sharedInstance];
    return [manager getAdapter:messageType];
}

-(NSMutableArray *)loadHistoryMessages:(long long)messageId{
    return nil;
}

-(void) loadHistoryMessages
{
    long long messageId = 9223372036854775807;
    if (_messages != nil && _messages.count > 0) {
        messageId = ((DFBaseMessage *)[_messages objectAtIndex:0]).messageId;
    }
    NSMutableArray *array = [self loadHistoryMessages:messageId];
    if (array != nil && array.count > 0) {
        [self insertMessagesHead:array];
    }
}

#pragma mark - LcVoiceDelegate

-(void)updateVoiceLevel:(NSUInteger) level
{
    //NSLog(@"level: %lu",(unsigned long)level);
    _recorderHud.signalLevel = level;
}
@end
