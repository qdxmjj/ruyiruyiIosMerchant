//
//  TireRepairViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TireRepairViewController.h"
#import "TireRepairBarCodeCell.h"
#import "FreeChangAgainTirePhotoCell.h"
#import "TirePhotoHeaderView.h"

#import "CustomizeExampleViewController.h"
@interface TireRepairViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *submitBtn;

//底部button内容
@property(nonatomic,copy)NSString *buttonTitle;

@property(nonatomic,copy)NSString *orderTypeStr;//订单类型

//第0行cell，显示的固定内容
@property(nonatomic,strong)NSArray *ordersTitleArr;

//第0行cell，显示的获取内容
@property(nonatomic,strong)NSMutableArray *ordersContentArr;

//条形码数据
@property(nonatomic,strong)NSMutableArray *BarCodeArr;

//轮胎照片cell 数据源 每个照片对应一条条形码
@property(nonatomic,strong)NSMutableArray *tireRepairPhotoArr;

//上传用 repairBarCodeList  选择修补的条形码数组
@property(nonatomic,strong)NSMutableArray *submitBarCodeArr;

/**
 * 二个状态 确认服务 拒绝服务
 */
@property(nonatomic,strong)NSArray * storeServiceTypes;

//是否显示修补次数，轮胎照片，行驶证照片，两个状态
@property(nonatomic,assign)BOOL repairTimesHidden;

//button是否可以点击
@property(nonatomic,assign,getter=isButtonEnabled)BOOL buttonEnabled;


@end

@implementation TireRepairViewController

@synthesize popOrdersVCBlock = _popOrdersVCBlock;

