//
//  ESWOCommon.m
//  EasySayWaO
//
//  Created by ysy on 14-1-26.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import "ESWOCommon.h"

@implementation ESWOCommon

#pragma mark - 设置导航条, 左边为凌形按钮，右边为长方形按钮
+ (void)customizeNavBar:(UIViewController*)targetView withTitle:(NSString *)title buttonNameL:(NSString*)btnNameL buttonNameR:(NSString*)btnNameR
{
    // 有左边的按钮
    if (btnNameL)
    {
        // 设置左边按钮
        UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 60 ,30);
        [leftButton setBackgroundColor:[UIColor clearColor]];
        [leftButton setTitle:btnNameL forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [leftButton addTarget:targetView action:@selector(leftBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        targetView.navigationItem.leftBarButtonItem = leftBarItem;
    }
    // 有右边的按钮
    if (btnNameR)
    {
        // 设置右边按钮
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 60 ,30);
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        [rightBtn setTitle:btnNameR forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [rightBtn addTarget:targetView action:@selector(rightBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        targetView.navigationItem.rightBarButtonItem=rightBarButtonItem;
    }

    targetView.title = title;
}
- (void)leftBtnMethod
{
    
}
- (void)rightBtnMethod
{
    
}

@end
