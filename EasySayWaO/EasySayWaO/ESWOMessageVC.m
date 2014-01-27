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
    [ESWOCommon customizeNavBar:self withTitle:@"message view"buttonNameL:@"back"buttonNameR:nil];
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
    
    [messageArray addObject:messageCotent];
    
    [self.messageTableView reloadData];
    
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