-(instancetype)initWithOrdersStatus:(orderState)orderState{
    
    self = [super init];
    
    if (self) {
        
        self.repairTimesHidden = NO;//默认显示
        
        switch (orderState) {
                
            case ordersStateFulfill:
                
                self.buttonTitle = @"交易完成";
                self.buttonEnabled = NO;
                
                break;
            case ordersStateWaitReceipt:
                
                self.buttonTitle = @"确认收货";
                self.buttonEnabled = NO;

                break;
            case ordersStateWaitConfirm:
                
                //商家没有待确认服务
                self.repairTimesHidden = YES;
                
                break;
            case ordersStateInvalid:
                
                self.buttonTitle = @"作废";
                self.buttonEnabled = NO;
                
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

-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    
    [super getOrdersInfo:orderNo orderType:orderType storeId:storeId];
    
    [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
       
        if (self.ordersContentArr.count>0) {
            
            [self.ordersContentArr removeAllObjects];
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
        
        [self.ordersContentArr addObject:orderTypeText];
        [self.ordersContentArr addObject:[data objectForKey:@"orderNo"]];
        
        [self.BarCodeArr addObjectsFromArray:[data objectForKey:@"userCarShoeOldBarCodeList"]];
        [self.submitBarCodeArr addObjectsFromArray:[data objectForKey:@"userCarShoeOldBarCodeList"]];
        self.orderTypeStr = [data objectForKey:@"orderType"];

        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
       
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

//-------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮胎修补订单";
    
    [self.view addSubview:self.tableView];
    
    if (!self.repairTimesHidden) {
        
        [self.view addSubview:self.submitBtn];
    }
}

-(void)viewWillLayoutSubviews{
    
    if (!self.repairTimesHidden) {
        
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.and.right.mas_equalTo(self.view).inset(16);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view.mas_bottom);
            }
            make.height.mas_equalTo(@40);
        }];
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(self.view.mas_width);
        if (self.repairTimesHidden) {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }else{
            make.bottom.mas_equalTo(self.submitBtn.mas_top);
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return self.ordersTitleArr.count >0? self.ordersTitleArr.count : 0;
            break;
        case 1:
            
            return self.BarCodeArr.count >0? self.BarCodeArr.count : 0;
            break;
        case 2:
            
            if (!self.repairTimesHidden) {
                
                return 0;
            }
            return self.tireRepairPhotoArr.count>0?self.tireRepairPhotoArr.count : 0;
            break;
        case 3:
            
            if (!self.repairTimesHidden) {
                
                return 0;
            }
            return 2;
            break;
        case 4:
            
            
            if (!self.repairTimesHidden) {
                
                return 0;
            }
            return self.storeServiceTypes.count>0 ? self.storeServiceTypes.count : 0;
            break;
            
        default:
            break;
    }
    
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            OrdersInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireRepairInfoCellID" forIndexPath:indexPath];
            
            if (self.ordersContentArr.count>0) {
                
                cell.contentLab.text = self.ordersContentArr[indexPath.row];
            }
            cell.titleLab.text = self.ordersTitleArr[indexPath.row];
            
            return cell;
        }
            break;
        case 1:{
            
            TireRepairBarCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireRepairBarCodeCellID" forIndexPath:indexPath];
            
            TireRepairBarCodeModel *model = [[TireRepairBarCodeModel alloc] init];
            
            [model setValuesForKeysWithDictionary:self.BarCodeArr[indexPath.row]];
            
            [cell setModel:model];
           
            [cell setStepperViewHidden:self.repairTimesHidden];
            
            JJWeakSelf
            cell.updateBlock = ^(CGFloat value) {
              
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                
                //取得原始数据
                [dic addEntriesFromDictionary: weakSelf.BarCodeArr[indexPath.row]];
                //取得原始数量 + 现在修补数量 +0 +1 +2 +3
                NSInteger count = [[dic objectForKey:@"repairAmount"] longLongValue] + value;
                //替换当前数据 的 修补数量
                [dic setValue:@(count) forKey:@"repairAmount"];
                //替换原始数量模板submitBarCodeArr 对应条数据
                [weakSelf.submitBarCodeArr replaceObjectAtIndex:indexPath.row withObject:dic];
                
                if (value) {
                    //+1 +2 +3
                    if ([weakSelf.tireRepairPhotoArr containsObject:[weakSelf.BarCodeArr[indexPath.row] objectForKey:@"barCode"]]) {
                    }else{
                        [weakSelf.tireRepairPhotoArr addObject:[weakSelf.BarCodeArr[indexPath.row] objectForKey:@"barCode"]];
                
                        [tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationNone)];
                    }
                }else{
                
                    // value == 0 执行此
                    [weakSelf.tireRepairPhotoArr removeObject:[weakSelf.BarCodeArr[indexPath.row] objectForKey:@"barCode"]];
                
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:(UITableViewRowAnimationNone)];
                }

            };
            return cell;
        }
            break;
        case 2:{
            
            FreeChangAgainTirePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireRepairPhotoCellID" forIndexPath:indexPath];
            
            cell.codeNumberLab.text = self.tireRepairPhotoArr[indexPath.row];
            
            return cell;
        }
            break;
        case 3:{
            
            OrdersPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireRepairOrdersPhotoCellID" forIndexPath:indexPath];
            
            cell.titleLab.text = @[@"行驶证照片",@"车辆照片"][indexPath.row];
            [cell.exampleBtn addTarget:self action:@selector(pushPhotographExampleVC) forControlEvents:UIControlEventTouchUpInside];
            if (indexPath.row == 1) {
                
                [cell.exampleBtn setHidden:NO];
            }
            return cell;
        }
            break;
        case 4:{
            
            SelectServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireRepairSelectServiceCellID" forIndexPath:indexPath];

            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);

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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireRepairViewControllerID" forIndexPath:indexPath];
    
    
    return cell;
}


    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        switch (indexPath.section) {
            case 0:
                
                return 50;
                break;
            case 1:
                
                return 44;
                break;
            case 2:
                
                return 115;
                break;
            case 3:
                
                return 112;
                break;
            case 4:
                
                return 50;
                break;
          
            default:
                break;
        }
        
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 1:
            
            return 40;
            break;
        case 2:
            
            if (!self.repairTimesHidden) {
                
                return 1.5;
            }
            return 40;
            break;
            
        default:
            break;
    }
    
    return 1.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 1.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (section) {

        case 1:{
         
            CGFloat h = [self tableView:tableView heightForHeaderInSection:section];
            
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
            headerView.backgroundColor = [UIColor whiteColor];
            UILabel *tireBarCodeLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, h)];
            tireBarCodeLab.text = @"补胎编号";
            
            UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80-16, 0, 80, h)];
            number.text = @"修补次数";
            number.textAlignment = NSTextAlignmentRight;
            number.hidden = self.repairTimesHidden;
            [headerView addSubview:number];
            [headerView addSubview:tireBarCodeLab];
            return headerView;
        }
            break;
        case 2:{
            
            if (!self.repairTimesHidden) {
                
                return [UIView new];
            }
            TirePhotoHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TireRepairPhotoHeaderViewID"];
            [header.exampleBtn addTarget:self action:@selector(pushPhotographExampleVCTire) forControlEvents:UIControlEventTouchUpInside];
            return header;
        }
            break;
            
        default:
            break;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

