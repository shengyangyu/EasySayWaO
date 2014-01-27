//
//  ESWOAppDelegate.m
//  EasySayWaO
//
//  Created by ysy on 14-1-24.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import "ESWOAppDelegate.h"
#import "ESWOMainVC.h"


@implementation ESWOAppDelegate
@synthesize xmppStream;
@synthesize chatDelegate;
@synthesize messageDelegate;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    ESWOMainVC *vc = [[ESWOMainVC alloc]initWithNibName:@"ESWOMainVC" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];

    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self disConnect];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self connect];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -customer method
/**
 *  customer method
 */

// connect or not
- (BOOL)connect
{
    [self setUpXmppStream];
   
    //get username password server
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults stringForKey:@"userNameField"];
    NSString *temppassword = [defaults stringForKey:@"passworldField"];
    NSString *server = [defaults stringForKey:@"severSetField"];
    
    // if connected so don't need connect
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    // userid  and password be able else return no
    if (userId == nil || temppassword == nil) {
        return NO;
    }
    
    // set user jid
    [xmppStream setMyJID:[XMPPJID jidWithString:userId]];
    // set server
    [xmppStream setHostName:server];
    // password
    password = temppassword;
    
    // connect server
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        NSLog(@"cant connect %@", server);
        return NO;
    }
    
    return YES;
}

// not connect
- (void)disConnect
{
    [self goOffline];
    [xmppStream disconnect];
}

// xmppstream set
- (void)setUpXmppStream
{
    if (self.xmppStream == nil) {
        xmppStream = [[XMPPStream alloc] init];
        [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
}

// on
- (void)goOnline
{
    // send online status
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
    
}

// off
- (void)goOffline
{
    // send offline status
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}

#pragma mark -XMPPStreamDelegate method

// connect server
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    isOpen = YES;
    NSError *error = nil;
    // authen password
    [[self xmppStream] authenticateWithPassword:password error:&error];
}

// authen successed
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    [self goOnline];
}

// receive notify
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    // parse message
    NSString *mesg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    
    // data check
    if (mesg == nil || from == nil) {
        return;
    }
    
    // package
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:mesg forKey:@"msg"];
    [dict setObject:from forKey:@"sender"];
    
    // message delegate
    [messageDelegate newMessageReceived:dict];
}
// receive user online
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    // user status
    NSString *presenceType = [presence type];
    // current user me
    NSString *userId = [[sender myJID] user];
    // online user
    NSString *presenceFromUser = [[presence from] user];
    // domain user
    NSString *domainString = [[presence from] domain];
    // filter other users delete self
    if (![presenceFromUser isEqualToString:userId])
    {
        // online
        if ([presenceType isEqualToString:@"available"]) {
            
            //delegate
            [chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, domainString]];
        }
        // offline
        else if ([presenceType isEqualToString:@"unavailable"])
        {
            //delegate
            [chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, domainString]];
        }
    }
}

@end
