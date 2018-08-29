//
//  FirstReplaceOrdersViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FirstReplaceOrdersViewController.h"

#import "CustomizeExampleViewController.h"
#import "OrdersViewController.h"
@interface FirstReplaceOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@property(nonatomic,assign)BOOL ordersPhotoCellDisplay;//是否显示订单相关照片

@property(nonatomic,assign,getter=isButtonEnabled)BOOL buttonEnabled;

@property(nonatomic,assign)BOOL switchHidden;

@property(nonatomic,copy)NSString *buttonTitle;

@property(nonatomic,assign)NSInteger tableViewRows;

@property(nonatomic,assign)NSInteger bottomViewH;


@end

@implementation FirstReplaceOrdersViewController

@synthesize popOrdersVCBlock = _popOrdersVCBlock;

-(instancetype)initWithOrdersStatus:(orderState)orderState{
    
    self =  [super init];
    
    if (self) {
    
        self.CodeNumberCellDisplay = NO;//条形码cell是否显示，默认隐藏
        self.selectServiceCellDisplay = NO;//默认隐藏商家服务状态
        self.bottomViewH = 40;//底部视图的高度，根据高度判断显示哪一种底部视图
        self.buttonEnabled = YES;//底部的button是否可以编辑
        self.switchHidden = NO;// 默认隐藏 条形码对比
        
        self.ordersPhotoCellDisplay = NO;//默认不显示订单相关照片
        
        switch (orderState) {
                
            case ordersStateFulfill:
                
                self.buttonTitle = @"交易完成";
                self.buttonEnabled = NO;
                self.CodeNumberCellDisplay = YES;

                break;
            case ordersStateWaitReceipt:
                
                self.buttonTitle = @"确认收货";
                self.CodeNumberCellDisplay = YES;
                self.switchHidden = YES;
                
                break;
            case ordersStateWaitConfirm:
                
                self.buttonTitle = @"确认服务";
                self.bottomViewH = 0;
                self.CodeNumberCellDisplay = YES;
                self.selectServiceCellDisplay = YES;
                self.ordersPhotoCellDisplay = YES;
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
                self.CodeNumberCellDisplay = YES;

                break;
            case ordersStateWaitAssess:
                
                self.buttonTitle = @"待评价";
                self.CodeNumberCellDisplay = YES;
                self.buttonEnabled = NO;

                break;
            case ordersStateWaitPay:
                
                self.buttonTitle = @"待支付";
                self.buttonEnabled = NO;

                break;
            case ordersStateRefuseService:
                
                self.buttonTitle = @"已取消";
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

    self.title = @"首次更换订单";
    
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
            
            if (self.ordersPhotoCellDisplay) {
                
                return 2;
            }
            
            return 0;
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
            [cell.exampleBtn addTarget:self action:@selector(pushPhotographExampleVC) forControlEvents:UIControlEventTouchUpInside];

            return cell;
            
        }
            break;
            
        case 4:{
            
            SelectServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectServiceTypeCellID" forIndexPath:indexPath];
            
            if (self.ordersContentArr.count>0) {

                NSNumber *i = self.storeServiceTypes[indexPath.row];
                [cell setCellType:i.integerValue];
            }
            [cell.ServiceTypeBtn addTarget:self action:@selector(selelctServiceType:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [super getOrdersInfo:orderNo orderType:orderType storeId:storeId];
    
    [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
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
        
        [self.ordersContentArr addObject:orderTypeText];        [self.ordersContentArr addObject:[data objectForKey:@"orderNo"]];
        
        
        self.orderTypeStr = [data objectForKey:@"orderType"];
        
        if ([data objectForKey:@"firstChangeOrderVoList"] == [NSNull null]) {
            
            [self.tiresNumArr addObjectsFromArray:@[]];
            
        }else{
            
            [self.tiresNumArr addObjectsFromArray:[data objectForKey:@"firstChangeOrderVoList"]];
        }
        
        [self.codeNumArr addObjectsFromArray:[data objectForKey:@"userCarShoeBarCodeList"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

#pragma mark button click event 点击事件
-(void)pushPhotographExampleVC{
    
    CustomizeExampleViewController *ceVC = [[CustomizeExampleViewController alloc] init];
    
    ceVC.contentArr = @[@"从车前方左侧45°角拍摄",@"机动车影像应占相片的三分之二",@"机动车相片应当能够清晰辨认车身颜色及外观特征"].mutableCopy;
    
    ceVC.imgNameArr = @[@"车辆示例"].mutableCopy;
    
    [self.navigationController pushViewController:ceVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}


-(void)submitOrderInfoEvent{
    
    //包含内存泄露，一个字典申请了两份内存，暂时无法测试修改会不会对功能有影响，以后再gai
    NSDictionary *dic = [[NSDictionary alloc] init];

    NSMutableArray *newArr = [NSMutableArray array];

    if (newArr.count>0) {

        [newArr removeAllObjects];
    }
    
    CodeNumberCell *cell;

    for (int i = 0; i<self.codeNumArr.count; i++) {


        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];

        dic = self.codeNumArr[i];

        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];

        if (cell.statusButton.on) {

            [newDic setObject:@"2" forKey:@"status"];

        }else{

            [newDic setObject:@"1" forKey:@"status"];
        }

        [newDic setObject:[dic objectForKey:@"barCode"] forKey:@"barCode"];
        [newDic setObject:[dic objectForKey:@"id"] forKey:@"id"];
        [newDic setObject:[dic objectForKey:@"orderNo"] forKey:@"orderNo"];

        [newArr addObject:newDic];
    }
//    NSLog(@"新的数组：%@",newArr);
    
    [MBProgressHUD showWaitMessage:@"正在处理.." showView:self.view];

    [MainOrdersRequest submitStoreConfirmReceiptShoesWithInfo:newArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        [MBProgressHUD hideWaitViewAnimated:self.view];
        [self.navigationController popViewControllerAnimated:YES];
        self.popOrdersVCBlock(YES);

    } failure:^(NSError * _Nullable error) {

    }];
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
        _submitBtn.layer.cornerRadius = 5.f;
        _submitBtn.layer.masksToBounds = YES;
        if (self.isButtonEnabled) {
            
            [_submitBtn setBackgroundColor:JJThemeColor];
        }else{
        [_submitBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    
    
    return _submitBtn;
}

- (void)selelctServiceType:(UIButton *)sender {
    
    if (!self.orderTypeStr&&self.orderTypeStr.length<=0) {
        
        [MBProgressHUD showTextMessage:@"订单信息获取失败！"];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在处理.." showView:self.view];
    
    StoreServiceType serviceType;
    if ([sender.titleLabel.text isEqualToString:@"确认服务"]) {
        
        
        serviceType = StoreConfirmServiceType;
        
    }else if ([sender.titleLabel.text isEqualToString:@"拒绝服务"]){
        
        serviceType = StoreRefuseServiceType;
        
        [MainOrdersRequest confirmServrceTypeWithInfo:@{@"orderNo":self.ordersContentArr[5],@"serviceType":[NSString stringWithFormat:@"%ld",(long)serviceType],@"orderType":self.orderTypeStr} photos:@[] succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            [MBProgressHUD hideWaitViewAnimated:self.view];
            self.popOrdersVCBlock(YES);
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError * _Nullable error) {
        }];
        
        return;
        
    }else{
        
        serviceType = clientSelfHelpServiceType;
    }
    
    OrdersPhotoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    
    OrdersPhotoCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];

    if (cell.selectPhotoBen.imageView.image == nil || cell1.selectPhotoBen.imageView.image == nil) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        [MBProgressHUD showTextMessage:@"请选择车辆相关照片！"];
        return;
    }
    
    float imgCompressionQuality = 0.3;//图片压缩比例
    
    NSData *drivingLicenseImgData=UIImageJPEGRepresentation(cell.selectPhotoBen.imageView.image, imgCompressionQuality);
    
    NSData *carImgData=UIImageJPEGRepresentation(cell1.selectPhotoBen.imageView.image,  imgCompressionQuality);
    
    NSArray <JJFileParam *> *arr=@[
                                   [JJFileParam fileConfigWithfileData:drivingLicenseImgData name:@"drivingLicenseImg" fileName:@"xingshizheng.png" mimeType:@"image/jpg/png/jpeg"],
                                   [JJFileParam fileConfigWithfileData:carImgData name:@"carImg" fileName:@"cheliang.png" mimeType:@"image/jpg/png/jpeg"]
                                   ];
    
    [MainOrdersRequest confirmServrceTypeWithInfo:@{@"orderNo":self.ordersContentArr[5],@"serviceType":[NSString stringWithFormat:@"%ld",(long)serviceType],@"orderType":self.orderTypeStr} photos:arr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];

        self.popOrdersVCBlock(YES);
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];

    }];
    
//    NSLog(@"%@   %@",self.orderTypeStr,self.ordersContentArr[5]);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
