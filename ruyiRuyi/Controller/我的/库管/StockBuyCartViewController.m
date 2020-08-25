//
//  StockBuyCartViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/26.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockBuyCartViewController.h"

#import "StockViewController.h"
#import "StockOrderGoodsCell.h"
#import "YMRequest.h"
@interface StockBuyCartViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *keyongLab;
@property (weak, nonatomic) IBOutlet UILabel *hejiLab;
@property (weak, nonatomic) IBOutlet UILabel *hejiMoneyLab;

@property (copy, nonatomic) NSString *haveMoney;

@end

@implementation StockBuyCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要订货";
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StockOrderGoodsCell class]) bundle:nil] forCellReuseIdentifier:@"StockBuyCartViewCell_id"];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [cleanBtn setTitle:@"清除" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cleanBtn addTarget:self action:@selector(cleanBuyCartData) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cleanBtn];
    
    [self setMoney];
    
    [self getDataList];
}

- (void)setMoney{
    NSInteger heji = 0;
    
    CGFloat money = 0.00;
    for (StockOrderGoodsModel *model in self.goodsDataArray) {
        
        money += [model.totalPrice floatValue];
        heji += [model.stockNumber integerValue];
    }
    self.hejiLab.text = [NSString stringWithFormat:@"%ld条",heji];

    self.hejiMoneyLab.text = [NSString stringWithFormat:@"%.2f",money];
}

- (void)getDataList{
    
    [[YMRequest sharedManager] GET:[NSString stringWithFormat:@"%@%@",YMBaseUrl,kGetBond] parameters:@{@"user_id":[UserConfig storeID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
        if (responseObject[@"data"] && responseObject[@"data"] != [NSNull null] && responseObject[@"data"] != NULL) {
            NSArray *keys = [responseObject[@"data"] allKeys];
            
            if ([keys containsObject:@"have_money"]) {
                self.haveMoney = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"have_money"]];
            }else{
                self.haveMoney = @"0.00";
            }
        }else{
            self.haveMoney = @"0.00";
        }
        self.keyongLab.text = [NSString stringWithFormat:@"您当前订单可用金额为%.2f元",[self.haveMoney floatValue]];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
       }];
}

- (void)cleanBuyCartData{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否要清空购物车" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableArray *arr = [NSMutableArray array];
        [UserConfig userDefaultsSetObject:arr key:@"kStockGoods"];
        self.goodsDataArray = @[].mutableCopy;
        [self.tableView reloadData];
        
        self.cleanBlock();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:yesAction];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)buyAction:(id)sender {
    
    ///数据可能会改变
    CGFloat money = 0.00;
    for (StockOrderGoodsModel *model in self.goodsDataArray) {
           
           money += [model.totalPrice floatValue];
    }
       
    CGFloat haveMoney = [self.haveMoney floatValue];
        
    if (haveMoney > 0 && money > haveMoney) {
        [MBProgressHUD showTextMessage:@"如驿如意商家版：您的可用金额不足,请追加保证金！"];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在提交..." showView:self.view];
    
    NSMutableArray *goodsArray = [NSMutableArray array];
    
    NSInteger number = 0;
    
    for (StockOrderGoodsModel *model in self.goodsDataArray) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:model.size forKey:@"extra_size"];
        [dic setObject:model.type forKey:@"type"];
        [dic setObject:model.flgureName forKey:@"flgure_name"];
        [dic setObject:model.totalMoney forKey:@"price"];
        [dic setObject:model.stockNumber forKey:@"num"];
        [dic setObject:model.shoeId forKey:@"shoeId"];

        number += [model.stockNumber integerValue];
        [goodsArray addObject:dic];
    }
    
//    NSString *carts = [JJTools convertToJsonData:goodsArray];

    NSDictionary *params = @{@"userId":[UserConfig storeID],
                             @"userName":[UserConfig storeName],
                             @"total_num":[NSString stringWithFormat:@"%ld",number],
                             @"total_fee":[NSString stringWithFormat:@"%.2f",money],
                             @"carts":goodsArray,
    };
    
    [[YMRequest sharedManager] postRequest:kCreateOrder params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        if (code == 1) {
            [self.goodsDataArray removeAllObjects];
            NSArray *array = [NSArray array];
            [UserConfig userDefaultsSetObject:array key:@"kStockGoods"];
            
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
               if ([controller isKindOfClass:[StockViewController class]]) {
                  StockViewController *A =(StockViewController *)controller;
                  [self.navigationController popToViewController:A animated:YES];
                }
            }
            [MBProgressHUD showTextMessage:@"提交订单成功！"];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JJWeakSelf;
    StockOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockBuyCartViewCell_id" forIndexPath:indexPath];
    
    [cell.caozuoBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    cell.deleteBlock = ^(StockOrderGoodsModel * _Nonnull model) {
        ///删除
        __block bool isBe = NO;
        
        [MBProgressHUD showWaitMessage:@"正在删除..." showView:self.view];
        
        [weakSelf.goodsDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            StockOrderGoodsModel *objModel = obj;
            
            if (objModel.shoeId == model.shoeId) {
                
                isBe = YES;
                //替换数据并停止遍历
                NSLog(@"遍历内存地址：%p",obj);
                [weakSelf.goodsDataArray removeObjectAtIndex:idx];
                [weakSelf.tableView reloadData];
                [self setMoney];
                
                NSMutableArray *selectDataArray = [NSMutableArray array];
                for (StockOrderGoodsModel *model in self.goodsDataArray) {
                    //归档
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                    [selectDataArray addObject:data];
                }
                NSArray *array = [NSArray arrayWithArray:selectDataArray];
                [UserConfig userDefaultsSetObject:array key:@"kStockGoods"];
                
                [MBProgressHUD showTextMessage:@"删除成功！"];
                *stop = YES;
            }
        }];
        [MBProgressHUD hideWaitViewAnimated:self.view];
        if (!isBe) {
            [MBProgressHUD showTextMessage:@"删除失败，商品不存在！"];
        }
    };
    
    cell.editBlock = ^(NSString * _Nonnull number) {
        [self setMoney];
    };
    
    cell.model = self.goodsDataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
//
//- (NSMutableArray *)dataArray{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
@end
