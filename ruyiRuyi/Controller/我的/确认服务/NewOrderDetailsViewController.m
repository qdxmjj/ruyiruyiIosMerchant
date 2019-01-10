//
//  NewOrderDetailsViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "NewOrderDetailsViewController.h"
#import "JJDecoderViewController.h"
#import "TireNumberCell.h"
#import "ZZYPhotoHelper.h"
#import "JJMacro.h"
#import "JJFileParam.h"
@interface NewOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *carIDLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@property (strong, nonatomic) NSMutableDictionary *defaultUpData;

@property (strong, nonatomic) NSMutableArray <JJFileParam *> * imgArr;

@end

@implementation NewOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发货订单详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TireNumberCell class]) bundle:nil] forCellReuseIdentifier:@"TireNumberCellID"];
    
    self.orderNumberLab.text = [NSString stringWithFormat:@"%@",self.deliveryOrderDetils.no];
    self.carIDLab.text = [NSString stringWithFormat:@"%@",self.deliveryOrderDetils.platNumber];
    self.timeLab.text = [NSString stringWithFormat:@"%@",[JJTools getTimestampFromTime:self.deliveryOrderDetils.time formatter:nil]];
    self.phoneLab.text = [NSString stringWithFormat:@"%@",self.deliveryOrderDetils.phone];
    
    [self.tableView  reloadData];
}

