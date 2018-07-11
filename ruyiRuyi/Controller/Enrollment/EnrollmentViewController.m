//
//  EnrollmentViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "EnrollmentViewController.h"
#import "JJMapViewController.h"
#import "AccountCell.h"
#import "StoresCell.h"
#import "photoCell.h"
#import "ProjectCell.h"
#import "JJFileStorage.h"
#import "DegreeCell.h"

#import "EnrollmentRequestData.h"

#import <SDWebImageDownloader.h>
@interface EnrollmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTabView;

@property(nonatomic,strong)NSMutableArray *indexPathArr;


@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;

@end

@implementation EnrollmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self.view addSubview:self.myTabView];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}


-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    return 8;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    switch (indexPath.section) {
        case 0:
        {
            AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }
            return cell;
        }
            break;
        case 1:
        {
            StoresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storesCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.MapBtn addTarget:self action:@selector(pushWithPosition) forControlEvents:UIControlEventTouchUpInside];
            
            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }
            return cell;
        }
            break;
        case 2:
        {
            photoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.photoTitle.text = @"上传营业执照";
            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }
            return cell;
        }
            break;
        case 3:
        {
            photoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell2" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.photoTitle.text = @"上传门店照片";
            cell.itemContentArr = @[@"门头照片",@"店内照片",@"车间照片"];

            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }
            return cell;
        }
            break;
        case 4:
        {
            photoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell3" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.photoTitle.text = @"手持身份证照片";
            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }
            return cell;
        }
            break;
        case 5:
        {
            ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"projectCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }            return cell;
        }
        case 6:
        {
            DegreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DegreeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (![self.indexPathArr containsObject:cell]) {
                [self.indexPathArr addObject:cell];
            }
            return cell;
        }
        default:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogInCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"保存";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.backgroundColor = [JJTools getColor:@"#FF6623"];
            return cell;
        }
            break;
    }
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 282;
            break;
        case 2:case 3:case 4:
            return 115;
            break;
        case 5:
            return 100;
            break;
        case 6:
            return 80;
            break;
        default:
            return 40;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section==7) {
        
        if (self.longitude && self.latitude) {

            NSLog(@"经纬度存在");
        }

        AccountCell *accCell = self.indexPathArr[0];

        if ([accCell.userField.text isEqualToString:@""]
            ||
            [accCell.phoenField.text isEqualToString:@""]
            ||
            [accCell.codeTextField.text isEqualToString:@""]
            ||
            [accCell.passwordField.text isEqualToString:@""]
            ||
            [accCell.checkPswdField.text isEqualToString:@""]
            ) {

            [MBProgressHUD showTextMessage:@"用户信息不完整!"];
            return;
        }

        if (![accCell.passwordField.text isEqualToString:accCell.checkPswdField.text]) {

            [MBProgressHUD showTextMessage:@"两次密码不一致！"];
            return;
        }

        if (accCell.passwordField.text.length <6) {

            [MBProgressHUD showTextMessage:@"密码最低为六位！"];
            return;
        }

        StoresCell  *storeCell = self.indexPathArr[1];

        if (!storeCell.cityID && !storeCell.areaID) {

            NSLog(@"上传ID判断一下，有的城市没有区");
        }


        if (
            [storeCell.storeName.text isEqualToString:@""]
            ||
            [storeCell.storeType.titleLabel.text isEqualToString:@"请选择您的门店类别"]
            ||
            [storeCell.storePhone.text isEqualToString:@""]
            ||
            [storeCell.storeTime.titleLabel.text isEqualToString:@"请选择您的营业时间"]
            ||
            [storeCell.storeCity.titleLabel.text isEqualToString:@"省             市             区"]
            ||
            [storeCell.storeLocation.text isEqualToString:@""]
            ||
            [storeCell.MapBtn.titleLabel.text isEqualToString:@""]
            ) {

            [MBProgressHUD showTextMessage:@"门店信息不完整!"];
            return;
        }

        
        NSArray *array = [storeCell.storeTime.titleLabel.text componentsSeparatedByString:@"至"]; //商店营业时间
        if (array.count<2) {
            
            return;
        }
        
        NSString *storeStartTime = [NSString stringWithFormat:@"2000-01-01T%@.000+0800",array[0]];
        NSString *storeStopTime = [NSString stringWithFormat:@"2000-01-01T%@.000+0800",array[1]];

        //门店相关照片
        photoCell *phCell = self.indexPathArr[2];
        photoCell *phStoreCell = self.indexPathArr[3];
        photoCell *IDCell = self.indexPathArr[4];

        if (phCell.img1 == nil      ||
            phStoreCell.img1 == nil ||
            phStoreCell.img2 == nil ||
            phStoreCell.img3 == nil ||
            IDCell.img1 == nil) {
            
            [MBProgressHUD showTextMessage:@"请选择完整的照片信息！"];
            return;
        }
        
        //合作项目
        ProjectCell *Pcell = self.indexPathArr[5];
        if (Pcell.selectItems.count<=0) {
            
            [MBProgressHUD showTextMessage:@"请选择服务类型"];
            return;
        }
//        NSLog(@"选中的数据为： %@",Pcell.selectItems);
        
        //熟练度
        DegreeCell *Dcell = self.indexPathArr[6];
        
        NSString *appExpert = [Dcell.selectBtn isEqualToString:@"熟练"] ? @"1":@"2";
        
        NSDictionary *reqJsonDic = @{@"producerName":accCell.userField.text,@"phone":accCell.phoenField.text,@"password":[MD5Encrypt MD5ForUpper32Bate:accCell.passwordField.text],@"storeName":storeCell.storeName.text,@"storeTypeId":storeCell.storeTypeID,@"tel":storeCell.storePhone.text,@"startTime":storeStartTime,@"endTime":storeStopTime,@"cityId":storeCell.cityID,@"positionId":storeCell.areaID,@"address":storeCell.storeLocation.text,@"longitude":self.longitude,@"latitude":self.latitude,@"appExpert":appExpert,@"storeLocation":storeCell.storeCity.titleLabel.text};
        
        float imgCompressionQuality = 0.3;//图片压缩比例
        NSData *licenseData=UIImageJPEGRepresentation(phCell.img1, imgCompressionQuality);
        NSData *storeData=UIImageJPEGRepresentation(phStoreCell.img1, imgCompressionQuality);
        NSData *storeData1=UIImageJPEGRepresentation(phStoreCell.img2, imgCompressionQuality);
        NSData *storeData2=UIImageJPEGRepresentation(phStoreCell.img3, imgCompressionQuality);
        NSData *IdData= UIImageJPEGRepresentation(IDCell.img1, imgCompressionQuality);

        NSArray <JJFileParam *> *arr=@[
                                       [JJFileParam fileConfigWithfileData:licenseData name:@"business_license_img" fileName:@"zhizhao.png" mimeType:@"image/jpg/png/jpeg"],
                                       [JJFileParam fileConfigWithfileData:storeData name:@"location_img" fileName:@"mentou.png" mimeType:@"image/jpg/png/jpeg"],
                                       [JJFileParam fileConfigWithfileData:storeData1 name:@"indoor_img" fileName:@"mendian.png" mimeType:@"image/jpg/png/jpeg"],
                                       [JJFileParam fileConfigWithfileData:storeData2 name:@"factory_img" fileName:@"chejian.png" mimeType:@"image/jpg/png/jpeg"],
                                       [JJFileParam fileConfigWithfileData:IdData name:@"id_img" fileName:@"shenfenzheng.png" mimeType:@"image/jpg/png/jpeg"]
                                       ];
        
        NSString *str = [NSString stringWithFormat:@"%@",[Pcell.selectItems componentsJoinedByString:@","]];//#为分隔符

        [EnrollmentRequestData userEnrollmentWithReqjson:[JJTools convertToJsonData:reqJsonDic] serviceTypes:str photos:arr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
           
            if ([code longLongValue] == 1) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }

        } failure:^(NSError * _Nullable error) {
            
        }];
        
        
    }
    
}


