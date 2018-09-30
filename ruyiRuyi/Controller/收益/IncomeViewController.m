//
//  IncomeViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeViewController.h"
#import "IncomeListTableViewController.h"
@interface IncomeViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IncomeListTableViewController *serviceIncomeVC;

@property (strong, nonatomic) IncomeListTableViewController *commdityIncomeVC;

@property (strong, nonatomic) IncomeListTableViewController *sellIncomeVC;
@property (weak, nonatomic) IBOutlet UIView *sliderView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderViewX;

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
        _serviceIncomeVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));

    }
    return _serviceIncomeVC;
}
-(IncomeListTableViewController *)commdityIncomeVC{
    
    if (!_commdityIncomeVC) {
        
        _commdityIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIdentifier:@"serviceCellID"];
        _commdityIncomeVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));

    }
    return _commdityIncomeVC;
}
-(IncomeListTableViewController *)sellIncomeVC{
    
    if (!_sellIncomeVC) {
        
        _sellIncomeVC = [[IncomeListTableViewController alloc] initWithStyle:UITableViewStylePlain withIdentifier:@"sellCellID"];
        _sellIncomeVC.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(self.scrollView.frame));

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
