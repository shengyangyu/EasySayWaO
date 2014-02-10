//
//  ESWOMessageVC.h
//  EasySayWaO
//
//  Created by ysy on 14-1-27.
//  Copyright (c) 2014年 com.deirlym.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESWOMessageVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *messageTextfield;
@property (strong, nonatomic) IBOutlet UITableView *messageTableView;
@property (strong, nonatomic) NSString *currentName;

@end
