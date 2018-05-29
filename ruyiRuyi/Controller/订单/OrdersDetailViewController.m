//
//  OrdersDetailViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrdersDetailViewController.h"
#import "MainOrdersRequest.h"
#import "CodeNumheadView.h"

#import "SelectServiceCell.h"
#import "OrdersInfoCell.h"
#import "CodeNumberCell.h"
#import "TiresCell.h"
#import "OrdersPhotoCell.h"

#import "OrdersViewController.h"
@interface OrdersDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *submitBtn;

@property(nonatomic,strong)NSArray *ordersTitleArr;//第0行cell，显示内容

@property(nonatomic,strong)NSMutableArray *ordersContentArr;//第0行cell，显示内容

@property(nonatomic,strong)NSMutableArray *tiresNumArr;//轮胎信息

@property(nonatomic,strong)NSMutableArray *codeNumArr;//条形码

@property(nonatomic,copy)NSString *orderTypeStr;//订单类型

@property(nonatomic,assign)orderState orderState;//当前界面默认显示样式

@property(nonatomic,strong)NSArray * storeServiceTypes;

@property(nonatomic,assign)BOOL CodeNumberCellDisplay;//条形码是否显示

@property(nonatomic,assign)BOOL selectServiceCellDisplay;//商家确认服务类型是否显示

@property(nonatomic,assign,getter=isButtonEnabled)BOOL buttonEnabled;

@property(nonatomic,assign)BOOL switchHidden;

@property(nonatomic,copy)NSString *buttonTitle;

@property(nonatomic,assign)NSInteger tableViewRows;

@property(nonatomic,assign)NSInteger bottomViewH;


@end

@implementation OrdersDetailViewController


-(instancetype)initWithOrdersStatus:(orderState)orderState{
    
    self =  [super init];
    
    if (self) {
    
        self.CodeNumberCellDisplay = NO;//条形码cell是否显示，默认隐藏
        self.selectServiceCellDisplay = NO;//默认隐藏商家服务状态
        self.bottomViewH = 45;//底部视图的高度，根据高度判断显示哪一种底部视图
        self.buttonEnabled = YES;//底部的button是否可以编辑
        self.switchHidden = NO;// 默认隐藏 条形码对比
        
        switch (orderState) {
                
            case ordersStateFulfill:
                
                self.buttonTitle = @"交易完成";
                self.buttonEnabled = NO;
                self.CodeNumberCellDisplay = YES;

                break;
            case ordersStateWaitReceipt:
                
                self.buttonTitle = @"待收货";
                self.switchHidden = YES;
                
                break;
            case ordersStateWaitConfirm:
                
                self.buttonTitle = @"待商家确认服务";
                self.bottomViewH = 0;
                self.CodeNumberCellDisplay = YES;
                self.selectServiceCellDisplay = YES;
                
                break;
            case ordersStateInvalid:
                
                self.buttonTitle = @"作废";
                self.buttonEnabled = NO;
                self.CodeNumberCellDisplay = YES;

                break;
            case ordersStateWaitShip:
                
                self.buttonEnabled = NO;
                self.buttonTitle = @"待发货";

                break;
            case ordersStateWaitOwnerConfirmation:
                
                self.buttonTitle = @"待车主确认服务";
                self.buttonEnabled = NO;

                break;
            case ordersStateWaitAssess:
                
                self.buttonTitle = @"待评价";
                self.buttonEnabled = NO;

                break;
            case ordersStateWaitPay:
                
                self.buttonTitle = @"待支付";
                self.buttonEnabled = NO;

                break;
                
            default:
                break;
        }
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.bottomViewH != 0) {
        
        [self.view addSubview:self.submitBtn];

    }else{

    }
    
    [self.view addSubview:self.tableView];
}


