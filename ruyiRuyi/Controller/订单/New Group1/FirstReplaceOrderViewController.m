//
//  FirstReplaceOrderViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstReplaceOrderViewController.h"
#import <Masonry.h>
#import "YMRequest.h"
#import "CustomizeExampleViewController.h"
#import "OrdersViewController.h"
#import "FirstOrderSelectCodeViewController.h"

#import "FirstOrderInfoView.h"
#import "FirstOrderTyreInfoView.h"
#import "FirstOrderCodeView.h"
#import "FirstOrderCodeSelectView.h"
#import "FirstOrderSelectServiceTypeView.h"
#import "FirstOrderPhotoView.h"

#import "FirstReplaceOrderModel.h"
#import "SaoMaShouHuoController.h"

@interface FirstReplaceOrderViewController ()<FirstOrderSelectServiceTypeViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) FirstOrderInfoView *infoView;
@property (nonatomic, strong) FirstOrderTyreInfoView *tyreInfoView;
@property (nonatomic, strong) FirstOrderCodeView *codeView;
@property (nonatomic, strong) FirstOrderCodeSelectView *codeSelectView;
@property (nonatomic, strong) FirstOrderPhotoView *photoView;
@property (nonatomic, strong) FirstOrderSelectServiceTypeView *selectServiceTypeView;

@property (nonatomic, strong) FirstReplaceOrderModel *frOrderModel;

///底部确认button  是否可以编辑 显示的title
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, assign,getter=isButtonEnabled) BOOL buttonEnabled;
@property (nonatomic, copy) NSString *buttonTitle;

@property(nonatomic, assign) BOOL switchHidden;///是否显示比较条形码
@property(nonatomic,assign)BOOL codeNumberCellDisplay;///条形码是否显示
@property(nonatomic,assign)BOOL selectCodeDisplay;///选择条形码视图是否显示

@property (nonatomic, assign) orderState orderState;

@property (nonatomic, assign) BOOL isYiZhi; ///前后轮是否一致
@property (nonatomic, copy) NSString *font_shoe_id;///前轮id
@property (nonatomic, copy) NSString *rear_shoe_id ;///后轮id

@property (nonatomic, strong) NSMutableArray *frontCodeArray;///前轮数据
@property (nonatomic, strong) NSMutableArray *rearCodeArray;///后轮数据

@property (nonatomic, assign) NSInteger frontMaxCount;
@property (nonatomic, assign) NSInteger rearMaxCount;

@property (nonatomic, assign) NSInteger taskCount;

@end

@implementation FirstReplaceOrderViewController

@synthesize popOrdersVCBlock = _popOrdersVCBlock;

///单条轮胎详情高度
static NSInteger const tyreInfoViewCellHeight = 150;
///单条条形码高度
static NSInteger const codeViewCellHeight = 44;
/////单条选择条形码高度
static NSInteger const selectCodeViewCellHeight = 44;

/**
 * 默认初始化方法
 */
