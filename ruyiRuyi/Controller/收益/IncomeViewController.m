//
//  IncomeViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeViewController.h"
#import "IncomeDatePickerView.h"
#import "WithdrawViewController.h"
#import "IncomeListTableViewController.h"

@interface IncomeViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,selectDateDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//服务收益
@property (strong, nonatomic) IncomeListTableViewController *serviceIncomeVC;
//商品收益
@property (strong, nonatomic) IncomeListTableViewController *commdityIncomeVC;
//销售收益
@property (strong, nonatomic) IncomeListTableViewController *sellIncomeVC;
//额外收益
@property (strong, nonatomic) IncomeListTableViewController *additionalIncomeVC;

//收益label
@property (weak, nonatomic) IBOutlet UILabel *serviceIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *commodityIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *additionalIncomeLab;
@property (weak, nonatomic) IBOutlet UILabel *totalIncomeLab;

//滚动条
@property (weak, nonatomic) IBOutlet UIView *sliderView;
//滚动条X
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderViewX;
//筛选日期
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

@implementation IncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;

    self.view.backgroundColor = [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f];
    
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*4, 0);

    [self addChildViewController:self.serviceIncomeVC];
    [self.scrollView addSubview:self.serviceIncomeVC.view];
    [self addChildViewController:self.commdityIncomeVC];
    [self.scrollView addSubview:self.commdityIncomeVC.view];
    [self addChildViewController:self.sellIncomeVC];
    [self.scrollView addSubview:self.sellIncomeVC.view];
    [self addChildViewController:self.additionalIncomeVC];
    [self.scrollView addSubview:self.additionalIncomeVC.view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDatePickerView)];
    
    [self.dateLab addGestureRecognizer:tapGesture];
    
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    self.dateLab.attributedText = [self dateAttributedStringWithYear:[NSString stringWithFormat:@"%ld",components.year] month:[NSString stringWithFormat:@"%ld",components.month]];

    [self getIncomeInfoWithDate:[NSString stringWithFormat:@"%@-01 00:00:00",[JJTools getDateWithformatter:@"yyyy-MM"]]];
}

-(void)viewDidLayoutSubviews{
    
    _serviceIncomeVC.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    
    _commdityIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    
    _sellIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    
    _additionalIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
}

#pragma mark event
-(IBAction)topBtnPressed:(UIButton *)btn{
    
    [self.scrollView setContentOffset:CGPointMake(btn.frame.origin.x*4, 0) animated:YES];
}

- (IBAction)withdrawEvent:(UIButton *)sender {
 
    [self.navigationController pushViewController:[[WithdrawViewController alloc]init] animated:YES];
}
#pragma mark dateLab addTapGesture
-(void)selectDatePickerView{
    
    IncomeDatePickerView *incomeDateView = [[IncomeDatePickerView alloc] initWithFrame:self.view.frame];
    incomeDateView.delegate = self;
    [incomeDateView showWithSuperView:self.view];
}

-(void)getIncomeInfoWithDate:(NSString *)date{
    
    //店铺收益
    [JJRequest postRequest:@"/getStoreEarningsCountByMonth" params:@{@"reqJson":[JJTools convertToJsonData:@{@"storeId":[UserConfig storeID],@"date":date}]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        self.serviceIncomeLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"store_service_earnings"]];
        self.commodityIncomeLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"store_goods_earnings"]];
        self.saleIncomeLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"store_sale_earnings"]];
        self.additionalIncomeLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"store_app_install_earnings"]];

        CGFloat totalIncome = [[data objectForKey:@"store_service_earnings"] floatValue] +[[data objectForKey:@"store_goods_earnings"] floatValue] + [[data objectForKey:@"store_sale_earnings"] floatValue] + [[data objectForKey:@"store_app_install_earnings"] floatValue];
        self.totalIncomeLab.text = [NSString stringWithFormat:@"%.2f",totalIncome];
        NSLog(@"%@",data);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)selectDateWithYear:(NSString *)year month:(NSString *)month{
    
    self.dateLab.attributedText = [self dateAttributedStringWithYear:year month:month];

    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-01",year,month];
    
    [self getIncomeInfoWithDate:[NSString stringWithFormat:@"%@ 00:00:00",dateStr]];

    self.serviceIncomeVC.selectData = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    self.commdityIncomeVC.selectData = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    self.sellIncomeVC.selectData = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    self.additionalIncomeVC.selectData = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    self.sliderView.mj_x = scrollView.contentOffset.x/4 + (((self.view.frame.size.width/4 - self.view.frame.size.width/5))/2);
    
    self.sliderViewX.constant = scrollView.contentOffset.x/4;
    
//    NSLog(@"%f",scrollView.contentOffset.x);
//
//    printf("%f",scrollView.contentOffset.x/3);
}


-(IncomeListTableViewController *)serviceIncomeVC{
    
    if (!_serviceIncomeVC) {
        
        _serviceIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIncometype:ServiceIncomeType];
    }
    return _serviceIncomeVC;
}
-(IncomeListTableViewController *)commdityIncomeVC{
    
    if (!_commdityIncomeVC) {
        
        _commdityIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIncometype:CommodityIncomeType];
    }
    return _commdityIncomeVC;
}
-(IncomeListTableViewController *)sellIncomeVC{
    
    if (!_sellIncomeVC) {
        
        _sellIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIncometype:SellIncomeType];
    }
    return _sellIncomeVC;
}
-(IncomeListTableViewController *)additionalIncomeVC{
    
    if (!_additionalIncomeVC) {
        
        _additionalIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIncometype:AdditionalIncomeType];
    }
    return _additionalIncomeVC;
}

-(NSMutableAttributedString *)dateAttributedStringWithYear:(NSString *)year month:(NSString *)month{
    
    NSString *str = [NSString stringWithFormat:@"%@年\n%@月",year,month];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, 5)];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25.f] range:NSMakeRange(6, 3)];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.f] range:NSMakeRange(str.length-1, 1)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.alignment = NSTextAlignmentCenter;
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,str.length)];
    
    
    return attributedStr;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
