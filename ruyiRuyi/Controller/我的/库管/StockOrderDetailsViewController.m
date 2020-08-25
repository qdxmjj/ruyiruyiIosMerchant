//
//  StockOrderDetailsViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockOrderDetailsViewController.h"
#import "SaoMaShouHuoController.h"
#import "StockOrderDetailsCell.h"
#import "YMRequest.h"
@interface StockOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLab;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLab;

@end

@implementation StockOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    //    [self.confirmBtn bringSubviewToFront:self.view];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StockOrderDetailsCell class]) bundle:nil] forCellReuseIdentifier:@"StockOrderDetailsCell_id"];
    
    [self getStockGoodsList];
}

- (void)setHeaderData{
    
    
    self.nameLab.text = [NSString stringWithFormat:@"店铺名称：%@",self.model.userName];
    self.timeLab.text = [NSString stringWithFormat:@"订单编号：%@",self.model.orderNo];
    self.orderNoLab.text = [NSString stringWithFormat:@"下单时间：%@",self.model.createTime];
    self.totalPriceLab.text = [NSString stringWithFormat:@"订单金额：%@",self.model.totalFee];
    
    NSInteger status = [self.model.status integerValue];
    NSString *statusString = @"";
    switch (status) {
        case -1:
            statusString = @"审核未通过";
            break;
        case 0:
            statusString = @"待审核";
            break;
        case 1:
            statusString = @"审核完成,未发货";
            break;
        case 2:
            statusString = @"已发货,未确认";
            self.confirmBtn.hidden = NO;
            break;
        case 3:
            statusString = @"确认收货，交易成功";
            break;
        case 4:
            break;
        case 5:
            //              statusString = @"交易取消";
            break;
        case 6:
            //              statusString = @"交易结束";
            break;
        default:
            break;
    }
    self.orderStatusLab.text = [NSString stringWithFormat:@"订单状态：%@",statusString];
}
- (IBAction)confirmAction:(id)sender {
    
    
    
    NSInteger status = [self.model.status integerValue];
    
    if (status == 2) {
        
        //        self.dataArray[indexPath.row][@"num"]
        
        //        NSInteger count = 0;
        //
        //        for (NSDictionary *dic in self.dataArray) {
        //
        //            count += [dic[@"num"] integerValue];
        //        }
        //
        //
        //
        //        SaoMaShouHuoController *vc = [[SaoMaShouHuoController alloc] init];
        //
        //        vc.goodsCount = count;
        //        vc.orderNo = self.model.orderNo;
        //        vc.total_fee = [NSString stringWithFormat:@"%@",self.model.totalFee];;
        //
        //        [self.navigationController pushViewController:vc animated:YES];
        
        [[YMRequest sharedManager] getRequest:kConfirmOrder params:@{@"storeId":[UserConfig storeID],@"orderNo":self.model.orderNo} success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
            
            if (code == 1) {
                
                if (self.refreshBlock) {
                    self.refreshBlock();
                }
                
                [self.navigationController popViewControllerAnimated:YES];
                [MBProgressHUD showTextMessage:@"确认成功！"];
            }
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

///商品列表
- (void)getStockGoodsList{
    [MBProgressHUD showWaitMessage:@"正在获取..." showView:self.view];
    NSDictionary *params = @{@"orderId":self.model.orderId};
    [[YMRequest sharedManager] getRequest:@"/orderServe/orderType" params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        [self.dataArray addObjectsFromArray:data];
        [self setHeaderData];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StockOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockOrderDetailsCell_id" forIndexPath:indexPath];
    cell.chicunLab.text = [NSString stringWithFormat:@"轮胎尺寸：%@",self.dataArray[indexPath.row][@"extra_size"]];
    cell.guigeLab.text = [NSString stringWithFormat:@"轮胎规格：%@",self.dataArray[indexPath.row][@"type"]];
    cell.danjiaLab.text = [NSString stringWithFormat:@"轮胎单价：%@",self.dataArray[indexPath.row][@"price"]];
    cell.huawenLab.text = [NSString stringWithFormat:@"轮胎花纹：%@",self.dataArray[indexPath.row][@"flgure_name"]];
    cell.shuliangLab.text = [NSString stringWithFormat:@"进货数量：%@",self.dataArray[indexPath.row][@"num"]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
