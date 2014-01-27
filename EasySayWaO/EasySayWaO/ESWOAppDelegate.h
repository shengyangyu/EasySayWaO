//
//  ESWOAppDelegate.h
//  EasySayWaO
//
//  Created by ysy on 14-1-24.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@interface ESWOAppDelegate : UIResponder <UIApplicationDelegate,XMPPStreamDelegate>
{
    XMPPStream *xmppStream;
    NSString *password; // password
    BOOL isOpen; //XMPPStream open or not

}

@property (strong, nonatomic) UIWindow *window;

// delegate
@property(nonatomic, retain)id chatDelegate;
@property(nonatomic, retain)id messageDelegate;

// xmpp
@property (readonly, nonatomic) XMPPStream *xmppStream;

// connect or not
- (BOOL)connect;

// not connect
- (void)disConnect;

// xmppstream set
- (void)setUpXmppStream;

// on
- (void)goOnline;

// off
- (void)goOffline;



@end
