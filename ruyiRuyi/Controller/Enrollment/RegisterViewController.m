//
//  RegisterViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/18.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "RegisterViewController.h"
#import <TZImagePickerController.h>
#import "JJMapViewController.h"
#import "UserProtocolViewController.h"

#import "ProjectCollectionViewCell.h"
#import "YMStoreTypePickerView.h"
#import "YMDatePickerView.h"
#import "YMCityPickerView.h"

#import "EnrollmentRequestData.h"

#import "JJFileStorage.h"
#import "YMButton.h"
#import "UIButton+timer.h"
@interface RegisterViewController ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITextField *shenqingrenTextField;///申请人姓名
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;///手机号
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;///获取验证码按钮
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;///验证码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;///密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;///确认密码
@property (weak, nonatomic) IBOutlet UITextField *storeNameTextField;///门店名称
@property (weak, nonatomic) IBOutlet UITextField *storeTypeTextField;///门店类型
@property (weak, nonatomic) IBOutlet UITextField *telTextField;///电话
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;///营业时间
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;///城市
@property (weak, nonatomic) IBOutlet UITextField *addresTextField;///详细地址
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;///定位

@property (weak, nonatomic) IBOutlet UIButton *BusinessLicenseBtn;///营业执照按钮
@property (weak, nonatomic) IBOutlet UIImageView *BusinessImgView;///营业执照照片

@property (weak, nonatomic) IBOutlet YMButton *doorwayBtn;///门头按钮
@property (weak, nonatomic) IBOutlet UIImageView *doorwayImgView;///门头照片

@property (weak, nonatomic) IBOutlet YMButton *storeInsideBtn;///店内按钮
@property (weak, nonatomic) IBOutlet UIImageView *storeInsideImgView;///店内照片

@property (weak, nonatomic) IBOutlet YMButton *workshopBtn;///车间按钮
@property (weak, nonatomic) IBOutlet UIImageView *workshopImgVIew;///车间照片

@property (weak, nonatomic) IBOutlet UIButton *idCardBtn;///手持身份证按钮
@property (weak, nonatomic) IBOutlet UIImageView *idCardImgView;///手持身份证照片

///服务view
@property (weak, nonatomic) IBOutlet UICollectionView *serviceCollectionView;

///操作是否熟练
@property (weak, nonatomic) IBOutlet UIButton *skilledBtn;
@property (weak, nonatomic) IBOutlet UIButton *noSkilledBtn;

///是否同意协议
@property (weak, nonatomic) IBOutlet UIButton *confirmProtocolBtn;

///门店类型id
@property(nonatomic,copy)NSString *storeTypeID;
///城市id
@property(nonatomic,copy)NSString *cityID;
///县区id
@property(nonatomic,copy)NSString *areaID;
///经纬度id
@property(nonatomic,copy)NSString *longitude;
///经纬度id
@property(nonatomic,copy)NSString *latitude;
///类型数组
@property (strong, nonatomic) NSArray *typeArr;
///服务数组
@property(nonatomic,strong)NSArray *serviceArr;
///选择的服务数组
@property(nonatomic,strong)NSMutableArray *selectItems;

@property (strong, nonatomic) JJFileStorage *fileStorage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceViewheightLayout;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self.serviceCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProjectCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProjectCollectionCell"];
    self.serviceCollectionView.allowsMultipleSelection = YES;//实现多选必须实现这个方法
    
    
    UITapGestureRecognizer *selectTypeTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectStoreTypeAction)];
    [self.storeTypeTextField addGestureRecognizer:selectTypeTapGes];
    
    UITapGestureRecognizer *timeTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTimeAction)];
    [self.timeTextField addGestureRecognizer:timeTapGes];
    
    UITapGestureRecognizer *cityTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCityAction)];
    [self.cityTextField addGestureRecognizer:cityTapGes];
    
    UITapGestureRecognizer *locationTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLocationAction)];
    [self.locationTextField addGestureRecognizer:locationTapGes];
    
    
    [self getDataList];
}

