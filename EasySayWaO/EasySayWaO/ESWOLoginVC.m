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
    if (self.userNameField.text.length == 0 || self.passworldField.text.length == 0 || self.severSetField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名，密码和服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else{
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userNameField.text forKey:@"userNameField"];
        [defaults setObject:self.passworldField.text forKey:@"passworldField"];
        [defaults setObject:self.severSetField.text forKey:@"severSetField"];
        //保存
        [defaults synchronize];
        
        [self leftBtnMethod];
    }
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
