//
//  StockManageController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockManageController.h"
#import "StockManageSearchController.h"
#import "StockManageCell.h"
#import "StockManageModel.h"
@interface StockManageController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLab;

@property (copy, nonatomic) NSString *searchContent;

@end

@implementation StockManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"库存管理";
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StockManageCell classForKeyedArchiver]) bundle:nil] forCellReuseIdentifier:@"StockManageCell_id"];
        
    [self getDataList:@""];
}

- (void)getDataList:(NSString *)searchContent{
    
    [MBProgressHUD showWaitMessage:@"正在获取列表..." showView:self.view];
    
    NSDictionary *params = @{@"userId":[UserConfig storeID],
                             @"page":@"1",
                             @"pageSize":@"1000",
                             @"size":searchContent
    };
    
    [[YMRequest sharedManager] GET:[NSString stringWithFormat:@"%@%@",YMBaseUrl,kGetAllGoods] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        self.dataArray = [StockManageModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        NSInteger number = 0;
        for (StockManageModel *model in self.dataArray) {
            number += [model.num integerValue];
        }
        self.totalLab.text = [NSString stringWithFormat:@"%ld条",(long)number];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)searchAction{
    JJWeakSelf;
    StockManageSearchController *searchVC = [[StockManageSearchController alloc] init];
    searchVC.searchContent = self.searchContent;
    searchVC.searchBlock = ^(NSString * _Nonnull searchContent) {
        weakSelf.searchContent = searchContent;
        [weakSelf getDataList:searchContent];
    };
    searchVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    searchVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    searchVC.definesPresentationContext = YES; //self is presenting view controller
    [self presentViewController:searchVC animated:NO completion:nil];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StockManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockManageCell_id" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