-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 5;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            if (self.ordersTitleArr.count>0) {
                
                return self.ordersTitleArr.count;
            }
            
            return 0;
            break;
        case 1:
            
            
            return self.tiresNumArr.count>0?self.tiresNumArr.count:0;
            
            break;
        case 2:
            

            return self.CodeNumberCellDisplay == NO? 0:self.codeNumArr.count>0?self.codeNumArr.count:0;
            
            break;
        case 3:
            
            
            return 2;
            break;
        case 4:
            
            return self.selectServiceCellDisplay == NO? 0:self.storeServiceTypes.count>0?self.storeServiceTypes.count:0;
            break;
            
        default:
            break;
    }
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            OrdersInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ordersInfoCellID" forIndexPath:indexPath];
            if (self.ordersContentArr.count>0) {
                cell.contentLab.text = self.ordersContentArr[indexPath.row];
            }
            cell.titleLab.text = self.ordersTitleArr[indexPath.row];
            
            return cell;
            
        }
            break;
        case 1:{
            
            TiresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tiresCellID" forIndexPath:indexPath];
            
            TiresModel *model = [[TiresModel alloc] init];
            [model setValuesForKeysWithDictionary:self.tiresNumArr[indexPath.row]];
            [cell setTiresModel:model orderType:self.orderTypeStr];
            
            return cell;
            
        }
            
            break;
        case 2:{
            
            CodeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"codeNumberCellID" forIndexPath:indexPath];
            cell.barCodeLab.text = [self.codeNumArr[indexPath.row] objectForKey:@"barCode"];
            cell.statusButton.hidden = !self.switchHidden;
            return cell;
        }
            
            break;
            
        case 3:{
            
            OrdersPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ordersPhotoCellID" forIndexPath:indexPath];
            
            cell.titleLab.text = @[@"行驶证照片",@"车辆照片"][indexPath.row];
            
            return cell;
            
        }
            break;
            
        case 4:{
            
            SelectServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectServiceTypeCellID" forIndexPath:indexPath];
            JJWeakSelf
            cell.popBlock = ^(BOOL isPop) {
                
                if (isPop) {
                    
                    weakSelf.popOrdersVCBlock(YES);
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            };
            
            if (self.ordersContentArr.count>0) {
                cell.ordersNum = self.ordersContentArr[3];
                cell.orderType = self.orderTypeStr;
                NSNumber *i = self.storeServiceTypes[indexPath.row];
                [cell setCellType:i.integerValue];
            }
            
            return cell;
        }
            
            break;
            
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nullCellID" forIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 50;
            break;
        case 1:
            
            return 150;
            break;
        case 2:
            
            return 50;
            break;
        case 3:
        
            return 112;
            break;
        case 4:
            
            return 40;
            break;
            
        default:
            break;
    }
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        if (self.CodeNumberCellDisplay) {
            return 40.f;
        }
        return 5.f;
    }
    
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==2) {
        
        if (!self.CodeNumberCellDisplay) {
            
            return [UIView new];
        }
        CodeNumheadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"codeNumHeadView"];
        
        header.rigthTextHidden = !self.switchHidden;
        
        return header;
    }
    
    return [UIView new];
}


