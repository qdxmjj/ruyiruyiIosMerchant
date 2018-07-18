//
//  AddCommodityViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AddCommodityViewController.h"
#import "AddCommodityCell.h"

#import "MyCommodityRequest.h"
#import "ZZYPhotoHelper.h"
#import "YMCommodityTypePickerView.h"
#import "YMStoreStatusPickerView.h"
#import <UIButton+WebCache.h>
#define GrayColor [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f]

@interface AddCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL isEditPhotos;
}
@property (strong, nonatomic)UIButton *headImgBtn;//显示商品头像按钮

@property(strong,nonatomic)UIView *contentView;//

@property(strong,nonatomic)UIButton *addCommodityBtn;//提交商品

@property(strong,nonatomic)UIButton *goOnAddBtn;//继续添加

@property(nonatomic,strong)UITableView *contentTableView;

@property(nonatomic,strong)NSArray *titleArr;//tableviewTitle

@property(nonatomic,strong)NSArray *textArr;//CellTitle

@property(nonatomic,strong)UITextField *statusField;

@property(nonatomic,strong)UITextField *amountField;

@property(nonatomic,strong)UITextField *nameField;

@property(nonatomic,strong)UITextField *priceField;

@property(nonatomic,strong)UITextField *commodityTypeField;

@end

@implementation AddCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"添加商品";
    self.view.backgroundColor = [JJTools getColor:@"#f1f1f1"];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.contentTableView];
    [self.view addSubview:self.headImgBtn];
    [self.view addSubview:self.addCommodityBtn];
    [self.view addSubview:self.goOnAddBtn];
    
    self.titleArr =@[@"商品名称",@"单价",@"商品分类",@"库存",@"商品状态"];
    self.textArr = @[@"请在此输入商品名称",@"请在此输入商品单价",@"请在此选择商品分类",@"请在此输入商品库存",@"请在此选择商品状态"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AddCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCellID" forIndexPath:indexPath];
    
    cell.titleLab.text = self.titleArr[indexPath.row];
    cell.textField.placeholder = self.textArr[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.textField.text = self.name;
            self.nameField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

            break;
        case 1:
            cell.textField.text = self.price;
            cell.textField.delegate = self;
            self.priceField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

            break;
        case 2:
            cell.textField.text = self.commodityTypeText;
            cell.textField.delegate = self;
            self.commodityTypeField = cell.textField;

            break;
        case 3:
            cell.textField.text = self.amount;
            cell.textField.delegate = self;
            self.amountField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

            break;
        case 4:
            if (self.status) {
                
                cell.textField.text = [self.status longLongValue] == 1 ?@"在售":@"已下架";;
            }
            cell.textField.delegate = self;
            self.statusField = cell.textField;
            break;
            
        default:
            break;
    }

    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 40.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma mark textfield dalegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.priceField]||[textField isEqual:self.amountField]) {

        return [self validateNumber:string];
    }
    
    return YES;
}



- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.markedTextRange == nil) {
        
        
        if ([textField isEqual:self.nameField]) {
            
            self.name = textField.text;
            
        }else if ([textField isEqual:self.priceField]){
            
            self.price = textField.text;
            
        }else if ([textField isEqual:self.amountField]){
            
            self.amount = textField.text;
            
        }
    }
    
    NSLog(@"text:%@",self.name);

}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    JJWeakSelf
    
    if ([textField isEqual:self.statusField]) {
        
        YMStoreStatusPickerView *statusPW = [[YMStoreStatusPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        statusPW.statusBlcok = ^(NSString *statusID, NSString *statusStr) {
            
            weakSelf.status = statusID;
            
            textField.text = statusStr;
        };
        
        [statusPW show];
        return NO;

        
    }else if([textField isEqual:self.commodityTypeField]){
        
        YMCommodityTypePickerView *CTypePickerVIew = [[YMCommodityTypePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        CTypePickerVIew.dataDic = self.aModel.commodityTypeDic;
        
        CTypePickerVIew.disBlock = ^(NSString *FieldText, NSString *selectServiceTypeID, NSString *selectServiceID, BOOL isDismis) {
            
            if ([selectServiceID isEqualToString:@""]) {
                
                return ;
            }
            
            textField.text = FieldText;
            weakSelf.ServiceTypeId = selectServiceTypeID;
            weakSelf.ServicesId = selectServiceID;
        };
        
        [CTypePickerVIew show];
        return NO;

    }
    
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark click event
-(void)selectPhoto:(UIButton *)sender{
    
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        [sender setImage:(UIImage *)data forState:UIControlStateNormal];
        self->isEditPhotos = YES;
    }];
}


-(void)addCommodityEvent:(UIButton *)sender{
    
    if (!self.ServicesId||!self.ServiceTypeId||!self.status||!self.name||!self.price||!self.amount) {
        
        [MBProgressHUD showTextMessage:@"商品信息不完整!"];
        return;

    }
    
    if (self.ServicesId.length<=0||self.ServiceTypeId.length<=0||self.status.length<=0||self.name.length<=0||self.price.length<=0||self.amount.length<=0) {
        
        [MBProgressHUD showTextMessage:@"商品信息不完整!"];
        return;
        
    }
    if ([self.price isEqualToString:@"0"] || [self.amount isEqualToString:@"0"]) {
        
        [MBProgressHUD showTextMessage:@"价格或库存不能为0！"];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在添加商品...";
    [hud showAnimated:YES];
    
    float imgCompressionQuality = 0.3;//图片压缩比例
    NSData *licenseData = UIImageJPEGRepresentation(self.headImgBtn.imageView.image, imgCompressionQuality);
    
    NSArray <JJFileParam *> *imgArr;
    
    if ([sender.titleLabel.text isEqualToString:@"修改商品信息"]) {
        
        //修改商品信息
        if (isEditPhotos) {
            
            imgArr = @[[JJFileParam fileConfigWithfileData:licenseData name:@"stock_img" fileName:@"shangpin.png" mimeType:@"image/jpg/png/jpeg"]];
            
        }else{
            
            imgArr = nil;
        }
        
        [MyCommodityRequest updateStockTypeWithInfo:@{
                                                      @"id":self.statusID,
                                                      @"storeId":[UserConfig storeID],
                                                      @"name":self.name, @"serviceTypeId":self.ServiceTypeId, @"serviceId":self.ServicesId,
                                                      @"amount":self.amount,
                                                      @"price":self.price,
                                                      @"status":self.status,
                                                      @"imgUrl":self.imgUrl
                                                      }
          stock_img:imgArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
           
              [hud hideAnimated:YES];
              
              [self.navigationController popViewControllerAnimated:YES];
            
          } failure:^(NSError * _Nullable error) {
              [hud hideAnimated:YES];

          }];
        
    }else if([sender.titleLabel.text isEqualToString:@"继续添加"]){
        
        //继续添加商品商品
        imgArr=@[[JJFileParam fileConfigWithfileData:licenseData name:@"stock_img" fileName:@"shangpin.png" mimeType:@"image/jpg/png/jpeg"]];
        
        [MyCommodityRequest addCommodityWithInfo:@{
                                                   @"storeId":[UserConfig storeID],
                                                   @"name":self.name,
                                                   @"serviceTypeId":self.ServiceTypeId,
                                                   @"serviceId":self.ServicesId,
                                                   @"amount":self.amount,
                                                   @"price":self.price,
                                                   @"status":self.status}
     
                                           hotos:imgArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                                               
                                               self.statusField.text = nil;
                                               self.nameField.text = nil;
                                               self.priceField.text = nil;
                                               self.amountField.text = nil;
                                               self.commodityTypeField.text = nil;
                                               [self.headImgBtn setImage:[UIImage imageNamed:@"ic_head"] forState:UIControlStateNormal];
                                               
                                               [hud hideAnimated:YES];
                                               
                                           } failure:^(NSError * _Nullable error) {
                                               [hud hideAnimated:YES];
                                           }];
        }else{
        
            //新增商品
            imgArr=@[[JJFileParam fileConfigWithfileData:licenseData name:@"stock_img" fileName:@"shangpin.png" mimeType:@"image/jpg/png/jpeg"]];
            
            [MyCommodityRequest addCommodityWithInfo:@{
                                                       @"storeId":[UserConfig storeID],
                                                       @"name":self.name,
                                                       @"serviceTypeId":self.ServiceTypeId,
                                                       @"serviceId":self.ServicesId,
                                                       @"amount":self.amount,
                                                       @"price":self.price,
                                                       @"status":self.status}
             
                                               hotos:imgArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                                                   
                                                   [hud hideAnimated:YES];
                                                   
                                                   [self.navigationController popViewControllerAnimated:YES];
                                               } failure:^(NSError * _Nullable error) {
                                                   [hud hideAnimated:YES];
                                               }];
        
        }
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).inset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.mj_h*0.2f);
        make.width.mas_equalTo(self.view.mj_h*0.2f);
    }];
    
    self.headImgBtn.layer.cornerRadius = self.view.mj_h*0.2f/2.f;
    self.headImgBtn.layer.masksToBounds =YES;
    
    self.headImgBtn.layer.borderColor = [[JJTools getColor:@"#f1f1f1"] CGColor];
    self.headImgBtn.layer.borderWidth = 5.0f;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).inset(16);
        make.right.mas_equalTo(self.view.mas_right).inset(16);
        make.top.mas_equalTo(self.headImgBtn.mas_centerY);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.6);
        
    }];
    
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.top.mas_equalTo(self.contentView.mas_top).inset(self.view.frame.size.height*0.2/2+20);
        
    }];
    
    [self.goOnAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).inset(16);
        make.right.mas_equalTo(self.view.mas_right).inset(16);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.06);
        make.bottom.mas_equalTo(self.view.mas_bottom).inset(10);
        
    }];
    
    [self.addCommodityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).inset(16);
        make.right.mas_equalTo(self.view.mas_right).inset(16);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.06);
        make.bottom.mas_equalTo(self.goOnAddBtn.mas_top).inset(10);
        
    }];
}


