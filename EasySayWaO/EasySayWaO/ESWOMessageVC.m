//
//  ESWOMessageVC.m
//  EasySayWaO
//
//  Created by ysy on 14-1-27.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import "ESWOMessageVC.h"
#import "ESWOAppDelegate.h"
#import "ESWOCommon.h"

@interface ESWOMessageVC ()<ESWOKKMessageDlegate>

// tableview array data
@property (nonatomic,strong) NSMutableArray *messageArray;

@end

@implementation ESWOMessageVC
@synthesize messageArray;
@synthesize currentName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ESWOCommon customizeNavBar:self withTitle:currentName buttonNameL:@"back"buttonNameR:nil];
    messageArray = [NSMutableArray array];
    // delegate
    ESWOAppDelegate *del= [self appDelegate];
    del.messageDelegate = self;
    
}
// get xmpp 
-(ESWOAppDelegate *)appDelegate{
    
    return (ESWOAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(XMPPStream *)xmppStream{
    
    return [[self appDelegate] xmppStream];
}

/**
 *  textdelegate
 *
 *  @param textField view's textfield
 *
 *  @return successed
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length != 0) {
        
        
        
    }else{
    
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark -send message
/**
 *  send message to other user
 *
 *  @param sender button
 */
- (IBAction)sendMethod:(UIButton *)sender
{
    //textfield context
    NSString *message = self.messageTextfield.text;
    
    if (message.length > 0) {
        
        //XMPPFramework主要是通过KissXML来生成XML文件
        //生成<body>文档
        NSXMLElement *body = [NSXMLElement elementWithName:Message_body];
        [body setStringValue:message];
        
        //生成XML消息文档
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        //消息类型
        [mes addAttributeWithName:Message_type stringValue:@"chat"];
        //发送给谁
        [mes addAttributeWithName:Message_to stringValue:currentName];
        //由谁发送
        [mes addAttributeWithName:Message_from stringValue:[[NSUserDefaults standardUserDefaults] stringForKey:Account_userid]];
        //组合
        [mes addChild:body];
        
        //send message
        [[self xmppStream] sendElement:mes];
        
        // responder textfield
        self.messageTextfield.text = @"";
        [self.messageTextfield resignFirstResponder];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setObject:message forKey:Message_body];
        [dictionary setObject:@"you" forKey:@"sender"];
        
        //加入发送时间
        //[dictionary setObject:[Statics getCurrentTime] forKey:@"time"];
        
        [messageArray addObject:dictionary];
        //reload tableView
        [self.messageTableView reloadData];
    }
}

#pragma mark -top button method
/**
 *  top navgation button
 */
- (void)leftBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnMethod
{
    NSLog(@"rightBtnMethod");
}

#pragma mark KKMessageDelegate
-(void)newMessageReceived:(NSDictionary *)messageCotent{
    
    // is current user communication
    NSString *temp = [messageCotent objectForKey:Message_from];
    NSRange foundObj=[temp rangeOfString:currentName options:NSCaseInsensitiveSearch];
    if(foundObj.length>0) {
        
        [messageArray addObject:messageCotent];
        [self.messageTableView reloadData];
        
    } else {
        
    }
}

#pragma mark -UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messageArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[messageArray objectAtIndex:indexPath.row] objectForKey:Message_body];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