- (IBAction)deliveryEvent:(UIButton *)sender {
    
    [MBProgressHUD showWaitMessage:@"正在发货.." showView:self.view];
    
    [self.defaultUpData setObject:@([self.deliveryOrderDetils.orderID integerValue]) forKey:@"id"];
    [self.defaultUpData setObject:self.deliveryOrderDetils.no forKey:@"no"];
    [self.defaultUpData setObject:self.deliveryOrderDetils.phone forKey:@"phone"];
    
    if (self.deliveryOrderDetils.isConsistent) {
        
        for (int i = 1; i<=self.deliveryOrderDetils.frontTyre.integerValue; i++) {
            
            [self.defaultUpData setObject:[self.deliveryOrderDetils.tireList[0] objectForKey:@"tyreName"] forKey:[NSString stringWithFormat:@"tyreName%d",i]];
            [self.defaultUpData setObject:[self.deliveryOrderDetils.tireList[0] objectForKey:@"tyreId"] forKey:[NSString stringWithFormat:@"shoeId%d",i]];
            [self.defaultUpData setObject:[self.deliveryOrderDetils.tireList[0] objectForKey:@"tyreFlag"] forKey:[NSString stringWithFormat:@"flag%d",i]];
            [self.defaultUpData setObject:[self.deliveryOrderDetils.tireList[0] objectForKey:@"tyrePrice"] forKey:[NSString stringWithFormat:@"tyrePrice%d",i]];
            [self.defaultUpData setObject:[self.deliveryOrderDetils.tireList[0] objectForKey:@"orderImg"] forKey:[NSString stringWithFormat:@"tyreImgUrl%d",i]];
        }
    }else{
        
        if (self.deliveryOrderDetils.frontTyre.integerValue == 0) {
            
            for (int r = 1; r <= self.deliveryOrderDetils.rearTyre.integerValue; r++) {
                
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearTyreName forKey:[NSString stringWithFormat:@"tyreName%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearTyreId forKey:[NSString stringWithFormat:@"shoeId%d",r]];
                [self.defaultUpData setObject:@"2" forKey:[NSString stringWithFormat:@"flag%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearTyrePrice forKey:[NSString stringWithFormat:@"tyrePrice%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearOrderImg forKey:[NSString stringWithFormat:@"tyreImgUrl%d",r]];
            }
            
        }else if(self.deliveryOrderDetils.rearTyre.integerValue == 0){
            
            for (int r = 1; r <= self.deliveryOrderDetils.rearTyre.integerValue; r++) {
                
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontTyreName forKey:[NSString stringWithFormat:@"tyreName%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontTyreId forKey:[NSString stringWithFormat:@"shoeId%d",r]];
                [self.defaultUpData setObject:@"1" forKey:[NSString stringWithFormat:@"flag%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontTyrePrice forKey:[NSString stringWithFormat:@"tyrePrice%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontOrderImg forKey:[NSString stringWithFormat:@"tyreImgUrl%d",r]];
            }
            
        }else{
            
            for (int r = 1; r <= self.deliveryOrderDetils.frontTyre.integerValue; r++) {
                
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontTyreName forKey:[NSString stringWithFormat:@"tyreName%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontTyreId forKey:[NSString stringWithFormat:@"shoeId%d",r]];
                [self.defaultUpData setObject:@"1" forKey:[NSString stringWithFormat:@"flag%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontTyrePrice forKey:[NSString stringWithFormat:@"tyrePrice%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.frontOrderImg forKey:[NSString stringWithFormat:@"tyreImgUrl%d",r]];
            }
            
            for (int r = self.deliveryOrderDetils.frontTyre.intValue+1; r <= self.deliveryOrderDetils.rearTyre.integerValue+self.deliveryOrderDetils.frontTyre.integerValue; r++) {
                
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearTyreName forKey:[NSString stringWithFormat:@"tyreName%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearTyreId forKey:[NSString stringWithFormat:@"shoeId%d",r]];
                [self.defaultUpData setObject:@"2" forKey:[NSString stringWithFormat:@"flag%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearTyrePrice forKey:[NSString stringWithFormat:@"tyrePrice%d",r]];
                [self.defaultUpData setObject:self.deliveryOrderDetils.rearOrderImg forKey:[NSString stringWithFormat:@"tyreImgUrl%d",r]];
            }
            
        }
    }
    
    NSLog(@"%@\n%@",self.defaultUpData,_imgArr);
    [JJRequest GL_UpdateRequest:@"orderInfo/updateOrderPostStatusByStore" params:self.defaultUpData fileConfig:self.imgArr progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
//        NSLog(@"%@  %@  %@",code,message,data);
        [MBProgressHUD hideWaitViewAnimated:self.view];
        if ([code longLongValue] == 0) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        [MBProgressHUD showTextMessage:message];
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

-(NSMutableDictionary *)defaultUpData{
    
    if (!_defaultUpData) {
        
        _defaultUpData = [NSMutableDictionary dictionary];
        [_defaultUpData setObject:[UserConfig storeName] forKey:@"storeName"];
        [_defaultUpData setObject:@([[UserConfig storeID] integerValue]) forKey:@"storeId"];
        [_defaultUpData setObject:@(0) forKey:@"id"];
        [_defaultUpData setObject:@"" forKey:@"no"];
        [_defaultUpData setObject:@"" forKey:@"phone"];
        //默认的必传参数
    }
    return _defaultUpData;
}

-(NSMutableArray <JJFileParam *>*)imgArr{
    if (!_imgArr) {
        
        _imgArr = [NSMutableArray array];
        [_imgArr addObject:[JJFileParam fileConfigWithfileData:[NSData data] name:@"imgUrl" fileName:@"tire1.png" mimeType:@"image/jpg/png/jpeg"]];
        [_imgArr addObject:[JJFileParam fileConfigWithfileData:[NSData data] name:@"imgUrl2" fileName:@"tire2.png" mimeType:@"image/jpg/png/jpeg"]];
        [_imgArr addObject:[JJFileParam fileConfigWithfileData:[NSData data] name:@"imgUrl3" fileName:@"tire3.png" mimeType:@"image/jpg/png/jpeg"]];
        [_imgArr addObject:[JJFileParam fileConfigWithfileData:[NSData data] name:@"imgUrl4" fileName:@"tire4.png" mimeType:@"image/jpg/png/jpeg"]];
        
        //设置默认图片，必传  最多四个轮胎 最多四张图片
    }
    return _imgArr;
}

#pragma mark photoBtn
-(void)openCameraEvent:(UIButton *)sender{
    
    JJWeakSelf
    float imgCompressionQuality = 0.3;//图片压缩比例
    
    TireNumberCell *cell = (TireNumberCell *)sender.superview.superview;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        NSData *licenseData= UIImageJPEGRepresentation(data, imgCompressionQuality);
        
        if (indexPath.section == 0) {
            
            switch (indexPath.row) {
                case 0:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:0 withObject:[JJFileParam fileConfigWithfileData:licenseData name:@"imgUrl" fileName:@"tire1.png" mimeType:@"image/jpg/png/jpeg"]];
                    break;
                case 1:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:1 withObject:[JJFileParam fileConfigWithfileData:licenseData name:@"imgUrl2" fileName:@"tire2.png" mimeType:@"image/jpg/png/jpeg"]];
                    break;
                case 2:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:2 withObject:[JJFileParam fileConfigWithfileData:licenseData name:@"imgUrl3" fileName:@"tire3.png" mimeType:@"image/jpg/png/jpeg"]];
                    break;
                case 3:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:3 withObject:[JJFileParam fileConfigWithfileData:licenseData name:@"imgUrl4" fileName:@"tire4.png" mimeType:@"image/jpg/png/jpeg"]];
                    break;
                default:
                    break;
            }
        }else if (indexPath.section == 1){
            
            switch (indexPath.row) {
                case 0:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:self.deliveryOrderDetils.frontTyre.integerValue withObject:[JJFileParam fileConfigWithfileData:licenseData name:[NSString stringWithFormat:@"imgUrl%ld",self.deliveryOrderDetils.frontTyre.integerValue+1] fileName:[NSString stringWithFormat:@"tire%ld.png",self.deliveryOrderDetils.frontTyre.integerValue+1] mimeType:@"image/jpg/png/jpeg"]];
                    break;
                case 1:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:self.deliveryOrderDetils.frontTyre.integerValue+2 withObject:[JJFileParam fileConfigWithfileData:licenseData name:[NSString stringWithFormat:@"imgUrl%ld",self.deliveryOrderDetils.frontTyre.integerValue+2] fileName:[NSString stringWithFormat:@"tire%ld.png",self.deliveryOrderDetils.frontTyre.integerValue+2] mimeType:@"image/jpg/png/jpeg"]];
                    break;
                case 2:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:self.deliveryOrderDetils.frontTyre.integerValue+3 withObject:[JJFileParam fileConfigWithfileData:licenseData name:[NSString stringWithFormat:@"imgUrl%ld",self.deliveryOrderDetils.frontTyre.integerValue+3] fileName:[NSString stringWithFormat:@"tire%ld.png",self.deliveryOrderDetils.frontTyre.integerValue+3] mimeType:@"image/jpg/png/jpeg"]];
                    break;
                case 3:
                    
                    [weakSelf.imgArr replaceObjectAtIndex:self.deliveryOrderDetils.frontTyre.integerValue+4 withObject:[JJFileParam fileConfigWithfileData:licenseData name:[NSString stringWithFormat:@"imgUrl%ld",self.deliveryOrderDetils.frontTyre.integerValue+4] fileName:[NSString stringWithFormat:@"tire%ld.png",self.deliveryOrderDetils.frontTyre.integerValue+4] mimeType:@"image/jpg/png/jpeg"]];
                    break;
                default:
                    break;
            }
            
        }else{
            NSLog(@"异常信息位置:%s",__func__);
        }
        
        [sender setImage:(UIImage *)data forState:UIControlStateNormal];
    }];
}

#pragma mark UIControlEventEditingChanged
- (void)textFieldEditChanged:(UITextField *)textField{
    
    TireNumberCell *cell = (TireNumberCell *)textField.superview.superview;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSLog(@"textfield text %@",textField.text);
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                
                [self.defaultUpData setObject:textField.text forKey:@"barcode1"];
                break;
            case 1:
                
                [self.defaultUpData setObject:textField.text forKey:@"barcode2"];
                break;
            case 2:
                
                [self.defaultUpData setObject:textField.text forKey:@"barcode3"];
                break;
            case 3:
                
                [self.defaultUpData setObject:textField.text forKey:@"barcode4"];
                break;
            default:
                break;
        }
        
        
    }else if (indexPath.section == 1){
        
        switch (indexPath.row) {
            case 0:
                
                [self.defaultUpData setObject:textField.text forKey:[NSString stringWithFormat:@"barcode%ld",self.deliveryOrderDetils.frontTyre.integerValue+1]];
                break;
            case 1:
                
                [self.defaultUpData setObject:textField.text forKey:[NSString stringWithFormat:@"barcode%ld",self.deliveryOrderDetils.frontTyre.integerValue+2]];
                break;
            case 2:
                [self.defaultUpData setObject:textField.text forKey:[NSString stringWithFormat:@"barcode%ld",self.deliveryOrderDetils.frontTyre.integerValue+3]];
                
                break;
            case 3:
                [self.defaultUpData setObject:textField.text forKey:[NSString stringWithFormat:@"barcode%ld",self.deliveryOrderDetils.frontTyre.integerValue+4]];
                
                break;
            default:
                break;
        }
    }else{
        
    }
}
#pragma mark textfield KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"%@  %@",keyPath,object);
    UITextField *textField = object;
    
    [self textFieldEditChanged:textField];
}

