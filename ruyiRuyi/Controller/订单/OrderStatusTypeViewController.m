//
//  OrderStatusTypeViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/30.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderStatusTypeViewController.h"
#import "OrderStatusTypeTableVIewController.h"
static const CGFloat topBtnH = 50;

@interface OrderStatusTypeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrView;

@property(nonatomic,strong)UIImageView *sliderView;//滑块

@property(nonatomic,strong)OrderStatusTypeTableVIewController *undoneOrdersVC;
@property(nonatomic,strong)OrderStatusTypeTableVIewController *completedOrdersVC;

@property(nonatomic,strong)UIView *contenView;
@end

@implementation OrderStatusTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"商品管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray  *titleArr = @[@"已完成",@"未完成"];
    
    for (int i=0; i<=1; i++) {
        
        UIButton *tabbarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tabbarBtn.frame=CGRectMake(SCREEN_WIDTH/2*i,0 , SCREEN_WIDTH/2, topBtnH);
        tabbarBtn.backgroundColor=[UIColor whiteColor];
        [tabbarBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [tabbarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabbarBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [tabbarBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tabbarBtn];
    }

    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.contentScrView];
    
    [self addChildViewController:self.undoneOrdersVC];
    [self.contentScrView addSubview:self.undoneOrdersVC.view];
    
    [self addChildViewController:self.completedOrdersVC];
    [self.contentScrView addSubview:self.completedOrdersVC.view];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)setStatus:(NSString *)status{

    if ([status isEqualToString:@"2"]) {

        [self.contentScrView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];

    }
}

#pragma mark topButton event
-(void)topBtnPressed:(UIButton *)btn{
    
    [self.contentScrView setContentOffset:CGPointMake(btn.frame.origin.x*2, 0) animated:YES];
}


#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.sliderView.mj_x = scrollView.contentOffset.x/2;
    
}


#pragma mark 视图加载
-(UIScrollView *)contentScrView{
    if (_contentScrView==nil) {
        
        _contentScrView=[UIScrollView new];
        if (KIsiPhoneX) {
            
            _contentScrView.frame = CGRectMake(0, topBtnH+2, SCREEN_WIDTH, SCREEN_HEIGHT-88-topBtnH);
        }else{
            _contentScrView.frame = CGRectMake(0, topBtnH+2, SCREEN_WIDTH, SCREEN_HEIGHT-64-topBtnH);
        }
        _contentScrView.delegate=self;
        _contentScrView.bounces=NO;
        _contentScrView.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
        _contentScrView.backgroundColor=[UIColor lightGrayColor];
        _contentScrView.showsVerticalScrollIndicator=NO;
        _contentScrView.delegate=self;
        _contentScrView.showsHorizontalScrollIndicator=NO;
        _contentScrView.pagingEnabled=YES;
        
    }
    return _contentScrView;
}

-(OrderStatusTypeTableVIewController *)undoneOrdersVC{
    if (!_undoneOrdersVC) {
        
        _undoneOrdersVC = [[OrderStatusTypeTableVIewController alloc] initWithServiceType:2];
        _undoneOrdersVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        
    }
    return _undoneOrdersVC;
}

-(OrderStatusTypeTableVIewController *)completedOrdersVC{
    if (!_completedOrdersVC) {
        
        _completedOrdersVC = [[OrderStatusTypeTableVIewController alloc] initWithServiceType:1];
        _completedOrdersVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        
    }
    return _completedOrdersVC;
}



-(UIImageView *)sliderView{
    if (_sliderView==nil) {
        _sliderView = [UIImageView new];
        _sliderView.frame = CGRectMake(0, topBtnH, SCREEN_WIDTH/2, 2);
        _sliderView.backgroundColor=[UIColor colorWithRed:255.f/255.f green:102.f/255.0 blue:35.f/255.0 alpha:1];
    }
    return _sliderView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
