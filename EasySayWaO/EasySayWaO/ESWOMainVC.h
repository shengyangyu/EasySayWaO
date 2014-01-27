//
//  ESWOMainVC.h
//  EasySayWaO
//
//  Created by ysy on 14-1-26.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESWOMainVC : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *usersTableView;

@end
