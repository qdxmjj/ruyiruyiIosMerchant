//
//  IncomeListTableViewController.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"
#import "IncomeModel.h"
@interface IncomeListTableViewController : BaseTableViewController

@property(nonatomic,copy)NSString *selectData;

-(instancetype)initWithStyle:(UITableViewStyle)style withIncometype:(incomeType )IncomeType;

@end