-(instancetype)initWithOrdersStatus:(orderState )orderState{
    self = [super init];
    if (self) {
        
        self.orderState = orderState;
        
        self.switchHidden = NO;// 默认隐藏 条形码对比
        self.codeNumberCellDisplay = NO;//条形码cell是否显示，默认隐藏
        self.selectCodeDisplay = NO;//默认隐藏
        self.taskCount = 0;
        
        switch (orderState) {
            case ordersStateFulfill:
                
                self.buttonTitle = @"交易完成";
                self.buttonEnabled = NO;
                self.codeNumberCellDisplay = YES;
                
                break;
            case ordersStateWaitReceipt:
                
                self.buttonTitle = @"确认收货";
                self.switchHidden = YES;
                self.codeNumberCellDisplay = YES;
                
                break;
            case ordersStateWaitConfirm:
                
                self.buttonTitle = @"确认服务";
                self.selectCodeDisplay = YES;
                break;
            case ordersStateInvalid:
                
                self.buttonTitle = @"作废";
                self.buttonEnabled = NO;
                self.codeNumberCellDisplay = YES;
                
                break;
            case ordersStateWaitShip:
                
                self.buttonEnabled = NO;
                self.buttonTitle = @"待发货";
                break;
            case ordersStateWaitOwnerConfirmation:
                
                self.buttonTitle = @"待车主确认服务";
                self.buttonEnabled = NO;
                self.codeNumberCellDisplay = YES;
                
                break;
            case ordersStateWaitAssess:
                
                self.buttonTitle = @"待评价";
                self.buttonEnabled = NO;
                self.codeNumberCellDisplay = YES;
                
                break;
            case ordersStateWaitPay:
                
                self.buttonTitle = @"待支付";
                self.buttonEnabled = NO;
                break;
            case ordersStateRefuseService:
                
                self.buttonTitle = @"已取消";
                self.buttonEnabled = NO;
                break;
            case ordersStateUserCanceled:
                self.buttonTitle = @"用户已取消";
                self.buttonEnabled = NO;
                break;
            default:
                break;
        }
    }
    return self;
}
- (void)selectCodeNotice:(NSNotification *)notice{
    
    NSDictionary *selectInfo = notice.object;
    
    if (self.isYiZhi) {
        self.codeSelectView.frontCodeArray = selectInfo[@"selectArray"];
    }else{
        
        if ([selectInfo[@"type"] isEqualToString:@"front"]) {
            
            self.codeSelectView.frontCodeArray = selectInfo[@"selectArray"];
        }
        if ([selectInfo[@"type"] isEqualToString:@"rear"]) {
            
            self.codeSelectView.rearCodeArray = selectInfo[@"selectArray"];
        }
    }
    
    [self.codeSelectView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (self.isYiZhi) {
            make.height.mas_equalTo(selectCodeViewCellHeight + selectCodeViewCellHeight * self.codeSelectView.frontCodeArray.count + selectCodeViewCellHeight * self.codeSelectView.rearCodeArray.count);
        }else{
            if (self.font_shoe_id && self.rear_shoe_id) {
                make.height.mas_equalTo(selectCodeViewCellHeight*2 + selectCodeViewCellHeight * self.codeSelectView.frontCodeArray.count + selectCodeViewCellHeight * self.codeSelectView.rearCodeArray.count);
            }else{
                make.height.mas_equalTo(selectCodeViewCellHeight + selectCodeViewCellHeight * self.codeSelectView.frontCodeArray.count + selectCodeViewCellHeight * self.codeSelectView.rearCodeArray.count);
            }
        }
    }];
    
    [self.codeSelectView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCodeNotice:) name:@"firstOrderSelectCodeNotice" object:nil];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.infoView];
    
    [self.scrollView addSubview:self.tyreInfoView];
    
    if (self.codeNumberCellDisplay) {
        [self.scrollView addSubview:self.codeView];
    }
    
    if (self.selectCodeDisplay) {
        [self.scrollView addSubview:self.codeSelectView];
    }
    
    if (self.orderState == ordersStateWaitConfirm) {
        [self.scrollView addSubview:self.photoView];
        [self.scrollView addSubview:self.selectServiceTypeView];
    }else{
        [self.scrollView addSubview:self.submitBtn];
    }
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        if (self.orderState == ordersStateWaitConfirm) {
            make.bottom.mas_equalTo(self.selectServiceTypeView.mas_bottom);
        }else{
            make.bottom.mas_equalTo(self.submitBtn.mas_bottom);
        }
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@270);
    }];
    
    [self.tyreInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoView.mas_bottom).inset(5);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(tyreInfoViewCellHeight);
    }];
    
    if (self.codeNumberCellDisplay) {
        [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tyreInfoView.mas_bottom).inset(5);
            make.leading.trailing.mas_equalTo(self.view);
            make.height.mas_equalTo(codeViewCellHeight);
        }];
    }
    
    if (self.selectCodeDisplay) {
        [self.codeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.codeNumberCellDisplay) {
                make.top.mas_equalTo(self.codeView.mas_bottom).inset(5);
            }else{
                make.top.mas_equalTo(self.tyreInfoView.mas_bottom).inset(5);
            }
            make.leading.trailing.mas_equalTo(self.view);
            make.height.mas_equalTo(selectCodeViewCellHeight);
        }];
    }
    
    if (self.orderState == ordersStateWaitConfirm) {
        [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.selectCodeDisplay) {
                make.top.mas_equalTo(self.codeSelectView.mas_bottom).inset(5);
            }else if(self.codeNumberCellDisplay){
                make.top.mas_equalTo(self.codeView.mas_bottom).inset(5);
            }else{
                make.top.mas_equalTo(self.tyreInfoView.mas_bottom).inset(5);
            }
            make.leading.trailing.mas_equalTo(self.view);
            make.height.mas_equalTo(@120);
        }];
        [self.selectServiceTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.photoView.mas_bottom).inset(5);
            make.leading.trailing.mas_equalTo(self.view);
            make.height.mas_equalTo(@120);
        }];
    }else{
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.selectCodeDisplay) {
                make.top.mas_equalTo(self.codeSelectView.mas_bottom).inset(15);
            }else if(self.codeNumberCellDisplay){
                make.top.mas_equalTo(self.codeView.mas_bottom).inset(15);
            }else{
                make.top.mas_equalTo(self.tyreInfoView.mas_bottom).inset(15);
            }
            make.leading.trailing.mas_equalTo(self.view).inset(16);
            make.height.mas_equalTo(@44);
        }];
    }
}

