//
//  IncomeViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeViewController.h"
#import "IncomeListTableViewController.h"
#import "IncomeDatePickerView.h"

#define viewW self.view.frame.size.width
@interface IncomeViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,selectDateDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IncomeListTableViewController *serviceIncomeVC;

@property (strong, nonatomic) IncomeListTableViewController *commdityIncomeVC;

@property (strong, nonatomic) IncomeListTableViewController *sellIncomeVC;
@property (weak, nonatomic) IBOutlet UIView *sliderView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderViewX;

@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

@implementation IncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;

    self.view.backgroundColor = [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f];
    
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*3, 0);

    [self addChildViewController:self.serviceIncomeVC];
    [self.scrollView addSubview:self.serviceIncomeVC.view];
    [self addChildViewController:self.commdityIncomeVC];
    [self.scrollView addSubview:self.commdityIncomeVC.view];
    [self addChildViewController:self.sellIncomeVC];
    [self.scrollView addSubview:self.sellIncomeVC.view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDatePickerView)];
    
    [self.dateLab addGestureRecognizer:tapGesture];
    
    [JJRequest postRequest:@"/getStoreEarningsCountByMonth" params:@{@"reqJson":[JJTools convertToJsonData:@{@"storeId":[UserConfig storeID],@"date":@"2018-09-01 00:00:00"}]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSLog(@"%@",data);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}

-(void)viewDidLayoutSubviews{
    
    _serviceIncomeVC.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    
    
    _commdityIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    
    
    _sellIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
}
#pragma mark event
-(IBAction)topBtnPressed:(UIButton *)btn{
    
    [self.scrollView setContentOffset:CGPointMake(btn.frame.origin.x*3, 0) animated:YES];
}

#pragma mark dateLab addTapGesture

-(void)selectDatePickerView{
    
    IncomeDatePickerView *incomeDateView = [[IncomeDatePickerView alloc] initWithFrame:self.view.frame];
    incomeDateView.delegate = self;
    [incomeDateView showWithSuperView:self.view];
    
}

-(void)selectDateWithYear:(NSString *)year month:(NSString *)month{
    
    
    NSLog(@"%@ %@",year,month);
    NSString *str = [NSString stringWithFormat:@"%@年\n%@月",year,month];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
        
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, 5)];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25.f] range:NSMakeRange(6, 3)];

    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.f] range:NSMakeRange(str.length-1, 1)];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

    style.alignment = NSTextAlignmentCenter;

    [attributedStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,str.length)];

    self.dateLab.attributedText = attributedStr;
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    self.sliderView.mj_x = scrollView.contentOffset.x/3 + (((self.view.frame.size.width/3 - self.view.frame.size.width/5))/2);
    
    self.sliderViewX.constant = scrollView.contentOffset.x/3;
    
//    NSLog(@"%f",scrollView.contentOffset.x);
//
//    printf("%f",scrollView.contentOffset.x/3);
    
}


-(IncomeListTableViewController *)serviceIncomeVC{
    
    if (!_serviceIncomeVC) {
        
        _serviceIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIdentifier:@"serviceCellID"];
//        _serviceIncomeVC.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    }
    return _serviceIncomeVC;
}
-(IncomeListTableViewController *)commdityIncomeVC{
    
    if (!_commdityIncomeVC) {
        
        _commdityIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIdentifier:@"serviceCellID"];
//        _commdityIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    }
    return _commdityIncomeVC;
}
-(IncomeListTableViewController *)sellIncomeVC{
    
    if (!_sellIncomeVC) {
        
        _sellIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIdentifier:@"sellCellID"];
//        _sellIncomeVC.tableView.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));
    }
    return _sellIncomeVC;
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
