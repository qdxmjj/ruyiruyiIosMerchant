//
//  FreeChangeAgainViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangeAgainViewController.h"
#import "CustomizeExampleViewController.h"
#import "FreeChangeAgainCodeNumberCell.h"
#import "FreeChangAgainTirePhotoCell.h"
#import "YMStoreTypePickerView.h"
#import <Masonry.h>
@interface FreeChangeAgainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *submitBtn;

//第0行cell，显示的固定内容
@property(nonatomic,strong)NSArray *ordersTitleArr;

//第0行cell，显示的获取内容
@property(nonatomic,strong)NSMutableArray *ordersContentArr;

//旧条形码
@property(nonatomic,strong)NSMutableArray *oldBarCodeArr;

//未处理的新条形码
@property(nonatomic,strong)NSMutableArray *originalNewbarCodeArr;

//可选择的新条形码
@property(nonatomic,strong)NSMutableArray *newBarCodeArr;

//轮胎信息
@property(nonatomic,strong)NSMutableArray *tiresNumArr;

//免费再换的轮胎信息
@property(nonatomic,strong)NSMutableArray *freeChangeArr;

//订单类型
@property(nonatomic,copy)NSString *orderTypeStr;

//底部button内容
@property(nonatomic,copy)NSString *buttonTitle;


/**
 * 三个状态 确认服务 补差服务 拒绝服务
 */
@property(nonatomic,strong)NSArray * storeServiceTypes;

//条形码是否显示
@property(nonatomic,assign)BOOL CodeNumberCellDisplay;

//商家确认服务类型是否显示
@property(nonatomic,assign)BOOL selectServiceCellDisplay;

//是否显示订单相关照片
@property(nonatomic,assign)BOOL ordersPhotoCellDisplay;

//button是否可以点击
@property(nonatomic,assign,getter=isButtonEnabled)BOOL buttonEnabled;

@property(nonatomic,assign)BOOL switchHidden;

@property(nonatomic,assign)BOOL barCodeCellDisplayType;

@property(nonatomic,assign)NSInteger bottomViewH;

@property(nonatomic,assign)NSInteger newTireNumber;//新轮胎数量
@end

@implementation FreeChangeAgainViewController

@synthesize popOrdersVCBlock = _popOrdersVCBlock;

