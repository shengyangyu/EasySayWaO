//
//  ESWOMainViewController.m
//  EasySayWaO
//
//  Created by ysy on 14-1-24.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import "ESWOLoginVC.h"
#import "ESWOCommon.h"


@interface ESWOLoginVC ()

@end

@implementation ESWOLoginVC

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
    [ESWOCommon customizeNavBar:self withTitle:@"login user" buttonNameL:@"close" buttonNameR:@"login"];
    
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
    [textField resignFirstResponder];
    return YES;
}
/**
 *  top navgation button
 */
- (void)leftBtnMethod
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)rightBtnMethod
{
    NSLog(@"rightBtnMethod");
}

#pragma mark -memory manage

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    self.userNameField = nil;
    self.passworldField = nil;
    self.severSetField = nil;
    
}

@end
