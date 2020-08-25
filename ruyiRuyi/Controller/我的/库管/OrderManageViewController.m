//
//  OrderManageViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "OrderManageViewController.h"
#import "StockOrderDetailsViewController.h"
#import "StockOrderListModel.h"
#import "YMRequest.h"
#import "OrderManageCell.h"
@interface OrderManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderManageCell class]) bundle:nil] forCellReuseIdentifier:@"OrderManageCell_id"];
    [self getDataList];
    self.baseTableView = self.tableView;
    [self addRefreshHeader:NO];
}

- (void)getDataList{
    [MBProgressHUD showWaitMessage:@"正在获取订单列表..." showView:self.view];
    
    [[YMRequest sharedManager] getRequest:kGetStockOrderList params:@{@"userId":[UserConfig storeID]} success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        self.dataArray = [StockOrderListModel mj_objectArrayWithKeyValuesArray:data];
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OrderManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderManageCell_id" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JJWeakSelf;
    StockOrderDetailsViewController *vc = [[StockOrderDetailsViewController alloc] init];
    vc.refreshBlock = ^{
        [weakSelf getDataList];
    };
    vc.model = self.dataArray[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

@end