-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    
    [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (self.ordersContentArr.count>0) {
            
            [self.ordersContentArr removeAllObjects];
        }
        
        if (self.tiresNumArr.count>0) {
            
            [self.tiresNumArr removeAllObjects];
        }
        
        if (self.codeNumArr.count>0) {
            
            [self.codeNumArr removeAllObjects];
        }

        
        [self.ordersContentArr addObject:[data objectForKey:@"userName"]];
        [self.ordersContentArr addObject:[data objectForKey:@"platNumber"]];
        [self.ordersContentArr addObject:[data objectForKey:@"storeName"]];
        [self.ordersContentArr addObject:[data objectForKey:@"orderNo"]];
        
//        [self.ordersContentArr addObject:[data objectForKey:@"orderType"]];

        
        
        self.orderTypeStr = [data objectForKey:@"orderType"];
        
        [self.tiresNumArr addObjectsFromArray:[data objectForKey:@"firstChangeOrderVoList"]];
        
        [self.codeNumArr addObjectsFromArray:[data objectForKey:@"userCarShoeBarCodeList"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)submitOrderInfoEvent{
    
    //最终界面未定型   暂不做操作
    
//    NSDictionary *dic = [[NSDictionary alloc] init];
//
//    NSMutableArray *newArr = [NSMutableArray array];
//
//    if (newArr.count>0) {
//
//        [newArr removeAllObjects];
//    }
//
//
//
//    CodeNumberCell *cell;
//
//    for (int i = 0; i<=self.codeNumArr.count-1; i++) {
//
//
//        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
//
//        dic = self.codeNumArr[i];
//
//        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];
//
//        if (cell.statusButton.on) {
//
//            [newDic setObject:@"2" forKey:@"status"];
//
//        }else{
//
//            [newDic setObject:@"1" forKey:@"status"];
//        }
//
//        [newDic setObject:[dic objectForKey:@"barCode"] forKey:@"barCode"];
//        [newDic setObject:[dic objectForKey:@"id"] forKey:@"id"];
//        [newDic setObject:[dic objectForKey:@"orderNo"] forKey:@"orderNo"];
//
//
//        [newArr addObject:newDic];
//
//    }
//
//
//    NSLog(@"新的数组：%@",newArr);
//
//    [MainOrdersRequest submitStoreConfirmReceiptShoesWithInfo:newArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
//
//
//        [self.navigationController popViewControllerAnimated:YES];
//
//    } failure:^(NSError * _Nullable error) {
//
//    }];
    
    
}

-(NSArray *)ordersTitleArr{
    
    if (!_ordersTitleArr) {
        _ordersTitleArr = [NSArray array];
        _ordersTitleArr = @[@"用户名",@"车牌号",@"店铺名",@"订单编号"];
    }
    return _ordersTitleArr;
}

-(NSMutableArray *)ordersContentArr{
    
    if (!_ordersContentArr) {
        
        _ordersContentArr = [NSMutableArray array];
    }
    
    return _ordersContentArr;
}

-(NSMutableArray *)tiresNumArr{
    
    if (!_tiresNumArr) {
        
        _tiresNumArr = [NSMutableArray array];
    }
    
    return _tiresNumArr;
}

-(NSMutableArray *)codeNumArr{
    
    if (!_codeNumArr) {
        
        _codeNumArr = [NSMutableArray array];
    }
    
    
    return _codeNumArr;
}


-(NSArray *)storeServiceTypes{
    
    if (!_storeServiceTypes) {
        
        _storeServiceTypes = @[@(StoreConfirmServiceType),@(StoreRefuseServiceType),@(clientSelfHelpServiceType)];
    }
    
    
    
    return _storeServiceTypes;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        CGRect frame;
        if (KIsiPhoneX) {
            frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-34-88-self.bottomViewH);
        }else{
            
            frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-self.bottomViewH);
        }
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[CodeNumheadView class] forHeaderFooterViewReuseIdentifier:@"codeNumHeadView"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersInfoCell class]) bundle:nil] forCellReuseIdentifier:@"ordersInfoCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TiresCell class]) bundle:nil] forCellReuseIdentifier:@"tiresCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CodeNumberCell class]) bundle:nil] forCellReuseIdentifier:@"codeNumberCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersPhotoCell class]) bundle:nil] forCellReuseIdentifier:@"ordersPhotoCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectServiceCell class]) bundle:nil] forCellReuseIdentifier:@"selectServiceTypeCellID"];        
    }
    
    return _tableView;
}

-(UIButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (KIsiPhoneX) {
            
            [_submitBtn setFrame:CGRectMake(16, SCREEN_HEIGHT-self.bottomViewH-88-34, SCREEN_WIDTH-32, self.bottomViewH)];
            
        }else{
            
            [_submitBtn setFrame:CGRectMake(16, SCREEN_HEIGHT-self.bottomViewH-64, SCREEN_WIDTH-32, self.bottomViewH)];
        }
        [_submitBtn setEnabled:self.buttonEnabled];

        [_submitBtn setTitle:self.buttonTitle forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitOrderInfoEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_submitBtn setTitle:self.buttonTitle forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        if (self.isButtonEnabled) {
            
            [_submitBtn setBackgroundColor:JJThemeColor];
        }else{
        [_submitBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    
    
    return _submitBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
