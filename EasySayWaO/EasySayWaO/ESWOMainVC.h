//
//  ESWOMainVC.h
//  EasySayWaO
//
//  Created by ysy on 14-1-26.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESWOAppDelegate.h"

@interface ESWOMainVC : UIViewController<UITableViewDataSource,UITableViewDelegate,ESWOKKChatDlegate>

@property (strong, nonatomic) IBOutlet UITableView *usersTableView;

@end
