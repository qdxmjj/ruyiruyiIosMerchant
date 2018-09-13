//
//  DeliveryOrderViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "DeliveryOrderViewController.h"
#import "NewOrderDetailsViewController.h"
#import "NewConfirmServiceCell.h"
@interface DeliveryOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation DeliveryOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发货订单";
    
    [self.view addSubview:self.tableView];
    
    [JJRequest GL_PostRequest:@"orderInfo/selectWaitingPostOrdersList" params:@{@"storeId":@([[UserConfig storeID] integerValue])} success:^(NSString * _Nullable rows, id  _Nullable total) {
        
        NSLog(@"发货订单列表：%@",rows);
        
        self.dataArr = (NSArray *)rows;
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewConfirmServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewConfirmServiceCellID"];
    
    [cell.deliveryBtn addTarget:self action:@selector(clickDeliveryEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deliveryBtn2 addTarget:self action:@selector(clickDeliveryEvent:) forControlEvents:UIControlEventTouchUpInside];

    DeliveryOrderModel *model = [[DeliveryOrderModel alloc] init];
    [model setValuesForKeysWithDictionary:_dataArr[indexPath.section]];
    cell.model = model;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DeliveryOrderModel *model = [[DeliveryOrderModel alloc] init];
    [model setValuesForKeysWithDictionary:_dataArr[indexPath.section]];
    
    if (model.isConsistent || [model.frontTyre isEqualToString:@"0"] || [model.rearTyre isEqualToString:@"0"]) {
        
        return 285-98;
    }else{
        
        return 285;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(void)clickDeliveryEvent:(UIButton *)sender{
    
    NewConfirmServiceCell *cell = (NewConfirmServiceCell *) sender.superview.superview.superview;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NewOrderDetailsViewController *newOrderDetailsVC = [[NewOrderDetailsViewController alloc] init];
    
    NSLog(@"%@",_dataArr[indexPath.section]);

    DeliveryOrderModel *model = [[DeliveryOrderModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.section]];
    
    newOrderDetailsVC.deliveryOrderDetils = model;
    
    [self.navigationController pushViewController:newOrderDetailsVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewConfirmServiceCell class]) bundle:nil] forCellReuseIdentifier:@"NewConfirmServiceCellID"];
    }
    return _tableView;
}
-(NSArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
