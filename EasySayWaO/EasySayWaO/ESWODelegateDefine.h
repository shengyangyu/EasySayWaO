//
//  ESWODelegateDefine.h
//  EasySayWaO
//
//  Created by ysy on 14-1-27.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ESWOKKChatDlegate <NSObject>
@optional

- (void)newBuddyOnline:(NSString *)buddyName;
- (void)buddyWentOffline:(NSString *)buddyName;
- (void)didDisConnet;

@end


@protocol ESWOKKMessageDlegate <NSObject>

@optional

- (void)newMessageReceived:(NSDictionary *)messageContent;


@end