- (void)getDataList{
    JJWeakSelf
    ///获取门店类型
    [EnrollmentRequestData getStoreTypeWithSuccrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([data valueForKeyPath:@"name"]) {
            
            weakSelf.storeTypeTextField.placeholder = @"请选择门店类型";
            weakSelf.typeArr = (NSArray *)data;
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    NSDictionary *dic;
    if (self.fileStorage.getFile.count<=0) {
        
        dic = @{@"time":@"2000-00-00 00:00:00"};
    }else{
        dic = @{@"time":[JJTools getTimestampFromTime:self.fileStorage.lastObjectTime formatter:@"yyyy-MM-dd HH:mm:ss"]};
    }
    ///获取城市
    [EnrollmentRequestData getCityListWithJson:[JJTools convertToJsonData:dic] succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        weakSelf.cityTextField.placeholder = @"请选择城市";
        
        if ([data isEqualToArray:@[]]) {
            return ;
        }
        [weakSelf.fileStorage setFile:data];
        
    } failure:^(NSError * _Nullable error) {
    }];
    
    ///获取服务列表
    [EnrollmentRequestData getStoreServiceTypeWithSuccrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
//        NSLog(@"服务列表：%@  %@  %@",code,message,data);
        
        weakSelf.serviceArr =data;
        [weakSelf.serviceCollectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark 获取验证码
- (IBAction)getCodeAction:(UIButton *)sender {
    
    BOOL isPhone = [JJTools valiMobile:self.phoneTextField.text];
    
    if (isPhone == NO) {
        
        [MBProgressHUD showTextMessage:@"请输入正确的手机号码!"];
        return;
    }
    
    [sender startWithTime:60 title:@"获取验证码" countDownTitle:@""];
    
    [EnrollmentRequestData getCodeWithReqJson:self.phoneTextField.text succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSLog(@"验证码:%@",data);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark 选择门店类型
- (void)selectStoreTypeAction{
    
    if ([self.storeTypeTextField.placeholder isEqualToString:@"正在获取数据..."]) {
        [MBProgressHUD showTextMessage:@"数据暂未获取成功！"];
        return;
    }
    
    JJWeakSelf
    YMStoreTypePickerView *store = [[YMStoreTypePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    store.storeType = ^(NSString *storeType,NSString *typeID) {
        
        weakSelf.storeTypeTextField.text = storeType;
        weakSelf.storeTypeID = typeID;
    };
    
    if (self.typeArr.count>0) {
        store.typeArr = weakSelf.typeArr;
        
    }else{store.typeArr  = @[@{@"name":@"未获取到数据!"}];};
    [store show];
    
}

#pragma mark 选择时间
- (void)selectTimeAction{
    JJWeakSelf
    YMDatePickerView *dateView = [[YMDatePickerView alloc] init];
    
    dateView.selectTime = ^(NSString *starTime, NSString *stopTime) {
        weakSelf.timeTextField.text = [NSString stringWithFormat:@"%@至%@",starTime,stopTime];
    };
    [dateView show];
}
#pragma mark 选择城市
- (void)selectCityAction{
    if ([self.cityTextField.placeholder isEqualToString:@"正在获取数据..."]) {
        [MBProgressHUD showTextMessage:@"数据暂未获取成功！"];
        return;
    }
    
    JJWeakSelf
    YMCityPickerView *city = [[YMCityPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    city.cityBlcok = ^(NSString *province, NSString *city, NSString *area, NSString *cityID, NSString *areaID) {
        
        weakSelf.cityTextField.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        
        weakSelf.cityID = cityID;
        weakSelf.areaID = areaID;
    };
    
    if (weakSelf.fileStorage.getFile.count>0) {
        city.cityArr = weakSelf.fileStorage.getFile;
    }else{city.cityArr  = @[@"未获取到数据!"];}
    [city show];
}
#pragma mark 获取定位信息
- (void)selectLocationAction{
    JJWeakSelf
    JJMapViewController *jjMap = [[JJMapViewController alloc]init];
    
    jjMap.locationBlock = ^(CGFloat longitude, CGFloat latitude ,NSString *storePosition) {
        
        weakSelf.locationTextField.text = storePosition;
        weakSelf.longitude = [NSString stringWithFormat:@"%f",longitude];
        weakSelf.latitude = [NSString stringWithFormat:@"%f",latitude];
    };
    [self.navigationController pushViewController:jjMap animated:YES];
}

#pragma mark 选择图片
- (IBAction)selectPhotoAction:(UIButton *)sender {
    JJWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.maxImagesCount = 1;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *image = photos[0];
        if (sender == weakSelf.BusinessLicenseBtn) {
            weakSelf.BusinessImgView.image = image;
        }
        if (sender == weakSelf.doorwayBtn) {
            weakSelf.doorwayImgView.image = image;
        }
        if (sender == weakSelf.storeInsideBtn) {
            weakSelf.storeInsideImgView.image = image;
        }
        if (sender == weakSelf.workshopBtn) {
            weakSelf.workshopImgVIew.image = image;
        }
        if (sender == self.idCardBtn) {
            weakSelf.idCardImgView.image = image;
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark 是否熟练
- (IBAction)operationAction:(UIButton *)sender {
    sender.selected = YES;
    [sender setBackgroundColor:JJThemeColor];
    
    if (sender == self.skilledBtn) {
        [self.noSkilledBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        self.noSkilledBtn.selected = NO;
    }
    if (sender == self.noSkilledBtn) {
        [self.skilledBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        self.skilledBtn.selected = NO;
    }
}
#pragma mark 同意协议
- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)agreementAction:(id)sender {
    UserProtocolViewController *userProtocolVC = [[UserProtocolViewController alloc] init];
    userProtocolVC.dealIdStr = @"2";
    [self.navigationController pushViewController:userProtocolVC animated:YES];
}

#pragma mark 提交注册
- (IBAction)registerAction:(id)sender {
    
    if ([self.shenqingrenTextField.text isEqualToString:@""]
        ||
        [self.phoneTextField.text isEqualToString:@""]
        ||
        [self.codeTextField.text isEqualToString:@""]
        ||
        [self.passwordTextField.text isEqualToString:@""]
        ||
        [self.confirmPasswordTextField.text isEqualToString:@""]
        ) {
        
        [MBProgressHUD showTextMessage:@"用户信息不完整!"];
        return;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        
        [MBProgressHUD showTextMessage:@"两次密码不一致！"];
        return;
    }
    
    if (self.passwordTextField.text.length <6) {
        
        [MBProgressHUD showTextMessage:@"密码最低为六位！"];
        return;
    }
    
    if (!self.cityID && !self.areaID) {
        
        NSLog(@"上传ID判断一下，有的城市没有区");
    }
    
    if (
        [self.storeNameTextField.text isEqualToString:@""]
        ||
        [self.storeTypeTextField.text isEqualToString:@""]
        ||
        [self.timeTextField.text isEqualToString:@""]
        ||
        [self.phoneTextField.text isEqualToString:@""]
        ||
        [self.timeTextField.text isEqualToString:@""]
        ||
        [self.cityTextField.text isEqualToString:@""]
        ||
        [self.addresTextField.text isEqualToString:@""]
        ||
        [self.locationTextField.text isEqualToString:@""]
        ) {
        
        [MBProgressHUD showTextMessage:@"门店信息不完整!"];
        return;
    }
    
    if (!self.longitude && !self.latitude) {
        
        [MBProgressHUD showTextMessage:@"定位信息错误！"];
        return;
    }
    
    NSArray *array = [self.timeTextField.text componentsSeparatedByString:@"至"]; //商店营业时间
    if (array.count<2) {
        [MBProgressHUD showTextMessage:@"营业时间错误！"];
        return;
    }
    
    NSString *storeStartTime = [NSString stringWithFormat:@"2000-01-01T%@.000+0800",array[0]];
    NSString *storeStopTime = [NSString stringWithFormat:@"2000-01-01T%@.000+0800",array[1]];
    
    if (self.doorwayImgView.image == nil      ||
        self.BusinessImgView.image == nil ||
        self.workshopImgVIew.image == nil ||
        self.idCardImgView.image == nil ||
        self.storeInsideImgView.image == nil) {
        [MBProgressHUD showTextMessage:@"请选择完整的照片信息！"];
        return;
    }
    
    if (self.selectItems.count<=0) {
        [MBProgressHUD showTextMessage:@"请选择服务类型"];
        return;
    }
    NSString *appExpert = self.skilledBtn.isSelected ? @"1":@"2";
    if (!self.confirmProtocolBtn.selected) {
        [MBProgressHUD showTextMessage:@"请先选择协议！"];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在注册..." showView:self.view];
    NSDictionary *reqJsonDic = @{@"producerName":self.shenqingrenTextField.text,
                                 @"phone":self.phoneTextField.text,
                                 @"password":[MD5Encrypt MD5ForUpper32Bate:self.passwordTextField.text],
                                 @"storeName":self.storeNameTextField.text,
                                 @"storeTypeId":self.storeTypeID,
                                 @"tel":self.telTextField.text,
                                 @"startTime":storeStartTime,
                                 @"endTime":storeStopTime,
                                 @"cityId":self.cityID,
                                 @"positionId":self.areaID,
                                 @"address":self.addresTextField.text,
                                 @"longitude":self.longitude,
                                 @"latitude":self.latitude,
                                 @"appExpert":appExpert,
                                 @"storeLocation":self.cityTextField.text};
    
    float imgCompressionQuality = 0.3;//图片压缩比例
    NSData *licenseData=UIImageJPEGRepresentation(self.BusinessImgView.image, imgCompressionQuality);
    NSData *storeData=UIImageJPEGRepresentation(self.doorwayImgView.image, imgCompressionQuality);
    NSData *storeData1=UIImageJPEGRepresentation(self.storeInsideImgView.image, imgCompressionQuality);
    NSData *storeData2=UIImageJPEGRepresentation(self.workshopImgVIew.image, imgCompressionQuality);
    NSData *IdData= UIImageJPEGRepresentation(self.idCardImgView.image, imgCompressionQuality);
    
    NSArray <JJFileParam *> *arr=@[
        [JJFileParam fileConfigWithfileData:licenseData name:@"business_license_img" fileName:@"zhizhao.png" mimeType:@"image/jpg/png/jpeg"],
        [JJFileParam fileConfigWithfileData:storeData name:@"location_img" fileName:@"mentou.png" mimeType:@"image/jpg/png/jpeg"],
        [JJFileParam fileConfigWithfileData:storeData1 name:@"indoor_img" fileName:@"mendian.png" mimeType:@"image/jpg/png/jpeg"],
        [JJFileParam fileConfigWithfileData:storeData2 name:@"factory_img" fileName:@"chejian.png" mimeType:@"image/jpg/png/jpeg"],
        [JJFileParam fileConfigWithfileData:IdData name:@"id_img" fileName:@"shenfenzheng.png" mimeType:@"image/jpg/png/jpeg"]
    ];
    
    NSString *sercives = [NSString stringWithFormat:@"%@",[self.selectItems componentsJoinedByString:@","]];//#为分隔符
    
    [EnrollmentRequestData userEnrollmentWithReqjson:[JJTools convertToJsonData:reqJsonDic] serviceTypes:sercives photos:arr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ([code longLongValue] == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showTextMessage:@"注册成功！"];
        }
        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}


#pragma mark 获取服务
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.serviceArr.count>0) {
        
        return self.serviceArr.count;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProjectCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCollectionCell" forIndexPath:indexPath];
    if (self.serviceArr.count<=0) {
        cell.titleLab.text = @"无数据！";
    }else{
        cell.titleLab.text = [self.serviceArr[indexPath.row] objectForKey:@"name"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectCollectionViewCell *cell = (ProjectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLab.backgroundColor = [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1];
    cell.titleLab.textColor = [UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1];
    if (self.serviceArr.count !=0){
        [self.selectItems removeObject:[self.serviceArr[indexPath.row] objectForKey:@"id"]];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProjectCollectionViewCell *cell = (ProjectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLab.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1];
    cell.titleLab.textColor = [UIColor whiteColor];
    
    if (self.serviceArr.count!=0){
        [self.selectItems addObject:[self.serviceArr[indexPath.row] objectForKey:@"id"]];
    }
}

//  允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSMutableArray *)selectItems{
    
    if (!_selectItems) {
        _selectItems = [NSMutableArray array];
    }
    return _selectItems;
}


-(NSArray *)typeArr{
    
    if (!_typeArr) {
        
        _typeArr = [NSArray array];
    }
    return _typeArr;
}
-(NSArray *)serviceArr{
    
    if (!_serviceArr) {
        
        _serviceArr = [NSArray array];
    }
    return _serviceArr;
}
-(JJFileStorage *)fileStorage{
    
    if (!_fileStorage) {
        
        _fileStorage = [[JJFileStorage alloc] init];
    }
    return _fileStorage;
}

@end