///获取信息
-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    [super getOrdersInfo:orderNo orderType:orderType storeId:storeId];
    
    if (self.selectCodeDisplay) {
        
        [[YMRequest sharedManager] GET:[NSString stringWithFormat:@"%@order/getShoeIdByOrderNo",YMBaseUrl] parameters:@{@"orderNo":orderNo} progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                self.frOrderModel = [FirstReplaceOrderModel mj_objectWithKeyValues:responseObject];
                
                for (FirstReplaceMapModel *map in self.frOrderModel.mapList) {
                    
                    NSInteger type = [map.font_rear_flag integerValue];
                    
                    if (type == 0) {///前后轮一致  则轮胎id都一样
                        self.isYiZhi = YES;
                        self.font_shoe_id = map.font_shoe_id;
                    }else if (type == 1){///前后轮不一致咋 所有的前轮id一样 所有的后轮id一样
                        self.isYiZhi = NO;
                        self.font_shoe_id = map.font_shoe_id;
                    }else if (type == 2){
                        self.isYiZhi = NO;
                        self.rear_shoe_id = map.rear_shoe_id;
                    }
                }
                self.codeSelectView.isYiZhi = self.isYiZhi;
                
                //                if (self.isYiZhi) {///前后轮一致  只显示前轮
                //                    [self getTyreCodeInfo:1 storeId:storeId shoeID:self.font_shoe_id];
                //                }else{///前后轮不一致
                if (self.font_shoe_id && self.rear_shoe_id) {//前后轮都有 两组
                    [self.codeSelectView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(selectCodeViewCellHeight*2);
                    }];
                }
                
                //                    if (self.font_shoe_id) {
                //                        [self getTyreCodeInfo:1 storeId:storeId shoeID:self.font_shoe_id];
                //                    }
                //                    if (self.rear_shoe_id) {
                //                        [self getTyreCodeInfo:2 storeId:storeId shoeID:self.rear_shoe_id];
                //                    }
                //                }
                [self.codeSelectView reload];
                
                if (self.frOrderModel.boolean == YES) {
                    if ([self.scrollView.subviews containsObject:self.photoView]) {
                        [self.photoView removeFromSuperview];
                        self.photoView = nil;
                    }
                    if ([self.scrollView.subviews containsObject:self.selectServiceTypeView]) {
                        [self.selectServiceTypeView removeFromSuperview];
                        self.selectServiceTypeView = nil;
                    }
                    
                    self.submitBtn.enabled = YES;
                    [self.submitBtn setBackgroundColor:JJThemeColor];
                    [self.submitBtn setTitle:@"补货" forState:UIControlStateNormal];
                    [self.scrollView addSubview:self.submitBtn];
                    
                    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        if (self.selectCodeDisplay) {
                            make.top.mas_equalTo(self.codeSelectView.mas_bottom).inset(15);
                        }else if(self.codeNumberCellDisplay){
                            make.top.mas_equalTo(self.codeView.mas_bottom).inset(15);
                        }else{
                            make.top.mas_equalTo(self.tyreInfoView.mas_bottom).inset(15);
                        }
                        make.leading.trailing.mas_equalTo(self.view).inset(16);
                        make.height.mas_equalTo(@44);
                    }];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        //        [[YMRequest sharedManager] getRequest:@"order/getShoeIdByOrderNo" params:@{@"orderNo":orderNo} success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        //
        //            if (code == 1) {
        //
        //                for (NSDictionary *dic in data) {
        //
        //                    NSInteger type = [dic[@"font_rear_flag"] integerValue];
        //
        //                    if (type == 0) {///前后轮一致  则轮胎id都一样
        //                        self.isYiZhi = YES;
        //                        self.font_shoe_id = dic[@"font_shoe_id"];
        //                    }else if (type == 1){///前后轮不一致咋 所有的前轮id一样 所有的后轮id一样
        //                        self.isYiZhi = NO;
        //                        self.font_shoe_id = dic[@"font_shoe_id"];
        //                    }else if (type == 2){
        //                        self.isYiZhi = NO;
        //                        self.rear_shoe_id = dic[@"rear_shoe_id"];
        //                    }
        //                }
        //
        //                self.codeSelectView.isYiZhi = self.isYiZhi;
        //            }
        //            if (self.isYiZhi) {///前后轮一致  只显示前轮
        //                [self getTyreCodeInfo:1 storeId:storeId shoeID:self.font_shoe_id];
        //            }else{///前后轮不一致
        //                if (self.font_shoe_id && self.rear_shoe_id) {//前后轮都有 两组
        //                    [self.codeSelectView mas_updateConstraints:^(MASConstraintMaker *make) {
        //                        make.height.mas_equalTo(selectCodeViewCellHeight*2);
        //                    }];
        //                }
        //
        //                if (self.font_shoe_id) {
        //                    [self getTyreCodeInfo:1 storeId:storeId shoeID:self.font_shoe_id];
        //                }
        //                if (self.rear_shoe_id) {
        //                    [self getTyreCodeInfo:2 storeId:storeId shoeID:self.rear_shoe_id];
        //                }
        //            }
        //            [self.codeSelectView reload];
        //
        //        } failure:^(NSError * _Nullable error) {
        //            [MBProgressHUD hideWaitViewAnimated:self.view];
        //        }];
    }
    
    [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
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
        
        self.infoView.nameLab.text          = [data objectForKey:@"userName"];
        self.infoView.phoneLab.text         = [data objectForKey:@"userPhone"];
        self.infoView.carCodeLab.text       = [data objectForKey:@"platNumber"];
        self.infoView.storeNameLab.text     = [data objectForKey:@"storeName"];
        self.infoView.orderTypeLab.text     = orderTypeText;
        self.infoView.orderNumberLab.text   = [data objectForKey:@"orderNo"];
        
        if ([data objectForKey:@"firstChangeOrderVoList"] == [NSNull null]) {
            
        }else{
            
            self.tyreInfoView.tiresNumArr = [TiresModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"firstChangeOrderVoList"]];
            
            for (TiresModel *model in self.tyreInfoView.tiresNumArr) {
                if ([model.fontRearFlag longLongValue] == 0 || [model.fontRearFlag longLongValue] == 1) {
                    self.frontMaxCount = [model.fontAmount integerValue];
                }else{
                    self.rearMaxCount = [model.rearAmount integerValue];
                }
            }
            
            if (self.tyreInfoView.tiresNumArr) {
                [self.tyreInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(self.tyreInfoView.tiresNumArr.count * tyreInfoViewCellHeight);
                }];
            }
        }
        
        if (self.codeNumberCellDisplay) {
            self.codeView.codeNumArr = [data objectForKey:@"userCarShoeBarCodeList"];
            self.codeView.switchHidden = self.switchHidden;
            
            [self.codeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(codeViewCellHeight + codeViewCellHeight * self.codeView.codeNumArr.count);
            }];
        }
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (void)FirstOrderSelectServiceTypeView:(FirstOrderSelectServiceTypeView *)serviceView serviceType:(StoreServiceType )type{
    
    if (type == StoreConfirmServiceType || type == clientSelfHelpServiceType) {
        if (!self.photoView.photoImgView.image) {
            [MBProgressHUD showTextMessage:@"请先选择照片！"];
            return;
        }
        if (self.codeSelectView.frontCodeArray.count <=0 && self.codeSelectView.rearCodeArray.count <= 0) {
            [MBProgressHUD showTextMessage:@"请先选择条形码！"];
            return;
        }
    }else{
        
    }

    [self verificationCode:type];
}


