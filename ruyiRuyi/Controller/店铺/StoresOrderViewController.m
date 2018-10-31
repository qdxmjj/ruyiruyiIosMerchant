//
//  StoresOrderViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "StoresOrderViewController.h"
#import "MainOrdersRequest.h"
#import "StoresRequest.h"
#import "OrdersInfoCell.h"
#import "StoresOrderCommodityCell.h"
#import "CommodityInfoModel.h"
@interface StoresOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *bottomBtn;

@property(nonatomic,strong)NSArray *ordersTitleArr;

@property(nonatomic,strong)NSMutableArray *ordersContentArr;

//商品信息
@property(nonatomic,strong)NSMutableArray *commodityInfoArr;

@property(nonatomic,strong)NSMutableArray *couponArr;

//订单类型
@property(nonatomic,copy)NSString *orderTypeStr;

//底部button内容
@property(nonatomic,copy)NSString *buttonTitle;

//button是否可以点击
@property(nonatomic,assign,getter=isButtonEnabled)BOOL buttonEnabled;


@property(nonatomic,copy)NSString *orderType;
@end

@implementation StoresOrderViewController

-(instancetype)initWithOrdersStatus:(orderState )orderState{
    self = [super init];
    
    if (self) {
        
        self.orderType = [NSString stringWithFormat:@"%ld",(long)orderState];
        
        self.buttonEnabled = NO;
        
        switch (orderState) {
                
            case ordersStateFulfill:
                
                self.buttonTitle = @"已完成";
                
                break;
            case ordersStateWaitReceipt:
                
                self.buttonTitle = @"待收货";
                
                break;
            case ordersStateWaitConfirm:
                
                self.buttonTitle = @"提交";
                self.buttonEnabled = YES;
                break;
            case ordersStateInvalid:
                
                self.buttonTitle = @"作废";
                
                break;
            case ordersStateWaitShip:
                
                self.buttonTitle = @"待发货";
                
                break;
            case ordersStateWaitOwnerConfirmation:
                
                self.buttonTitle = @"待车主确认服务";
                
                break;
            case ordersStateWaitAssess:
                
                self.buttonTitle = @"待评价";
                
                break;
            case ordersStateWaitPay:
                
                self.buttonTitle = @"待支付";
                
                break;
            case ordersStatuRefunding:
                
                self.buttonTitle = @"退款中";
                
                break;
            case ordersStatusRefunded:
                
                self.buttonTitle = @"已退款";
                
                break;
            case ordersStateUserCanceled:
                
                self.buttonTitle = @"用户已取消";
                
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品订单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBtn];
}

-(void)viewWillLayoutSubviews{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop); make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(50);
            
        } else {
            make.top.mas_equalTo(self.view.mas_top);
            make.bottom.mas_equalTo(self.view.mas_bottom).inset(50);
        }
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(self.view).inset(16);
        make.top.mas_equalTo(self.tableView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(10);
        } else {

            make.bottom.mas_equalTo(self.view.mas_bottom).inset(10);
        }
    }];
}

