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


@interface AddCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,addCommodityCellDelegate,UITextViewDelegate>
{
    BOOL isEditPhotos;
    
    CGFloat cellHeight;
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

@property(nonatomic,strong)UITextField *originalPriceField;

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
    
    if (self.isSale) {
        
        cellHeight = 40;
        
        self.titleArr =@[@"商品名称",@"单价",@"原价",@"设为特价商品",@"商品分类",@"库存",@"商品状态",@"商品描述"];
        self.textArr = @[@"请在此输入商品名称",@"请在此输入商品单价",@"请在此输入商品原价",@"",@"请在此选择商品分类",@"请在此输入商品库存",@"请在此选择商品状态",@"请在此输入商品描述"];
    }else{
        self.titleArr =@[@"商品名称",@"单价",@"",@"设为特价商品",@"商品分类",@"库存",@"商品状态",@"商品描述"];
        self.textArr = @[@"请在此输入商品名称",@"请在此输入商品单价",@"",@"",@"请在此选择商品分类",@"请在此输入商品库存",@"请在此选择商品状态",@"请在此输入商品描述"];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.titleArr.count;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath.row) {
        case 0:case 1:case 2:case 4:case 5:case 6:
            identifier = @"addGoodsCell1";
            index = 0;
            break;
        case 3:
            identifier = @"addGoodsCell2";
            index = 1;
            break;
        default:
            identifier = @"addGoodsCell3";
            index = 2;
            break;
    }
    
    AddCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddCommodityCell" owner:self options:nil] objectAtIndex:index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
            cell.textField.text = self.name;
            self.nameField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.textField.placeholder = self.textArr[indexPath.row];

            break;
        case 1:
            cell.textField.text = self.price;
            cell.textField.delegate = self;
            self.priceField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.textField.placeholder = self.textArr[indexPath.row];

            break;
        case 2:
            
            cell.textField.text = self.OriginalPrice;
            cell.textField.delegate = self;
            self.originalPriceField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            if (self.isSale) {
                
                cell.titleLab.textColor = [UIColor lightGrayColor];
                cell.titleLab.textAlignment = NSTextAlignmentCenter;
                cell.titleLab.font = [UIFont systemFontOfSize:13.f];
            }
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.textField.placeholder = self.textArr[indexPath.row];
            
            break;
        case 3:
            
            cell.cell1TitleLab.text = self.titleArr[indexPath.row];
            cell.delegate = self;
            
            if (self.isSale) {
                cell.addCommoditySwitch.on = YES;
            }
            
            break;
        case 4:
            cell.textField.text = self.commodityTypeText;
            cell.textField.delegate = self;
            self.commodityTypeField = cell.textField;
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.textField.placeholder = self.textArr[indexPath.row];

            break;
        case 5:
            cell.textField.text = self.amount;
            cell.textField.delegate = self;
            self.amountField = cell.textField;
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.textField.placeholder = self.textArr[indexPath.row];

            break;
        case 6:
            if (self.status) {
                
                cell.textField.text = [self.status longLongValue] == 1 ?@"在售":@"已下架";;
            }
            cell.textField.delegate = self;
            self.statusField = cell.textField;
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.textField.placeholder = self.textArr[indexPath.row];