-(instancetype)initWithOrdersStatus:(orderState)orderState{
    
    self = [super init];
    
    if (self) {
        
        NSLog(@"当前订单状态：%ld",orderState);
        self.CodeNumberCellDisplay = NO;//条形码cell是否显示，默认隐藏
        self.switchHidden = NO;// 默认隐藏 条形码对比
        self.selectServiceCellDisplay = NO;//默认隐藏商家服务状态
        self.barCodeCellDisplayType = NO;//默认隐藏带替换的条形码Cell
        self.ordersPhotoCellDisplay = NO;//默认不显示订单相关照片
        self.bottomViewH = 40;//底部视图的高度，根据高度判断显示哪一种底部视图
        self.buttonEnabled = YES;//底部的button是否可以编辑

        switch (orderState) {
                
            case ordersStateFulfill:
                
                self.buttonTitle = @"交易完成";
                self.buttonEnabled = NO;
                self.CodeNumberCellDisplay = YES;
                
                break;
            case ordersStateWaitReceipt:
                
                self.buttonTitle = @"待收货";
                self.CodeNumberCellDisplay = YES;
                self.switchHidden = YES;
                
                break;
            case ordersStateWaitConfirm:
                
                self.buttonTitle = @"待商家确认服务";
                self.bottomViewH = 0;
                self.barCodeCellDisplayType = YES;
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
    
    self.title = @"免费再换订单";
    
    if (self.bottomViewH != 0) {
        
        [self.view addSubview:self.submitBtn];
        
    }else{
        
    }

    [self.view addSubview:self.tableView];
    
}

#pragma mark 页面数据的获取
-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    
    [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (self.ordersContentArr.count>0) {
            
            [self.ordersContentArr removeAllObjects];
        }
        if (self.tiresNumArr.count>0) {
            
            [self.tiresNumArr removeAllObjects];
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
        
        self.orderTypeStr = [data objectForKey:@"orderType"];


        if ([data objectForKey:@"freeChangeOrderVoList"] == [NSNull null]) {
            
            [self.tiresNumArr addObjectsFromArray:@[]];
            
        }else{
            
            [self.tiresNumArr addObjectsFromArray:[data objectForKey:@"freeChangeOrderVoList"]];
        }
        
        
        [self.newBarCodeArr addObjectsFromArray:[self replaceOldBarCodeWithNewBarCode:[data objectForKey:@"userCarShoeBarCodeList"]]];
        
        [self.originalNewbarCodeArr addObjectsFromArray:[data objectForKey:@"userCarShoeBarCodeList"]];
        
        [self.oldBarCodeArr addObjectsFromArray:[data objectForKey:@"userCarShoeOldBarCodeList"]];

        self.newTireNumber = [[data objectForKey:@"userCarShoeBarCodeList"] count];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


#pragma mark tableViewDelegate
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 6;
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
            //两种条形码cell 先判断显示哪一种 在判断是否显示
            if (!self.barCodeCellDisplayType) {
                
                if (self.CodeNumberCellDisplay) {
                    
                    return self.originalNewbarCodeArr.count>0? self.originalNewbarCodeArr.count:0;
                }
            }
            
            return 0;
            break;
        case 3:
            
            if (self.barCodeCellDisplayType) {
                
                if (self.CodeNumberCellDisplay) {
                    
                    return self.oldBarCodeArr.count>0? self.oldBarCodeArr.count:0;
                }
            }
            
            return 0;
        case 4:
            if (self.ordersPhotoCellDisplay) {
                
                return 2;
            }
            return 0;
            break;
        case 5:
            
            if (self.selectServiceCellDisplay) {
                
                return self.storeServiceTypes.count>0?self.storeServiceTypes.count:0;

            }

            return 0;
            break;

        default:
            break;
    }
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            OrdersInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"freeChangAgainInfoCellID" forIndexPath:indexPath];
            
            if (self.ordersContentArr.count>0) {
                
                cell.contentLab.text = self.ordersContentArr[indexPath.row];
            }
            cell.titleLab.text = self.ordersTitleArr[indexPath.row];
            
            return cell;
        }
            break;

        case 1:{
            
            TiresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"freeChangAgainTiresCellID" forIndexPath:indexPath];
            
            TiresModel *model = [[TiresModel alloc] init];
            [model setValuesForKeysWithDictionary:self.tiresNumArr[indexPath.row]];
            [cell setTiresModel:model orderType:self.orderTypeStr];
            
            return cell;
        }
            
            break;
        case 2:{
            
            CodeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeCodeNumberCellID" forIndexPath:indexPath];
            cell.barCodeLab.text = [self.originalNewbarCodeArr[indexPath.row] objectForKey:@"barCode"];
            cell.statusButton.hidden = !self.switchHidden;
            
            return cell;
        }
            
            break;
        case 3:{
            
            FreeChangeAgainCodeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangeAgainCodeNumberCellID" forIndexPath:indexPath];

            cell.codeNumberLab.text = [self.oldBarCodeArr[indexPath.row] objectForKey:@"barCode"];
            
            cell.replaceBtn.tag = 10001000+indexPath.row;
            cell.deleCodeNumberBtn.tag = 10001001+indexPath.row;
            
            [cell.replaceBtn addTarget:self action:@selector(replaceButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.deleCodeNumberBtn addTarget:self action:@selector(removeCodeNumberWithRemoveReplaceButton:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
            break;
            
            break;
        case 4:{
         
            OrdersPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangAgainOrdersPhotoCellID" forIndexPath:indexPath];
            
            cell.titleLab.text = @[@"行驶证照片",@"车辆照片"][indexPath.row];
            [cell.exampleBtn addTarget:self action:@selector(pushPhotographExampleVC) forControlEvents:UIControlEventTouchUpInside];

            if (indexPath.row == 1) {
                [cell.exampleBtn setHidden:NO];
            }
            return cell;
        }
            break;
        case 5:{
            
            SelectServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreeChangAgainSelectServiceTypeCellID" forIndexPath:indexPath];
            
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
     
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"freeChangeAgainCellID" forIndexPath:indexPath];
    
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
            
            return 50;
            break;
        case 4:
            
            return 112;
            break;
        case 5:
            
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
        CodeNumheadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"freeCodeNumHeadViewID"];
        
        header.rigthTextHidden = !self.switchHidden;
        
        return header;
    }
    
    return [UIView new];
}


#pragma mark 懒加载
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
        
        [_tableView registerClass:[CodeNumheadView class] forHeaderFooterViewReuseIdentifier:@"freeCodeNumHeadViewID"];

        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"freeChangeAgainCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersInfoCell class]) bundle:nil] forCellReuseIdentifier:@"freeChangAgainInfoCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TiresCell class]) bundle:nil] forCellReuseIdentifier:@"freeChangAgainTiresCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CodeNumberCell class]) bundle:nil] forCellReuseIdentifier:@"FreeCodeNumberCellID"];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FreeChangeAgainCodeNumberCell class]) bundle:nil] forCellReuseIdentifier:@"FreeChangeAgainCodeNumberCellID"];

        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersPhotoCell class]) bundle:nil] forCellReuseIdentifier:@"FreeChangAgainOrdersPhotoCellID"];

        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectServiceCell class]) bundle:nil] forCellReuseIdentifier:@"FreeChangAgainSelectServiceTypeCellID"];

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

