//
//  MyShopViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyShopViewController.h"
#import "ShopDetailsViewController.h"
#import "AssessTableViewController.h"


static const CGFloat topBtnH = 45;

@interface MyShopViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrView;//主view

@property(nonatomic,strong)UIImageView *sliderView;//滑块

@property(nonatomic,strong)ShopDetailsViewController *shopVC;//商店详情

@property(nonatomic,strong)AssessTableViewController *assessVC;//店铺评价

@end

@implementation MyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"管理店铺";
    
    NSArray  *titleArr = @[@"店铺详情",@"店铺评价"];
    
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
    
    [self addChildViewController:self.shopVC];
    [self.contentScrView addSubview:self.shopVC.view];
    
    [self addChildViewController:self.assessVC];
    [self.contentScrView addSubview:self.assessVC.tableView];
}

#pragma mark topButton event
-(void)topBtnPressed:(UIButton *)btn{
    
    [self.contentScrView setContentOffset:CGPointMake(btn.frame.origin.x*2, 0) animated:YES];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.sliderView.mj_x = scrollView.contentOffset.x/2;
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    if (scrollView.contentOffset.x == pageWidth) {
        NSLog(@"当前显示评价页面");
        
        [self.assessVC getAssessInfo:@"1"];
    }
    
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//
//    NSLog(@"scrollViewWillEndDragging");
//
//    if (self.assessVC.isViewLoaded && self.assessVC.view.window) {
//
//        NSLog(@"当前显示评价页面");
//    }
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//
//    NSLog(@"scrollViewDidEndScrollingAnimation");
//    // 有效的动画方法为：
//    //    - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated 方法
//    //    - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated 方法
//
//    if (self.assessVC.isViewLoaded && self.assessVC.view.window) {
//
//        NSLog(@"当前显示评价页面");
//    }
//}

#pragma mark 视图加载
-(UIScrollView *)contentScrView{
    if (_contentScrView==nil) {

        _contentScrView=[UIScrollView new];
        _contentScrView.delegate=self;
        _contentScrView.bounces=NO;
        if (KIsiPhoneX) {
            _contentScrView.frame = CGRectMake(0, topBtnH+2, SCREEN_WIDTH, SCREEN_HEIGHT-88-34-topBtnH);
        }else{
            _contentScrView.frame = CGRectMake(0, topBtnH+2, SCREEN_WIDTH, SCREEN_HEIGHT-64-topBtnH);
        }
        _contentScrView.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
        _contentScrView.backgroundColor=[UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1.f];
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
        _sliderView.frame =CGRectMake(0, topBtnH, SCREEN_WIDTH/2, 2);
        _sliderView.backgroundColor = JJThemeColor;
    }
    return _sliderView;
}
-(ShopDetailsViewController *)shopVC{
    if (!_shopVC) {
        
        _shopVC = [[ShopDetailsViewController alloc] init];
        _shopVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
    }
    return _shopVC;
}
-(AssessTableViewController *)assessVC{
    if (!_assessVC) {
        
        _assessVC = [[AssessTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        _assessVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 2, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
    }
    return _assessVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