- (void)verificationCode:(StoreServiceType )serviceType{
    
    [MBProgressHUD showWaitMessage:@"正在提交..." showView:self.view];
    NSMutableArray *params = [NSMutableArray array];
    
    [params addObjectsFromArray:self.codeSelectView.frontCodeArray];
    [params addObjectsFromArray:self.codeSelectView.rearCodeArray];
    
    //设置参数 根据你们服务器的格式设置。我们的后台需要传的是json格式的
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted  error:nil];
    
    [[YMRequest sharedManager].requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableURLRequest *request = [[YMRequest sharedManager].requestSerializer requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@order/isTrueBarcode",YMBaseUrl] parameters:nil error:nil];
    
    [request setHTTPBody:jsonData];
    
    [[[YMRequest sharedManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil
                                  completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
        if(responseObject!=nil){
            if ([responseObject[@"status"] integerValue] == 1) {
                ///验证条形码成功
                
                [self serviceAction:serviceType];
            }else{
                [MBProgressHUD hideWaitViewAnimated:self.view];
                [MBProgressHUD showTextMessage:responseObject[@"msg"]];
            }
        }else{
            [MBProgressHUD hideWaitViewAnimated:self.view];
        }
    }]resume];
}


- (void)serviceAction:(StoreServiceType )serviceType{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *serviceTypeString = @"";
    
    [params setObject:self.orderNO forKey:@"orderNo"];
    [params setObject:@"" forKey:@"orderType"];
    [params setObject:[UserConfig storeID] forKey:@"storeId"];
    
    switch (serviceType) {
        case StoreRefuseServiceType:
            serviceTypeString = @"3";
            break;
        case StoreConfirmServiceType:
            serviceTypeString = @"1";
            
            break;
        case clientSelfHelpServiceType:
            serviceTypeString = @"2";
            break;
        default:
            break;
    }
    
    if (serviceType == StoreConfirmServiceType || serviceType == clientSelfHelpServiceType) {
        
        if (self.isYiZhi) {
            
            [params setObject:[NSString stringWithFormat:@"%ld",(long)self.frontMaxCount] forKey:@"num"];
            
            for (int i = 0; i < self.frontMaxCount; i++) {
                NSString *barCode = self.codeSelectView.frontCodeArray[i];
                [params setObject:barCode forKey:[NSString stringWithFormat:@"barcode%d",i+1]];
                [params setObject:self.font_shoe_id forKey:[NSString stringWithFormat:@"shoeId%d",i+1]];
                [params setObject:@"0" forKey:[NSString stringWithFormat:@"fontRearFlag%d",i+1]];
            }
        }else{
            if (self.frontMaxCount == 1) {
                NSString *barCode = self.codeSelectView.frontCodeArray[0];
                
                [params setObject:barCode forKey:@"barcode1"];
                [params setObject:self.font_shoe_id forKey:@"shoeId1"];
                [params setObject:@"1" forKey:@"fontRearFlag1"];
            }
            if (self.frontMaxCount == 2) {
                
                NSString *barCode = self.codeSelectView.frontCodeArray[0];
                [params setObject:barCode forKey:@"barcode1"];
                [params setObject:self.font_shoe_id forKey:@"shoeId1"];
                [params setObject:@"1" forKey:@"fontRearFlag1"];
                
                NSString *barCode1 = self.codeSelectView.frontCodeArray[1];
                [params setObject:barCode1 forKey:@"barcode2"];
                [params setObject:self.font_shoe_id forKey:@"shoeId2"];
                [params setObject:@"1" forKey:@"fontRearFlag2"];
            }
            
            if (self.rearMaxCount == 1) {
                NSString *barCode = self.codeSelectView.rearCodeArray[0];
                
                [params setObject:barCode forKey:@"barcode3"];
                [params setObject:self.rear_shoe_id forKey:@"shoeId3"];
                [params setObject:@"2" forKey:@"fontRearFlag3"];
            }
            if (self.rearMaxCount == 2) {
                
                NSString *barCode = self.codeSelectView.rearCodeArray[0];
                [params setObject:barCode forKey:@"barcode3"];
                [params setObject:self.rear_shoe_id forKey:@"shoeId3"];
                [params setObject:@"2" forKey:@"fontRearFlag3"];
                
                NSString *barCode1 = self.codeSelectView.rearCodeArray[1];
                [params setObject:barCode1 forKey:@"barcode4"];
                [params setObject:self.rear_shoe_id forKey:@"shoeId4"];
                [params setObject:@"2" forKey:@"fontRearFlag4"];
            }
        }
    }else{
        
    }
    
    [params setObject:serviceTypeString forKey:@"serviceType"];
    
    float imgCompressionQuality = 0.5;//图片压缩比例
    NSData *photoData =UIImageJPEGRepresentation(self.photoView.photoImgView.image, imgCompressionQuality);
    
    JJFileParam *photoParam = [JJFileParam fileConfigWithfileData:photoData name:@"carImg" fileName:@"xingshizheng.png" mimeType:@"image/jpg/png/jpeg"];
    
    [[YMRequest sharedManager] POST:[NSString stringWithFormat:@"%@/storeSelectFirstChangeShoeOrderTypeNew",RuYiRuYiIP] parameters:@{@"reqJson":[JJTools convertToJsonData:params]} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:photoParam.fileData name:photoParam.name fileName:photoParam.fileName mimeType:photoParam.mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            self.popOrdersVCBlock(YES);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showTextMessage:@"提交失败！"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        [MBProgressHUD showTextMessage:@"服务错误！"];
    }];
}

