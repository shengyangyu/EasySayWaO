//
//  ESWOMainVC.m
//  EasySayWaO
//
//  Created by ysy on 14-1-26.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import "ESWOMainVC.h"
#import "ESWOCommon.h"
#import "ESWOLoginVC.h"
#import "ESWOMessageVC.h"

@interface ESWOMainVC ()<UIAlertViewDelegate>

// tableview array data
@property (nonatomic,strong) NSMutableArray *usersArray;

@end

@implementation ESWOMainVC
@synthesize usersArray;
@synthesize usersTableView;


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
    [ESWOCommon customizeNavBar:self withTitle:@"login user"buttonNameL:@"account"buttonNameR:nil];
    usersArray = [NSMutableArray array];
    // bind chatdelegate
    ESWOAppDelegate *del = [self appDelegate];
    del.chatDelegate = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:Account_userid];
    if (login) {
        if ([[self appDelegate] connect]) {
            
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有设置账号" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark -UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self leftBtnMethod];
}

#pragma mark -UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [usersArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [usersArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ESWOMessageVC *vc = [[ESWOMessageVC alloc] initWithNibName:@"ESWOMessageVC" bundle:nil];
    vc.currentName = [NSString stringWithFormat:@"%@",[usersArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

//取得当前程序的委托
-(ESWOAppDelegate *)appDelegate{
    
    return (ESWOAppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

//取得当前的XMPPStream
-(XMPPStream *)xmppStream{
    
    return [[self appDelegate] xmppStream];
}

//在线好友
-(void)newBuddyOnline:(NSString *)buddyName{
    
    if (![usersArray containsObject:buddyName]) {
        [usersArray addObject:buddyName];
        [self.usersTableView reloadData];
    }
    
}

//好友下线
-(void)buddyWentOffline:(NSString *)buddyName{
    
    [usersArray removeObject:buddyName];
    [self.usersTableView reloadData];
    
}


#pragma mark -top button method
/**
 *  top navgation button
 */
- (void)leftBtnMethod
{
    ESWOLoginVC *vc = [[ESWOLoginVC alloc] initWithNibName:@"ESWOLoginVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)rightBtnMethod
{
    NSLog(@"rightBtnMethod");
}
#pragma mark -memory manage
- (void)viewDidUnload
{
    self.usersTableView = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
