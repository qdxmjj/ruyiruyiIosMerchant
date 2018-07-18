//
//  ShopDetailsViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/11.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopDetailsViewController.h"
#import "ShopInfoCell.h"
#import "ShopItemCell.h"
#import "photoCell.h"
#import "ShopInfoRequest.h"

#import "EnrollmentRequestData.h"
#import "YMDatePickerView.h"
#import "MyShopModel.h"
#import "ShopPhotoView.h"
@interface ShopDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSArray *shopItemCellArr;//合作项目的数据源

@property(nonatomic,strong)MyShopModel *shopModel;//我的店铺信息数据源

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *bottomBtn;

@property(nonatomic,strong)NSMutableArray *bottomImgArr;

@property(nonatomic,strong)ShopPhotoView *shopPhotoView;
@end

@implementation ShopDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:self.tableView];
    [self getShopInfoList];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom).inset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.view.mas_bottom).inset(5);
        make.left.mas_equalTo(self.view.mas_left).inset(10);
        make.right.mas_equalTo(self.view.mas_right).inset(10);
        make.height.mas_equalTo(40);
    }];
}


//更新商家信息
-(void)UploadDataToServer{
    
    ShopItemCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    ShopInfoCell *infoCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    BOOL ison = infoCell.operateSwitch.isOn;
    
    NSString *status ;
    if (ison) {
        
        status = @"1";
        
    }else{
        
        status = @"2";
    }
    
    NSString *startTime;NSString *endTime;
    
    NSArray *array = [infoCell.storeTimeBtn.titleLabel.text componentsSeparatedByString:@"至"];
    startTime = [NSString stringWithFormat:@"2000-01-01T %@.000+0800",array[0]];
    endTime = [NSString stringWithFormat:@"2000-01-01T %@.000+0800",array[1]];
    
    if (self.shopPhotoView.location_img == nil) {
        
        [MBProgressHUD showTextMessage:@"请选择门头照片！"];
        return;
    }
    
    if (self.shopPhotoView.indoor_img == nil) {
        
        [MBProgressHUD showTextMessage:@"请选择店内照片！"];
        return;
    }
    
    if (self.shopPhotoView.factory_img == nil) {
        
        [MBProgressHUD showTextMessage:@"请选择车间照片！"];
        return;
    }
    
    float imgCompressionQuality = 0.3;//图片压缩比例
    NSData *licenseData=UIImageJPEGRepresentation(self.shopPhotoView.location_img, imgCompressionQuality);
    NSData *storeData=UIImageJPEGRepresentation(self.shopPhotoView.indoor_img, imgCompressionQuality);
    NSData *storeData1=UIImageJPEGRepresentation(self.shopPhotoView.factory_img, imgCompressionQuality);
    
    NSArray <JJFileParam *> *photos=@[
                                   [JJFileParam fileConfigWithfileData:licenseData name:@"location_img" fileName:@"location_img.png" mimeType:@"image/jpg/png/jpeg"],
                                   [JJFileParam fileConfigWithfileData:storeData name:@"indoor_img" fileName:@"indoor_img.png" mimeType:@"image/jpg/png/jpeg"],
                                   [JJFileParam fileConfigWithfileData:storeData1 name:@"factory_img" fileName:@"factory_img.png" mimeType:@"image/jpg/png/jpeg"],
                                   ];
    
    [ShopInfoRequest updateStoreInfoWithInfo:@{@"id":[UserConfig storeID],
                                               @"phone":[UserConfig phone],
                                               @"status":status,
                                               @"startTime":startTime,
                                               @"endTime":endTime
                                               } serviceTypes:[cell.selelItems componentsJoinedByString:@","] photos:photos succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                                                   
                                                   [MBProgressHUD showTextMessage:@"修改成功"];
                                                   [self.navigationController popViewControllerAnimated:YES];
                                                   
                                               } failure:^(NSError * _Nullable error) {
                                                   
                                               }];
}


-(void)getShopInfoList{
    
    self.shopItemCellArr = @[];
    //请求商家信息
    [ShopInfoRequest getShopInfoWithInfo:@{@"storeId":[UserConfig storeID]} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [self.shopModel setValuesForKeysWithDictionary:data];

        [self.bottomImgArr addObject:self.shopModel.locationImgUrl];
        [self.bottomImgArr addObject:self.shopModel.indoorImgUrl];
        [self.bottomImgArr addObject:self.shopModel.factoryImgUrl];
        
        self.shopPhotoView.imgUrlArr = self.bottomImgArr;
        
        [self.tableView reloadData];
        
        //请求服务项目
        [EnrollmentRequestData getStoreServiceTypeWithSuccrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            self.shopItemCellArr = data;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:(UITableViewRowAnimationNone)];
            
        } failure:^(NSError * _Nullable error) {
            
        }];

    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            ShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopInfoCellID" forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.storeNameLab.text = self.shopModel.storeName;
            cell.storeTypeLab.text = self.shopModel.storeType;
            cell.operateSwitch.on = self.shopModel.isBusiness;
            [cell.storeTimeBtn setTitle:self.shopModel.storeTime forState:UIControlStateNormal];
            cell.storeCityLab.text = self.shopModel.storeLocation;
            cell.storeLocationLab.text = self.shopModel.storeAddress;
            cell.storePhoneLab.text = self.shopModel.storeTEL;
            return cell;
        }
            break;
            
        case 1:
        {
            ShopItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopItemCellID" forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.shopItemArr =self.shopItemCellArr;
            NSArray *arr = self.shopModel.storeServcieList;
            cell.defaultSelectItems =  arr;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assessCellID"];
    
    
    return cell;
}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 360.f;
            
            break;
        case 1:
            
            return 120.f;
            break;
            
        default:
            
            return 1.f;
            break;
    }
    
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView new];
}
-(MyShopModel *)shopModel{
    
    if (!_shopModel) {

        _shopModel = [[MyShopModel alloc] init];
    }
    return _shopModel;
}

-(NSArray *)shopItemCellArr{
    
    if (!_shopItemCellArr) {
        
        _shopItemCellArr = [NSArray array];
    }
    return _shopItemCellArr;
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = self.shopPhotoView;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopInfoCell class]) bundle:nil] forCellReuseIdentifier:@"shopInfoCellID"];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopItemCell class]) bundle:nil] forCellReuseIdentifier:@"shopItemCellID"];
    return _tableView;
}

-(UIButton *)bottomBtn{
    
    if (!_bottomBtn) {
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:[UIColor colorWithRed:255.f/255 green:102.f/255 blue:35.f/255 alpha:1.f]];
        [_bottomBtn addTarget:self action:@selector(UploadDataToServer) forControlEvents:UIControlEventTouchUpInside];
        _bottomBtn.layer.cornerRadius = 5.0f;
    }
    
    return _bottomBtn;
}

-(NSMutableArray *)bottomImgArr{
    
    if (!_bottomImgArr) {
        
        _bottomImgArr = [NSMutableArray array];
    }
    return _bottomImgArr;
}

-(ShopPhotoView *)shopPhotoView{
    
    if (!_shopPhotoView) {
        
        _shopPhotoView = [[ShopPhotoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        
    }
    return _shopPhotoView;
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