            break;
        case 7:
            cell.titleLab.text = self.titleArr[indexPath.row];
            cell.contentLab.delegate = self;
            cell.contentLab.text = self.goods_description;
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)addCommodityCell:(AddCommodityCell *)cell isSpecialPriceGoods:(BOOL)on{
    self.isSale = on;
    if (on) {
        self.titleArr =@[@"商品名称",@"单价",@"原价",@"设为特价商品",@"商品分类",@"库存",@"商品状态",@"商品描述"];
        self.textArr = @[@"请在此输入商品名称",@"请在此输入商品单价",@"请在此输入商品原价",@"",@"请在此选择商品分类",@"请在此输入商品库存",@"请在此选择商品状态",@"请在此输入商品描述"];
        cellHeight = 40.f;
    }else{
        
        self.titleArr =@[@"商品名称",@"单价",@"",@"设为特价商品",@"商品分类",@"库存",@"商品状态",@"商品描述"];
        self.textArr = @[@"请在此输入商品名称",@"请在此输入商品单价",@"",@"",@"请在此选择商品分类",@"请在此输入商品库存",@"请在此选择商品状态",@"请在此输入商品描述"];
        cellHeight = 0.f;
    }

    [self.contentTableView reloadData];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    if (indexPath.row == 3) {
//
//        AddCommodityCell *cell1 = (AddCommodityCell *)cell;
//
//        cell1.delegate = nil;
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 7) {
        
        return 100;
    }else if (indexPath.row == 2){
        
        return cellHeight;
    }else{
        return 40.f;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma mark textfield dalegate
///限制输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.priceField]||[textField isEqual:self.amountField] || [textField isEqual:self.originalPriceField]) {

        return [self validateNumber:string];
    }
    
    return YES;
}
///输入实时赋值
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.markedTextRange == nil) {
        
        
        if ([textField isEqual:self.nameField]) {
            
            self.name = textField.text;
            
        }else if ([textField isEqual:self.priceField]){
            

            self.price = textField.text;
            
        }else if ([textField isEqual:self.amountField]){
            
            self.amount = textField.text;
            
        }else if ([textField isEqual:self.originalPriceField]){
            
            self.OriginalPrice = textField.text;
        }else{
            
        }
    }
    
    NSLog(@"text:%@",self.name);

}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.markedTextRange == nil) {
        NSLog(@"text:%@", textView.text);
        
        self.goods_description = textView.text;
    }
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
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
    
    if (!self.ServicesId||!self.ServiceTypeId||!self.status||!self.name||!self.price||!self.amount||!self.OriginalPrice) {
        
        [MBProgressHUD showTextMessage:@"商品信息不完整!"];
        return;

    }
    
    if (self.ServicesId.length<=0||self.ServiceTypeId.length<=0||self.status.length<=0||self.name.length<=0||self.price.length<=0||self.amount.length<=0||self.OriginalPrice.length<=0) {
        
        [MBProgressHUD showTextMessage:@"商品信息不完整!"];
        return;
        
    }
    
    if (self.goods_description.length<=0) {
        
        [MBProgressHUD showTextMessage:@"请输入描述信息"];
        return;
    }

    if ([self.amount isEqualToString:@"0"]) {
        
        [MBProgressHUD showTextMessage:@"库存不能为0！"];
        return;
    }
    
    if([self.price rangeOfString:@"."].location == NSNotFound) {
        
        NSLog(@"str1不包含str2");
        
    } else {
        NSArray *priceArr = [self.price componentsSeparatedByString:@"."];
        
        NSString *priceX = priceArr[1];
        if (priceX.length>2 || priceArr.count>2 ||priceX.length == 0) {
            
            [MBProgressHUD showTextMessage:@"请输入正确的价格！"];
            return;
        }
    }
    
    if ([self.price componentsSeparatedByString:@"."]) {
        
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
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.statusID forKey:@"id"];
        [params setObject:[UserConfig storeID] forKey:@"storeId"];
        [params setObject:self.name forKey:@"name"];
        [params setObject:self.ServiceTypeId forKey:@"serviceTypeId"];
        [params setObject:self.ServicesId forKey:@"serviceId"];
        [params setObject:self.amount forKey:@"amount"];
        [params setObject:self.price forKey:@"price"];
        [params setObject:self.status forKey:@"status"];
        [params setObject:self.imgUrl forKey:@"imgUrl"];
        [params setObject:self.goods_description forKey:@"stockDesc"];
        if (self.isSale) {
            
            [params setObject:self.OriginalPrice forKey:@"originalPrice"];
            [params setObject:@"1" forKey:@"discountFlag"];
        }else{
            
            [params setObject:@"0" forKey:@"discountFlag"];
        }

        
        [MyCommodityRequest updateStockTypeWithInfo:params
          stock_img:imgArr succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
           
              [hud hideAnimated:YES];
              
              [self.navigationController popViewControllerAnimated:YES];
            
          } failure:^(NSError * _Nullable error) {
              [hud hideAnimated:YES];

          }];
        
    }else if([sender.titleLabel.text isEqualToString:@"继续添加"]){
        
        //继续添加商品商品
        imgArr=@[[JJFileParam fileConfigWithfileData:licenseData name:@"stock_img" fileName:@"shangpin.png" mimeType:@"image/jpg/png/jpeg"]];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[UserConfig storeID] forKey:@"storeId"];
        [params setObject:self.name forKey:@"name"];
        [params setObject:self.ServiceTypeId forKey:@"serviceTypeId"];
        [params setObject:self.ServicesId forKey:@"serviceId"];
        [params setObject:self.amount forKey:@"amount"];
        [params setObject:self.price forKey:@"price"];
        [params setObject:self.status forKey:@"status"];
        [params setObject:self.goods_description forKey:@"stockDesc"];
        if (self.isSale) {
            
            [params setObject:self.OriginalPrice forKey:@"originalPrice"];
            [params setObject:@"1" forKey:@"discountFlag"];
        }else{
            
            [params setObject:@"0" forKey:@"discountFlag"];
        }
        
        [MyCommodityRequest addCommodityWithInfo:params
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
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[UserConfig storeID] forKey:@"storeId"];
            [params setObject:self.name forKey:@"name"];
            [params setObject:self.ServiceTypeId forKey:@"serviceTypeId"];
            [params setObject:self.ServicesId forKey:@"serviceId"];
            [params setObject:self.amount forKey:@"amount"];
            [params setObject:self.price forKey:@"price"];
            [params setObject:self.status forKey:@"status"];
            [params setObject:self.goods_description forKey:@"stockDesc"];
            if (self.isSale) {
                
                [params setObject:self.OriginalPrice forKey:@"originalPrice"];
                [params setObject:@"1" forKey:@"discountFlag"];
            }else{
                
                [params setObject:@"0" forKey:@"discountFlag"];
            }
            
            
            [MyCommodityRequest addCommodityWithInfo:params
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
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    }
    return _contentTableView;
}
@end
