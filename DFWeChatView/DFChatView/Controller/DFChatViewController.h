//
//  DFChatViewController.h
//  DFWeChatView
//
//  Created by Allen Zhong on 15/4/17.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


//main components
#import "DFInputToolbarView.h"
#import "DFMessageTableView.h"
#import "DFPluginsView.h"
#import "DFEmotionsView.h"

#import "DFBaseMessage.h"



@interface DFChatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, DFInputToolbarViewDelegate, DFMessageTableViewDelegate>

-(void) addMessage:(DFBaseMessage *) message;
-(void) addMessage:(DFBaseMessage *) message updateStatus:(BOOL) updateStatus;

-(NSMutableArray *) loadHistoryMessages:(long long)messageId;


-(DFBaseMessage *) getMessage:(long long)messageId;

-(DFBaseMessage *) getMessageByRowIndex:(NSUInteger) rowIndex;

-(void) changeMessageStatus:(MessageStatus) status messageId:(long long) messageId;


-(void) reloadData;


-(BOOL) showUserNick;


@end