-(void)submitOrderInfoEvent{
    
    if (self.orderState == ordersStateWaitConfirm) {
        
        
        NSDictionary *parameters= self.frOrderModel.orderDTO;
        
        //设置参数 根据你们服务器的格式设置。我们的后台需要传的是json格式的
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                           options:NSJSONWritingPrettyPrinted  error:nil];
        
        [[YMRequest sharedManager].requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
        NSMutableURLRequest *request = [[YMRequest sharedManager].requestSerializer requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@order/commitOrderMinusMoney",YMBaseUrl] parameters:nil error:nil];
        
        [request setHTTPBody:jsonData];
        
        [[[YMRequest sharedManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil
                                      completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
            if(responseObject!=nil){
                if ([responseObject[@"status"] integerValue] == 1) {
                    [MBProgressHUD showTextMessage:@"提交补货成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [MBProgressHUD showTextMessage:responseObject[@"msg"]];
                }
            }
        }]resume];
    }
    
    ///旧版本 已废弃
    //    NSDictionary *dic = [[NSDictionary alloc] init];
    //
    //    NSMutableArray *newArr = [NSMutableArray array];
    //
    //    if (newArr.count>0) {
    //
    //        [newArr removeAllObjects];
    //    }
    
    //    CodeNumberCell *cell;
    //
    //    for (int i = 0; i<self.originalNewbarCodeArr.count; i++) {
    //
    //
    //        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
    //
    //        dic = self.originalNewbarCodeArr[i];
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
    
    //        [newDic setObject:[dic objectForKey:@"barCode"] forKey:@"barCode"];
    //        [newDic setObject:[dic objectForKey:@"id"] forKey:@"id"];
    //        [newDic setObject:[dic objectForKey:@"orderNo"] forKey:@"orderNo"];
    //
    //        [newArr addObject:newDic];
    //    }
    //    NSLog(@"新的数组：%@",newArr);
    //    [MBProgressHUD showWaitMessage:@"正在处理.." showView:self.view];
    //
    //    [MainOrdersRequest submitStoreConfirmReceiptShoesWithInfo:newArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    //
    //        [MBProgressHUD hideWaitViewAnimated:self.view];
    //        [self.navigationController popViewControllerAnimated:YES];
    //        self.popOrdersVCBlock(YES);
    //
    //    } failure:^(NSError * _Nullable error) {
    //
    //    }];
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (FirstOrderInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[FirstOrderInfoView alloc] init];
    }
    return _infoView;
}
- (FirstOrderCodeView *)codeView{
    if (!_codeView) {
        _codeView = [[FirstOrderCodeView alloc] init];
    }
    return _codeView;
}
- (FirstOrderTyreInfoView *)tyreInfoView{
    if (!_tyreInfoView) {
        _tyreInfoView = [[FirstOrderTyreInfoView alloc] init];
    }
    return _tyreInfoView;
}
- (FirstOrderPhotoView *)photoView{
    if (!_photoView) {
        _photoView = [[FirstOrderPhotoView alloc] init];
    }
    return _photoView;
}
- (FirstOrderSelectServiceTypeView *)selectServiceTypeView{
    if (!_selectServiceTypeView) {
        _selectServiceTypeView = [[FirstOrderSelectServiceTypeView alloc] init];
        _selectServiceTypeView.delegate = self;
    }
    return _selectServiceTypeView;
}
- (FirstOrderCodeSelectView *)codeSelectView{
    if (!_codeSelectView) {
        JJWeakSelf;
        _codeSelectView = [[FirstOrderCodeSelectView alloc] init];
        
        _codeSelectView.showBlock = ^(NSInteger section) {
            
            
            SaoMaShouHuoController *vc = [[SaoMaShouHuoController alloc] init];
            
            if (section == 0) {
                
                if (weakSelf.isYiZhi) {
                    vc.goodsCount = weakSelf.frontMaxCount;
                    vc.type = @"front";
                }else{
                    
                    if (weakSelf.frontMaxCount <= 0) {
                        vc.goodsCount = weakSelf.rearMaxCount;
                        vc.type = @"rear";
                    }else{
                        vc.goodsCount = weakSelf.frontMaxCount;
                        vc.type = @"front";
                    }
                }
            }else{///前后轮一致 没有section 只有0没有更多  不一致 section > 0 则 依然显示后轮
                vc.goodsCount = weakSelf.rearMaxCount;
                vc.type = @"rear";
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
            weakSelf.hidesBottomBarWhenPushed = YES;
            //
            //            FirstOrderSelectCodeViewController *vc = [[FirstOrderSelectCodeViewController alloc] init];
            //            vc.view.backgroundColor         = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            //            vc.modalPresentationStyle       = UIModalPresentationOverCurrentContext;
            //            vc.definesPresentationContext   = YES; //self is presenting view controller
            //
            //            if (section == 0) {
            //
            //                if (weakSelf.isYiZhi) {
            //
            //                    vc.codeArray = weakSelf.frontCodeArray;
            //                    vc.maxSelectCout = weakSelf.frontMaxCount;
            //                    vc.type = @"front";
            //                }else{
            //
            //                    if (!weakSelf.frontCodeArray) {
            //                        vc.codeArray = weakSelf.rearCodeArray;
            //                        vc.maxSelectCout = weakSelf.rearMaxCount;
            //                        vc.type = @"rear";
            //                    }else{
            //                        vc.codeArray = weakSelf.frontCodeArray;
            //                        vc.maxSelectCout = weakSelf.frontMaxCount;
            //                        vc.type = @"front";
            //                    }
            //                }
            //            }else{///前后轮一致 没有section 只有0没有更多  不一致 section > 0 则 依然显示后轮
            //                vc.codeArray = weakSelf.rearCodeArray;
            //                vc.maxSelectCout = weakSelf.rearMaxCount;
            //                vc.type = @"rear";
            //            }
            //            [weakSelf presentViewController:vc animated:NO completion:nil];
        };
    }
    return _codeSelectView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setEnabled:self.buttonEnabled];
        [_submitBtn setTitle:self.buttonTitle forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitOrderInfoEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:self.buttonTitle forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _submitBtn.layer.cornerRadius = 22.f;
        _submitBtn.layer.masksToBounds = YES;
        if (self.isButtonEnabled) {
            [_submitBtn setBackgroundColor:JJThemeColor];
        }else{
            [_submitBtn setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    return _submitBtn;
}
- (FirstReplaceOrderModel *)frOrderModel{
    if (!_frOrderModel) {
        _frOrderModel = [FirstReplaceOrderModel model];
    }
    return _frOrderModel;
}
@end