#pragma mark button click event 点击事件
-(void)pushPhotographExampleVC{
    
    CustomizeExampleViewController *ceVC = [[CustomizeExampleViewController alloc] init];
    
    ceVC.contentArr = @[@"从车前方左侧45°角拍摄",@"机动车影像应占相片的三分之二",@"机动车相片应当能够清晰辨认车身颜色及外观特征"].mutableCopy;
    
    ceVC.imgNameArr = @[@"车辆示例"].mutableCopy;
    
    [self.navigationController pushViewController:ceVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)pushPhotographExampleVCTire{
    
    CustomizeExampleViewController *ceVC = [[CustomizeExampleViewController alloc] init];
    
    ceVC.contentArr = @[@"轮胎破损部位特写照",@"轮胎条形码特写照",@"每条确定免费更换的轮胎必须拍以上两张照片"].mutableCopy;
    
    ceVC.imgNameArr = @[@"前轮示例",@"后轮示例"].mutableCopy;
    
    [self.navigationController pushViewController:ceVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
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
        
    }else if([sender.titleLabel.text isEqualToString:@"拒绝服务"]){
        
        serviceType = StoreRefuseServiceType;
        
        [MainOrdersRequest tireRepairSelectServiceTypeWithInfo:@{@"orderNo":self.ordersContentArr[5],@"serviceType":[NSString stringWithFormat:@"%ld",(long)serviceType],@"orderType":self.orderTypeStr} repairBarCodeList:@[] photos:@[] succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            [MBProgressHUD hideWaitViewAnimated:self.view];
            [self.navigationController popViewControllerAnimated:YES];
            self.popOrdersVCBlock(YES);
            
        } failure:^(NSError * _Nullable error) {
            
        }];
        
        return;
        
    }else{
        
        serviceType = 4;
    }
    
    if (self.tireRepairPhotoArr.count<=0) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        [MBProgressHUD showTextMessage:@"至少选择一处修补！"];
        return;
    }
    
    NSMutableArray *repairBarCodeList = [NSMutableArray array];
    
    //此次没有修补的轮胎  不传递给后台  只传修补过的轮胎
    for (int i = 0; i<self.submitBarCodeArr.count; i++) {
        
        NSDictionary * barCodeDic = self.submitBarCodeArr[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSDictionary * oldBarCodeDic = self.BarCodeArr[i];
        
        NSInteger oldCount = [[oldBarCodeDic objectForKey:@"repairAmount"] integerValue];
        NSInteger newCount = [[barCodeDic objectForKey:@"repairAmount"] integerValue];
        
        if (newCount > oldCount) {
            
            [dic setObject:[barCodeDic objectForKey:@"barCode"] forKey:@"barCode"];
            [dic setObject:[barCodeDic objectForKey:@"repairAmount"] forKey:@"repairAmount"];
            
            [repairBarCodeList addObject:dic];
        }else if (newCount<oldCount){
            
            [MBProgressHUD showTextMessage:@"数据异常！"];
        }else{
            
        }
    }
    
    float imgCompressionQuality = 0.3;//图片压缩比例
    
    NSMutableArray <JJFileParam *> *photoArr = [NSMutableArray array];
    
    for (int i = 0; i<self.tireRepairPhotoArr.count; i++) {
        
        FreeChangAgainTirePhotoCell *tirePhotoCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];
        
        if (tirePhotoCell.selectTirePhotoBtn.imageView.image == nil) {
            
            [MBProgressHUD hideWaitViewAnimated:self.view];
            [MBProgressHUD showTextMessage:@"请添加轮胎正面照！"];
            return;
        }
        
        if (tirePhotoCell.selectBarCodeBtn.imageView.image == nil) {
            
            [MBProgressHUD hideWaitViewAnimated:self.view];
            [MBProgressHUD showTextMessage:@"请添加条形码特写照！"];
            return;
        }
    }
    
    for (int i = 0; i<self.tireRepairPhotoArr.count; i++) {
        
        FreeChangAgainTirePhotoCell *tirePhotoCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];
        NSData *imgData = UIImageJPEGRepresentation(tirePhotoCell.selectTirePhotoBtn.imageView.image, imgCompressionQuality);
        
        NSData *barCodeData = UIImageJPEGRepresentation(tirePhotoCell.selectBarCodeBtn.imageView.image, imgCompressionQuality);
        
        //上传的文件 key 名
        NSString *tireName = [NSString stringWithFormat:@"shoe%dImg",i+1];
        NSString *barCodeName = [NSString stringWithFormat:@"shoe%dBarCodeImg",i+1];
        
        //上传的文件名
        NSString *tireFileName = [NSString stringWithFormat:@"shoe%@.png",tirePhotoCell.codeNumberLab.text];
        NSString *barCodeFileName = [NSString stringWithFormat:@"barCode%@.png",tirePhotoCell.codeNumberLab.text];;
        
        [photoArr addObject:[JJFileParam fileConfigWithfileData:imgData name:tireName fileName:tireFileName mimeType:@"image/jpg/png/jpeg"]];
        [photoArr addObject:[JJFileParam fileConfigWithfileData:barCodeData name:barCodeName fileName:barCodeFileName mimeType:@"image/jpg/png/jpeg"]];
    }
    
    OrdersPhotoCell *DrivingLicenseCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    
    if (DrivingLicenseCell.selectPhotoBen.imageView.image == nil) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        [MBProgressHUD showTextMessage:@"请选择行驶证照片！"];
        return;
    }
    OrdersPhotoCell *carCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3]];
    
    if (carCell.selectPhotoBen.imageView.image == nil) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        [MBProgressHUD showTextMessage:@"请选择车辆照片！"];
        return;
    }
    
    NSData *drivingLicenseImgData=UIImageJPEGRepresentation(DrivingLicenseCell.selectPhotoBen.imageView.image, imgCompressionQuality);
    
    NSData *carImgData=UIImageJPEGRepresentation(carCell.selectPhotoBen.imageView.image,  imgCompressionQuality);
    
    [photoArr addObject:[JJFileParam fileConfigWithfileData:drivingLicenseImgData name:@"drivingLicenseImg" fileName:@"xingshizheng.png" mimeType:@"image/jpg/png/jpeg"]];
    
    [photoArr addObject:[JJFileParam fileConfigWithfileData:carImgData name:@"carImg" fileName:@"cheliang.png" mimeType:@"image/jpg/png/jpeg"]];
    
    [MainOrdersRequest tireRepairSelectServiceTypeWithInfo:@{@"orderNo":self.ordersContentArr[5],@"serviceType":[NSString stringWithFormat:@"%ld",(long)serviceType],@"orderType":self.orderTypeStr} repairBarCodeList:repairBarCodeList photos:photoArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        [self.navigationController popViewControllerAnimated:YES];
        self.popOrdersVCBlock(YES);

     } failure:^(NSError * _Nullable error) {
         
     }];
}