-(void)setBButtonTitle:(NSString *)bButtonTitle{
    
    [self.addCommodityBtn setTitle:bButtonTitle forState:UIControlStateNormal];
}


-(void)dealloc{
    
//    self.name = nil;
//    self.price = nil;
//    self.statusID = nil;
//    self.imgUrl = nil;
//    self.status = nil;
//    self.amount = nil;
//    self.commodityTypeText = nil;
//    self.ServicesId = nil;
//    self.ServiceTypeId = nil;
//    self.headerImg = nil;
//    self.bButtonTitle = nil;
//    self.aModel = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIButton *)headImgBtn{
    
    if (!_headImgBtn) {
        
        _headImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_headImgBtn sd_setImageWithURL:[NSURL URLWithString:_imgUrl] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"ic_head"] options:(SDWebImageRetryFailed)];
        
        [_headImgBtn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _headImgBtn;
}
-(UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5.f;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

-(UIButton *)addCommodityBtn{
    
    if (!_addCommodityBtn) {
        
        _addCommodityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCommodityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addCommodityBtn setBackgroundColor:[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f]];
        _addCommodityBtn.layer.cornerRadius = 5;
        _addCommodityBtn.layer.masksToBounds =YES;
        [_addCommodityBtn addTarget:self action:@selector(addCommodityEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addCommodityBtn;
}


-(UIButton *)goOnAddBtn{
    
    if (!_goOnAddBtn) {
        
        _goOnAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goOnAddBtn setTitle:@"继续添加" forState:UIControlStateNormal];
        [_goOnAddBtn setTitleColor:[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f] forState:UIControlStateNormal];
        _goOnAddBtn.layer.borderColor = [[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f] CGColor];
        [_goOnAddBtn addTarget:self action:@selector(addCommodityEvent:) forControlEvents:UIControlEventTouchUpInside];
        _goOnAddBtn.layer.borderWidth = 1.0f;
        _goOnAddBtn.layer.cornerRadius = 5.f;
        _goOnAddBtn.layer.masksToBounds = YES;
    }
    
    return _goOnAddBtn;
}

-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.scrollEnabled = NO;
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddCommodityCell class]) bundle:nil] forCellReuseIdentifier:@"contentCellID"];
    }
    return _contentTableView;
}
@end
