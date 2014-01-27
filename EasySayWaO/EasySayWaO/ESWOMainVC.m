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

@interface ESWOMainVC ()

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
    [ESWOCommon customizeNavBar:self withTitle:@"login user" buttonNameL:@"account" buttonNameR:@"no"];
    usersArray = [NSMutableArray array];
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
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

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
