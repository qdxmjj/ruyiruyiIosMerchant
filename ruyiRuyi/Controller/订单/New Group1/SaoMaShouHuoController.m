//
//  SaoMaShouHuoController.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/16.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "SaoMaShouHuoController.h"
#import "JJDecoderViewController.h"
#import "StockViewController.h"
#import "SaoMaCell.h"
#import "YMRequest.h"
@interface SaoMaShouHuoController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SaoMaShouHuoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"条形码扫描";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"手动输入" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBarCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SaoMaCell class]) bundle:nil] forCellReuseIdentifier:@"SaoMaCell_id"];
}

- (void)addBarCode{
    JJWeakSelf;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入条形码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入条形码";
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *nameTextF = alertController.textFields.firstObject;
        
        if (nameTextF.text.length <= 0) {
            [MBProgressHUD showTextMessage:@"请输入条形码!"];
            return ;
        }
        
        if ([weakSelf.dataArray containsObject:nameTextF.text]) {
            [MBProgressHUD showTextMessage:@"重复条形码！" afterDelay:0.5f];
            return ;
        }
        
        if (weakSelf.dataArray.count == self.goodsCount) {
            [MBProgressHUD showTextMessage:@"已超过最大数量！"];
            return;
        }
        
        [weakSelf.dataArray addObject:nameTextF.text];
        [weakSelf.tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)saomaAction{
    JJWeakSelf;
    JJDecoderViewController *deCoderVC = [[JJDecoderViewController alloc] initWithBlock:^(NSString *content, BOOL isScceed) {
        
        if (isScceed) {
            if ([weakSelf.dataArray containsObject:content]) {
                [MBProgressHUD showTextMessage:@"重复条形码！" afterDelay:0.5f];
                return ;
            }
            [weakSelf.dataArray addObject:content];
            [weakSelf.tableView reloadData];
        }else{
        }
    }];
    
    deCoderVC.ScanResult = ^(NSString *result, BOOL isSucceed) {
        if (isSucceed) {
            
            if ([weakSelf.dataArray containsObject:result]) {
                [MBProgressHUD showTextMessage:@"重复条形码！" afterDelay:0.5f];
                return ;
            }
            [weakSelf.dataArray addObject:result];
            [weakSelf.tableView reloadData];
        }else{
        }
    };
    
    deCoderVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:deCoderVC animated:YES completion:nil];
}
- (void)confirmAction {
    
    if (self.dataArray.count <=0) {
        [MBProgressHUD showTextMessage:@"请选择条形码"];
        return;
    }
    
    if (self.dataArray.count < self.goodsCount) {
        [MBProgressHUD showTextMessage:@"请选择正确的数量！"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"firstOrderSelectCodeNotice" object:@{@"selectArray":self.dataArray,@"type":self.type}];

    
    [self.navigationController popViewControllerAnimated:YES];
    
    
//    [MBProgressHUD showWaitMessage:@"正在提交..." showView:self.view];
//
//    NSDictionary *params = @{@"orderNo":self.orderNo,
//                             @"storeId":[UserConfig storeID],
//                             @"storeName":[UserConfig storeName],
//                             @"total_num":[NSString stringWithFormat:@"%ld",self.goodsCount],
//                             @"total_fee":self.total_fee,
//                             @"barCodeList":self.dataArray,
//    };
//    [[YMRequest sharedManager] postRequest:kConfirmBarcode params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
//        [MBProgressHUD hideWaitViewAnimated:self.view];
//        if (code == 1) {
//
//            for (UIViewController *controller in self.navigationController.viewControllers){
//                if ([controller isKindOfClass:[StockViewController class]]) {
//                    StockViewController *A =(StockViewController *)controller;
//                    [self.navigationController popToViewController:A animated:YES];
//                }
//            }
//            [MBProgressHUD showTextMessage:@"确认成功！"];
//        }
//        if (code == 2) {
//
//            NSArray *arr = data;
//            [MBProgressHUD showTextMessage:[NSString stringWithFormat:@"%@\n%@",message,[arr componentsJoinedByString:@","]]];
//        }
//    } failure:^(NSError * _Nullable error) {
//        [MBProgressHUD hideWaitViewAnimated:self.view];
//    }];
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJWeakSelf;
    SaoMaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaoMaCell_id" forIndexPath:indexPath];
    cell.codeLab.text = self.dataArray[indexPath.row];
    
    cell.delBlock = ^{
        
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        
        [weakSelf.tableView reloadData];
    };
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.dataArray.count >= self.goodsCount) {
        [btn setTitle:@"确定" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"添加条形码" forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:JJThemeColor];
    
    if (self.dataArray.count >= self.goodsCount) {
        [btn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btn addTarget:self action:@selector(saomaAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setFrame:CGRectMake(30, 5, SCREEN_WIDTH-60, 35)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 17.5;
    [view addSubview:btn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 45;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