-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    
    [super getOrdersInfo:orderType orderType:orderType storeId:storeId];

    [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        [self.ordersContentArr addObject:[data objectForKey:@"userName"]];
        [self.ordersContentArr addObject:[data objectForKey:@"userPhone"]];
        [self.ordersContentArr addObject:[data objectForKey:@"platNumber"]];
        [self.ordersContentArr addObject:[data objectForKey:@"storeName"]];
        NSString *orderTypeText;
        switch ([[data objectForKey:@"orderType"] longLongValue]) {
            case 1:
                
                orderTypeText = @"普通商品购买订单";
                break;
            case 2:
                
                orderTypeText = @"首次更换订单";
                break;
            case 3:
                
                orderTypeText = @"免费再换订单";
                break;
            case 4:
                
                orderTypeText = @"轮胎修补订单";
                break;
            default:
                orderTypeText = @"未知的订单";
                break;
        }
        
        [self.ordersContentArr addObject:orderTypeText];
        [self.ordersContentArr addObject:[data objectForKey:@"orderNo"]];
        
        self.orderTypeStr = [data objectForKey:@"orderType"];
        
        if ([data objectForKey:@"stockOrderVoList"] == [NSNull null]) {
            
            [self.commodityInfoArr addObjectsFromArray:@[]];
            
        }else{
            
            [self.commodityInfoArr addObjectsFromArray:[data objectForKey:@"stockOrderVoList"]];
        }
        
        if ([[data objectForKey:@"saleName"] isEqualToString:@""]) {
            
            if ([data objectForKey:@"orderTotalPrice"] != [data objectForKey:@"orderActuallyPrice"]) {
                
                [self.couponArr addObject:@"优惠券已退还"];
            }else{
                
                [self.couponArr addObject:@"未使用优惠券"];
            }
        }else{
            
            [self.couponArr addObject:[data objectForKey:@"saleName"]];
        }
        [self.couponArr addObject:[data objectForKey:@"orderTotalPrice"]];
        [self.couponArr addObject:[data objectForKey:@"orderActuallyPrice"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return self.ordersTitleArr.count;
            break;
        case 1:
            
            if (self.commodityInfoArr.count>0) {
                
                return self.commodityInfoArr.count;
            }
            
            return 0;
            break;
        case 2:
            
            return 3;
            break;
            
        default:
            break;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            
            OrdersInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storesOrdersInfoCellID" forIndexPath:indexPath];
            
            if (self.ordersContentArr.count>0) {
                
                cell.contentLab.text = self.ordersContentArr[indexPath.row];
            }
            cell.titleLab.text = self.ordersTitleArr[indexPath.row];
            
            return cell;
        }
            break;
        case 1:{
            
            StoresOrderCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storesOrderCommodityCellID" forIndexPath:indexPath];
            
            CommodityInfoModel *model = [[CommodityInfoModel alloc] init];
            
            [model setValuesForKeysWithDictionary:self.commodityInfoArr [indexPath.row]];
            
            [cell setCommodityInfoModel:model];
            
            return cell;
        }
            break;
        case 2:{
            
            OrdersInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storesOrdersInfoCellID" forIndexPath:indexPath];
            
            if (self.couponArr.count>0) {
                
                cell.contentLab.text = self.couponArr[indexPath.row];
            }
            cell.titleLab.text = @[@"优惠券类型",@"订单总额",@"实付金额"][indexPath.row];
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storesOrderCellID" forIndexPath:indexPath];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==1) {
        
        return 112;
    }
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(void)confirmOrderEvent:(UIButton *)sender{
    
    [StoresRequest confirmOrderRequestWithInfo:@{@"orderNo":self.ordersContentArr[5],@"serviceType":@"1",@"orderType":self.orderType} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        [self.navigationController popViewControllerAnimated:YES];
        self.popOrdersVCBlock(YES);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersInfoCell class]) bundle:nil] forCellReuseIdentifier:@"storesOrdersInfoCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoresOrderCommodityCell class]) bundle:nil] forCellReuseIdentifier:@"storesOrderCommodityCellID"];

    }
    
    return _tableView;
}

-(UIButton *)bottomBtn{
    
    if (!_bottomBtn) {
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
  
        [_bottomBtn setEnabled:self.buttonEnabled];
        [_bottomBtn setTitle:self.buttonTitle forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_bottomBtn setTitle:self.buttonTitle forState:UIControlStateDisabled];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        [_bottomBtn addTarget:self action:@selector(confirmOrderEvent:) forControlEvents:UIControlEventTouchUpInside];
        if (self.isButtonEnabled) {
            
            [_bottomBtn setBackgroundColor:JJThemeColor];
        }else{
            [_bottomBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        _bottomBtn.layer.cornerRadius = 5.f;
        _bottomBtn.layer.masksToBounds = YES;
    }
    
    return _bottomBtn;
}

-(NSArray *)ordersTitleArr{
    
    if (!_ordersTitleArr) {
        _ordersTitleArr = [NSArray array];
        _ordersTitleArr = @[@"联系人",@"联系电话",@"车牌号",@"店铺名",@"订单类型",@"订单编号"];
    }
    return _ordersTitleArr;
}

-(NSMutableArray *)ordersContentArr{
    
    if (!_ordersContentArr) {
        
        _ordersContentArr = [NSMutableArray array];
    }
    
    return _ordersContentArr;
}
-(NSMutableArray *)commodityInfoArr{
    
    if (!_commodityInfoArr) {
        
        _commodityInfoArr = [NSMutableArray array];
    }
    
    return _commodityInfoArr;
}

-(NSMutableArray *)couponArr{
    
    if (!_couponArr) {
        
        _couponArr = [NSMutableArray array];
    }
    return _couponArr;
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
