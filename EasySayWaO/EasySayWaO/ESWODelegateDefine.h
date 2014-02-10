//
//  ESWODelegateDefine.h
//  EasySayWaO
//
//  Created by ysy on 14-1-27.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Message_from          @"from"
#define Message_to            @"to"
#define Message_type          @"type"
#define Message_body          @"body"
#define Account_userid        @"userNameField"
#define Account_userpassword  @"passworldField"
#define Account_server        @"severSetField"


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