-(void)pushWithPosition{
    
    JJMapViewController *jjMap = [[JJMapViewController alloc]init];
    
    jjMap.locationBlock = ^(CGFloat longitude, CGFloat latitude ,NSString *storePosition) {
        
        if (!self.indexPathArr[1]||!longitude||!latitude) return ;
        
        StoresCell *cell = self.indexPathArr[1];
        [cell.MapBtn setTitle:[NSString stringWithFormat:@"%@",storePosition] forState:UIControlStateNormal];
        
        self.longitude = [NSString stringWithFormat:@"%f",longitude];
        self.latitude = [NSString stringWithFormat:@"%f",latitude];

    };
    
    
    [self.navigationController pushViewController:jjMap animated:YES];
}



-(UITableView *)myTabView{
    
    if (!_myTabView) {
        
        CGRect frame;
        
        if (KIsiPhoneX) {
            
            frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
        }else{
            frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        }
        
        _myTabView  = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _myTabView.delegate = self;
        _myTabView.dataSource = self;
        
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([AccountCell class]) bundle:nil] forCellReuseIdentifier:@"accountCell"];
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([StoresCell class]) bundle:nil] forCellReuseIdentifier:@"storesCell"];
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([photoCell class]) bundle:nil] forCellReuseIdentifier:@"photoCell1"];
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([photoCell class]) bundle:nil] forCellReuseIdentifier:@"photoCell2"];
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([photoCell class]) bundle:nil] forCellReuseIdentifier:@"photoCell3"];
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([ProjectCell class]) bundle:nil] forCellReuseIdentifier:@"projectCell"];
        [_myTabView registerNib:[UINib nibWithNibName:NSStringFromClass([DegreeCell class]) bundle:nil] forCellReuseIdentifier:@"DegreeCell"];
        [_myTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LogInCell"];
    }
    return _myTabView;
}

-(NSMutableArray <NSIndexPath *> *)indexPathArr{
    
    if (!_indexPathArr) {
        
        _indexPathArr = [NSMutableArray array];
    }
    return _indexPathArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