-(NSArray *)storeServiceTypes{
    
    if (!_storeServiceTypes) {
        
        _storeServiceTypes = @[@(StoreConfirmServiceType)];
    }
    return _storeServiceTypes;
}

-(NSMutableArray *)oldBarCodeArr{
    
    if (!_oldBarCodeArr) {
        
        _oldBarCodeArr = [NSMutableArray array];
    }
    return _oldBarCodeArr;
}


-(NSMutableArray *)newBarCodeArr{
    
    if (!_newBarCodeArr) {
        
        _newBarCodeArr = [NSMutableArray array];
    }
    return _newBarCodeArr;
}

-(NSMutableArray *)originalNewbarCodeArr{
    
    if (!_originalNewbarCodeArr) {
        
        _originalNewbarCodeArr = [NSMutableArray array];
    }
    
    
    return _originalNewbarCodeArr;
}
-(NSMutableArray *)freeChangeArr{
    
    if (!_freeChangeArr) {
        
        _freeChangeArr = [NSMutableArray array];
    }
    
    return _freeChangeArr;
}

#pragma mark 新条形码处理
-(NSArray *)replaceOldBarCodeWithNewBarCode:(NSMutableArray *)newBarCode{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i<newBarCode.count; i++) {
        
        [arr addObject:[newBarCode[i] objectForKey:@"barCode"]];
        
    }
    return arr;
}

#pragma mark 选择新条形码替换
- (void)replaceButtonEvent:(UIButton *)sender {
    
    YMStoreTypePickerView *store = [[YMStoreTypePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    store.codeNumberBlock = ^(NSString *codeNumber) {
        
        [sender setHidden:YES];
        
        FreeChangeAgainCodeNumberCell *cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag-10001000 inSection:3]];
        [cell newBarCodeHidden:NO];
        cell.replaceCodeNumberlab.text = codeNumber;
        
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:[NSString stringWithFormat:@"old%@",cell.codeNumberLab.text] forKey:@"oldBarCode"];
        
        [dic setObject:[NSString stringWithFormat:@"new%@",codeNumber] forKey:@"newBarCode"];
        [self.freeChangeArr addObject:dic];
        
        if (self.newBarCodeArr.count) {
            //条形码只允许选择一次，被当前的选择使用掉了，其他的不允许在选择
            [self.newBarCodeArr removeObject:codeNumber];
            
        }
  
    };
    
    store.typeArr = self.newBarCodeArr;
    store.status = @"1";
    [store show];
    
}