#pragma mark QRcodeBtn
-(void)changedTextFieldContent:(UIButton *)sender{
    
    TireNumberCell *cell = (TireNumberCell *)sender.superview.superview;
    
    JJDecoderViewController *deCoderVC = [[JJDecoderViewController alloc] initWithBlock:^(NSString *content, BOOL isScceed) {
       
        if (isScceed) {
            [cell.barCodeText setText:content];
        }else{
        }
    }];
    
    [self presentViewController:deCoderVC animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.deliveryOrderDetils.isConsistent || [self.deliveryOrderDetils.frontTyre isEqualToString:@"0"] || [self.deliveryOrderDetils.rearTyre isEqualToString:@"0"]) {
        
        
        return 1;
    }else{
        return 2;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TireNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TireNumberCellID"];
    
    [cell.photoBtn addTarget:self action:@selector(openCameraEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.barCodeText addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [cell.QRcodeBtn addTarget:self action:@selector(changedTextFieldContent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TireNumberCell *tireCell = (TireNumberCell *)cell;
    
    [tireCell.barCodeText addObserver:self forKeyPath:@"text" options:0 context:nil];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    TireNumberCell *tireCell = (TireNumberCell *)cell;
    
    [tireCell.barCodeText removeObserver:self forKeyPath:@"text"];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.deliveryOrderDetils.isConsistent) {
        
        
        return self.deliveryOrderDetils.frontTyre.integerValue;
    }else{
        
        if([self.deliveryOrderDetils.frontTyre isEqualToString:@"0"]){
            
            return self.deliveryOrderDetils.rearTyre.integerValue;
        }else if ([self.deliveryOrderDetils.rearTyre isEqualToString:@"0"]){
            
            return self.deliveryOrderDetils.frontTyre.integerValue;
        }else{
            
            if (section == 0) {
                
                return self.deliveryOrderDetils.frontTyre.integerValue;
            }else{
                
                return self.deliveryOrderDetils.rearTyre.integerValue;
            }
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *tireModel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 40)];
    tireModel.text = @"轮胎型号";
    tireModel.font = [UIFont systemFontOfSize:15.f];
    
    UILabel *modelLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200-16, 0, 200, 40)];
    modelLab.textAlignment = NSTextAlignmentRight;
    modelLab.font = [UIFont systemFontOfSize:13.f];
    modelLab.numberOfLines = 0;
    
    UILabel *tireCount = [[UILabel alloc] initWithFrame:CGRectMake(16, 40, 100, 40)];
    tireCount.text = @"轮胎数量";
    tireCount.font = [UIFont systemFontOfSize:15.f];
    
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200-16, 40, 200, 40)];
    countLab.textAlignment = NSTextAlignmentRight;
    countLab.font = [UIFont systemFontOfSize:13.f];
    countLab.numberOfLines = 0;
    
    if (self.deliveryOrderDetils.isConsistent || [self.deliveryOrderDetils.frontTyre isEqualToString:@"0"] || [self.deliveryOrderDetils.rearTyre isEqualToString:@"0"]) {
        
        if ([self.deliveryOrderDetils.frontTyre isEqualToString:@"0"]) {
            
            modelLab.text = self.deliveryOrderDetils.rearTyreName;
            countLab.text = self.deliveryOrderDetils.rearTyre;
        }else{
            
            modelLab.text = self.deliveryOrderDetils.frontTyreName;
            countLab.text = self.deliveryOrderDetils.frontTyre;
        }
        
    }else{
        
        if (section == 0) {
            
            modelLab.text = self.deliveryOrderDetils.frontTyreName;
            countLab.text = self.deliveryOrderDetils.frontTyre;
            
        }else{
            
            modelLab.text = self.deliveryOrderDetils.rearTyreName;
            countLab.text = self.deliveryOrderDetils.rearTyre;
        }
    }
    
    [headerView addSubview:tireModel];
    [headerView addSubview:modelLab];
    [headerView addSubview:tireCount];
    [headerView addSubview:countLab];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 80.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(void)dealloc{
    
    NSArray *cells = [self.tableView visibleCells];
    
    for (TireNumberCell *cell in cells) {
        
        [cell.barCodeText removeObserver:self forKeyPath:@"text"];
    }
}
@end
