//
//  BaseViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong)id delegate;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentPage = 1;
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
    
    if (@available(iOS 11.0, *)) {

        self.navigationItem.leftBarButtonItems =@[[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction)]];
    }else{
            UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceBar.width = -20;  //iOS11 已失效
        self.navigationItem.leftBarButtonItems =@[spaceBar,[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction)]];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 if (self.navigationController.viewControllers.count > 1) {
  // 记录系统返回手势的代理
     _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
  // 设置系统返回手势的代理为当前控制器
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
  
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
 // 设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
    self.navigationController.interactivePopGestureRecognizer.delegate = _delegate;
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}
  
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

- (void)addRefreshParts{
    [self addRefreshFooter:NO];
    [self addRefreshHeader:NO];
}
#pragma mark private method
-(void)addRefreshFooter:(BOOL)beginRefresh{
    //上拉更多
    JJWeakSelf;
    self.baseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    if (beginRefresh) {
        [self.baseTableView.mj_footer beginRefreshing];
    }
}
-(void)addRefreshHeader:(BOOL)beginRefresh{
    JJWeakSelf;
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    if (beginRefresh) {
        [self.baseTableView.mj_header beginRefreshing];
    }
}

#pragma mark 下拉刷新数据
- (void)loadNewData{
    _currentPage=1;
    [self getDataList];
    [self.baseTableView.mj_header endRefreshing];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData{
    _currentPage+=1;
    [self getDataList];
    [self.baseTableView.mj_footer endRefreshing];
}

#pragma mark get请求数据时调用
- (void)getDataList{

    
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (void)setNavigationItem:(NSString *)title imageName:(NSString *)name position:(ItemPosition)position addTarget:(id)target action:(SEL)action{
    
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [item.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    switch (position) {
        case itemLeft:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
            break;
        case itemRight:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
            break;
        default:
            break;
    }
}

- (void)setNavigationItemWithView:(UIView *)view position:(ItemPosition)position{
    
    switch (position) {
        case itemLeft:
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
            break;
        case itemRight:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
            break;
        default:
            break;
    }
}


- (void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIBarButtonItem *)BarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton*bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:image forState:UIControlStateNormal];
    bt.frame=CGRectMake(0, 0, 44, 44);
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (@available(iOS 11.0, *)) {
        [bt setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];//解决iOS11 左侧按钮偏移的问题
    }
    return [[UIBarButtonItem alloc]initWithCustomView:bt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    NSLog(@"%@页面释放",[self class]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