#pragma mark 删除新条形码
-(void)removeCodeNumberWithRemoveReplaceButton:(UIButton *)button{
    
    FreeChangeAgainCodeNumberCell *cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:button.tag-10001001 inSection:3]];
    [cell newBarCodeHidden:YES];
    cell.replaceBtn.hidden = NO;
    
    
    [self.freeChangeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([[obj objectForKey:@"oldBarCode"] isEqualToString:[NSString stringWithFormat:@"old%@",cell.codeNumberLab.text]]) {
            
            [self.freeChangeArr removeObject:obj];
            
            *stop = YES;
        }
    }];
    
    //新条形码被删除后，要放到可选择的数组里，让其他条目可以继续选择此条形码
    [self.newBarCodeArr addObject:cell.replaceCodeNumberlab.text];
}

- (void)selelctServiceType:(UIButton *)sender {
    
    if (!self.orderTypeStr&&self.orderTypeStr.length<=0) {
        [MBProgressHUD showTextMessage:@"订单信息获取失败！"];
        return;
    }
    
    StoreServiceType serviceType;
    if ([sender.titleLabel.text isEqualToString:@"确认服务"]) {
        serviceType = StoreConfirmServiceType;
    }else{
        serviceType = 1;
    }
    
    if (self.freeChangeArr.count != self.newTireNumber) {
        
        [MBProgressHUD showTextMessage:@"请选择足够的需要更换轮胎！"];
        return;
    }
    
    OrdersPhotoCell *DrivingLicenseCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    
    if (DrivingLicenseCell.selectPhotoBen.imageView.image == nil) {
        
        [MBProgressHUD showTextMessage:@"请选择行驶证照片！"];
        
        return;
    }
    
    
    OrdersPhotoCell *carCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:4]];
    
    if (carCell.selectPhotoBen.imageView.image == nil) {
        
        [MBProgressHUD showTextMessage:@"请选择车辆照片！"];
        return;
    }
    
    float imgCompressionQuality = 0.3;//图片压缩比例
    
    NSData *drivingLicenseImgData=UIImageJPEGRepresentation(DrivingLicenseCell.selectPhotoBen.imageView.image, imgCompressionQuality);
    
    NSData *carImgData=UIImageJPEGRepresentation(carCell.selectPhotoBen.imageView.image,  imgCompressionQuality);
    
    NSArray <JJFileParam *> *photoArr=@[
                                   [JJFileParam fileConfigWithfileData:drivingLicenseImgData name:@"drivingLicenseImg" fileName:@"xingshizheng.png" mimeType:@"image/jpg/png/jpeg"],
                                   [JJFileParam fileConfigWithfileData:carImgData name:@"carImg" fileName:@"cheliang.png" mimeType:@"image/jpg/png/jpeg"]
                                   ];
    
    [MainOrdersRequest
     freeChangeServiceTypeWithInfo:@{
                                @"orderNo":self.ordersContentArr[5],
                                @"serviceType":[NSString stringWithFormat:@"%ld",serviceType],
                                @"orderType":self.orderTypeStr
                                }
     changeBarCodeVoList:self.freeChangeArr
     
     photos:photoArr
     
     succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
         
         [self.navigationController popViewControllerAnimated:YES];
         self.popOrdersVCBlock(YES);
         
     } failure:^(NSError * _Nullable error) {
         
     }];
    NSLog(@"%@   %@",self.orderTypeStr,self.ordersContentArr[5]);
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
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    
    NSMutableArray *newArr = [NSMutableArray array];
    
    if (newArr.count>0) {
        
        [newArr removeAllObjects];
    }
    
    CodeNumberCell *cell;
    
    for (int i = 0; i<self.originalNewbarCodeArr.count; i++) {
        
        
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        
        dic = self.originalNewbarCodeArr[i];
        
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
    [MainOrdersRequest submitStoreConfirmReceiptShoesWithInfo:newArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [self.navigationController popViewControllerAnimated:YES];
        self.popOrdersVCBlock(YES);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
