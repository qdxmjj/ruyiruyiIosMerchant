//
//  MyOrdersViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "MyOrderTableViewController.h"


static CGFloat const topBtnH = 45;

@interface MyOrdersViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrView;

@property(nonatomic,strong)UIImageView *sliderView;//滑块

@property(nonatomic,strong)MyOrderTableViewController *AllOrdersVC;
@property(nonatomic,strong)MyOrderTableViewController *WaitReceiveVC;
@property(nonatomic,strong)MyOrderTableViewController *WaitService;
@property(nonatomic,strong)MyOrderTableViewController *CompletedVC;

@property(nonatomic,strong)NSArray *titleArr;

@end

@implementation MyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";

    self.titleArr = @[@"全部订单",@"进行中",@"待服务",@"已完成"];
    
    for (int i=0; i<4; i++) {
        
       UIButton *tabbarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tabbarBtn.frame=CGRectMake(SCREEN_WIDTH/4*i,0 , SCREEN_WIDTH/4, topBtnH);
        tabbarBtn.backgroundColor=[UIColor whiteColor];
        [tabbarBtn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [tabbarBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [tabbarBtn setTitleColor:[UIColor colorWithRed:80.f/255.f green:80.f/255.f blue:80.f/255.f alpha:1.f] forState:UIControlStateNormal];
        
        [tabbarBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tabbarBtn];
    }
    
    
    [self.view addSubview:self.contentScrView];
    [self.view addSubview:self.sliderView];

    [self addChildViewController:self.AllOrdersVC];
    
    [self.contentScrView addSubview:self.AllOrdersVC.view];
    
    [self addChildViewController:self.WaitReceiveVC];
    
    [self.contentScrView addSubview:self.WaitReceiveVC.view];

    [self addChildViewController:self.WaitService];
    
    [self.contentScrView addSubview:self.WaitService.view];
    
    [self addChildViewController:self.CompletedVC];
    
    [self.contentScrView addSubview:self.CompletedVC.view];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
 
}

#pragma mark event
-(void)topBtnPressed:(UIButton *)btn{
    
    [self.contentScrView setContentOffset:CGPointMake(btn.frame.origin.x*4, 0) animated:YES];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


    self.sliderView.mj_x = scrollView.contentOffset.x/4;
}


-(UIScrollView *)contentScrView{
    if (_contentScrView==nil) {
        
        _contentScrView=[UIScrollView new];
        if (KIsiPhoneX) {
            
            _contentScrView.frame = CGRectMake(0, topBtnH+2.5, SCREEN_WIDTH, SCREEN_HEIGHT-88-34-topBtnH);
        }else{
            _contentScrView.frame = CGRectMake(0, topBtnH+2.5, SCREEN_WIDTH, SCREEN_HEIGHT-64-topBtnH);
        }
        _contentScrView.delegate=self;
        _contentScrView.bounces=NO;
        _contentScrView.contentSize=CGSizeMake(SCREEN_WIDTH*4, 0);
        _contentScrView.backgroundColor=[UIColor lightGrayColor];
        _contentScrView.showsVerticalScrollIndicator=NO;
        _contentScrView.delegate=self;
        _contentScrView.showsHorizontalScrollIndicator=NO;
        _contentScrView.pagingEnabled=YES;
        
    }
    return _contentScrView;
}

-(UIImageView *)sliderView{
    
    if (_sliderView==nil) {
        
        _sliderView = [UIImageView new];
        if (KIsiPhoneX) {
            _sliderView.frame = CGRectMake(0, topBtnH, SCREEN_WIDTH/4, 2.5);
            
        }else{
            _sliderView.frame = CGRectMake(0, topBtnH, SCREEN_WIDTH/4, 2.5);
        }
        _sliderView.backgroundColor= JJThemeColor;
        
    }
    return _sliderView;
}


-(MyOrderTableViewController *)AllOrdersVC{
    if (!_AllOrdersVC) {
        
        _AllOrdersVC = [[MyOrderTableViewController alloc] initWithServiceType:ordersTypeAll];
        _AllOrdersVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        
    }
    return _AllOrdersVC;
}

-(MyOrderTableViewController *)WaitReceiveVC{
    if (!_WaitReceiveVC) {
        
        _WaitReceiveVC = [[MyOrderTableViewController alloc] initWithServiceType:ordersTypeWaitReceive];
        _WaitReceiveVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));

    }
    return _WaitReceiveVC;
}
-(MyOrderTableViewController *)WaitService{
    if (!_WaitService) {
        
        _WaitService = [[MyOrderTableViewController alloc] initWithServiceType:ordersTypeWaitService];
        _WaitService.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
    }
    return _WaitService;
}
-(MyOrderTableViewController *)CompletedVC{
    if (!_CompletedVC) {
        
        _CompletedVC = [[MyOrderTableViewController alloc] initWithServiceType:ordersTypeCompleted];
        _CompletedVC.view.frame = CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
    }
    return _CompletedVC;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