#pragma mark 懒加载
-(UITableView *)tableView{
    if (!_tableView) {

        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];

        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersInfoCell class]) bundle:nil] forCellReuseIdentifier:@"TireRepairInfoCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TireRepairBarCodeCell class]) bundle:nil] forCellReuseIdentifier:@"TireRepairBarCodeCellID"];

        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FreeChangAgainTirePhotoCell class]) bundle:nil] forCellReuseIdentifier:@"TireRepairPhotoCellID"];

        [_tableView registerClass:[TirePhotoHeaderView class] forHeaderFooterViewReuseIdentifier:@"TireRepairPhotoHeaderViewID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersPhotoCell class]) bundle:nil] forCellReuseIdentifier:@"TireRepairOrdersPhotoCellID"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectServiceCell class]) bundle:nil] forCellReuseIdentifier:@"TireRepairSelectServiceCellID"];

        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TireRepairViewControllerID"];
        

    }
    return _tableView;
}

-(UIButton *)submitBtn{
    
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setEnabled:self.buttonEnabled];
        [_submitBtn setTitle:self.buttonTitle forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_submitBtn setTitle:self.buttonTitle forState:UIControlStateDisabled];
        
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        if (self.isButtonEnabled) {
            
            [_submitBtn setBackgroundColor:JJThemeColor];
        }else{
            [_submitBtn setBackgroundColor:[UIColor lightGrayColor]];
        }

        _submitBtn.layer.cornerRadius = 5.f;
        _submitBtn.layer.masksToBounds = YES;
    }
    
    
    return _submitBtn;
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

-(NSMutableArray *)BarCodeArr{
    
    if (!_BarCodeArr) {
        
        _BarCodeArr = [NSMutableArray array];
    }
    return _BarCodeArr;
}

-(NSMutableArray *)tireRepairPhotoArr{
    
    if (!_tireRepairPhotoArr) {
        
        _tireRepairPhotoArr = [NSMutableArray array];
    }
    
    
    return _tireRepairPhotoArr;
}

-(NSMutableArray *)submitBarCodeArr{
    
    if (!_submitBarCodeArr) {
        
        _submitBarCodeArr = [NSMutableArray array];
    }
    return _submitBarCodeArr;
}

-(NSArray *)storeServiceTypes{
    
    if (!_storeServiceTypes) {
        
        _storeServiceTypes = @[@(StoreConfirmServiceType),@(StoreRefuseServiceType)];
    }
    return _storeServiceTypes;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
