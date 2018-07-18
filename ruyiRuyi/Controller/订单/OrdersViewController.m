//
//  OrdersViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrdersViewController.h"
#import "FirstReplaceOrdersViewController.h"
#import "OrderStatusTypeViewController.h"

#import "MainOrdersRequest.h"
#import "OrderHanderView.h"
#import "OrdersModel.h"
#import "OrderCell.h"
#import "OrderDetailsViewController.h"
#import "OrderFactory.h"
@interface OrdersViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property(nonatomic,strong)OrderHanderView *handerView;

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UIImageView *backgroundImgView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger pageNumber;

@end

@implementation OrdersViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self.view addSubview:self.handerView];
    [self.view addSubview:self.tableview];
//    [self.view addSubview:self.backgroundImgView];
    
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCell class]) bundle:nil] forCellReuseIdentifier:@"ordersCellID"];
    
    //上拉更多
    self.tableview.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
        
    }];
    
    [self.tableview.mj_header beginRefreshing];
}

//下拉刷新
-(void)loadNewData{
    
    JJWeakSelf
    weakSelf.pageNumber=1;
    weakSelf.tableview.mj_footer.hidden = NO;
    
    [weakSelf getMainOrdersInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];
    
    [weakSelf.tableview.mj_header endRefreshing];
    
}

//上拉加载
-(void)loadMoreData{
    
    JJWeakSelf
    
    weakSelf.pageNumber +=1;
    
    [weakSelf getMainOrdersInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];
    
    [weakSelf.tableview.mj_footer endRefreshing];
    
}

-(void)RefreshData{
    
    [self.tableview.mj_header beginRefreshing];
    
}

-(void)getMainOrdersInfo:(NSString *)number{
    
    JJWeakSelf
    
    [MainOrdersRequest getStoreGeneralOrderByTypeWithInfo:@{@"page":number,@"rows":@"10",@"storeId":[UserConfig storeID],@"type":@"2"} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if (weakSelf.pageNumber==1) {
            
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray: [data objectForKey:@"rows"]];
        
        self.handerView.unfinishedNum =[data objectForKey:@"unfinishedNum"] ;
        self.handerView.finishedNum = [data objectForKey:@"finishedNum"];
        self.handerView.totalNum = [data objectForKey:@"totalNum"];
        
        if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
            
            [weakSelf.tableview.mj_footer setHidden:YES];
        }
        if (self.dataArr.count>0 ){
            
            self.backgroundImgView.hidden = YES;
        }
        
        
        [weakSelf.tableview reloadData];
        

        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ordersCellID" forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    OrdersModel *model = [[OrdersModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    [cell setModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJWeakSelf
    
    NSInteger i =  [[self.dataArr[indexPath.row] objectForKey:@"orderState"] longLongValue];
    NSInteger orderType = [[self.dataArr[indexPath.row] objectForKey:@"orderType"] longLongValue];
    
    OrderDetailsViewController *orderDetailsVC = [OrderFactory GenerateOrders:orderType orderStatus:i];
    if (orderDetailsVC == nil) {
        
        return;
    }
    [orderDetailsVC getOrdersInfo:[self.dataArr[indexPath.row] objectForKey:@"orderNo"] orderType:[self.dataArr[indexPath.row] objectForKey:@"orderType"] storeId:[UserConfig storeID]];
    
    orderDetailsVC.popOrdersVCBlock = ^(BOOL isPop) {
        
        [weakSelf.tableview.mj_header beginRefreshing];

    };
    
    [self.navigationController pushViewController:orderDetailsVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.f;
}

-(void)pushOrdersStatusTypeVC:(UIButton *)sender{
    
    OrderStatusTypeViewController *ostVC = [[OrderStatusTypeViewController alloc] init];

    if (sender == self.handerView.leftBtn) {
        
        ostVC.status = @"2";
    }
    
    [self.navigationController pushViewController:ostVC animated:YES];
}


-(OrderHanderView *)handerView{
    
    if (!_handerView) {
        
        _handerView = [[OrderHanderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
        
        [_handerView.leftBtn addTarget:self action:@selector(pushOrdersStatusTypeVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [_handerView.rigBtn addTarget:self action:@selector(pushOrdersStatusTypeVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handerView;
}

-(UITableView *)tableview{
    
    if (!_tableview) {
        
        CGRect frame;

        if (KIsiPhoneX) {
            frame = CGRectMake(0, SCREEN_HEIGHT*0.4, SCREEN_WIDTH, SCREEN_HEIGHT*0.6-34-49);
        }else{
            
            frame = CGRectMake(0, SCREEN_HEIGHT*0.4, SCREEN_WIDTH, SCREEN_HEIGHT*0.6-49);
        }
        _tableview = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview addSubview:self.backgroundImgView];
        
    }
    
    return _tableview;
}

-(UIImageView *)backgroundImgView{
    
    if (!_backgroundImgView) {
        
        _backgroundImgView = [[UIImageView alloc] initWithFrame:self.tableview.bounds];
        _backgroundImgView.backgroundColor = [UIColor whiteColor];
        [_backgroundImgView setImage:[UIImage imageNamed:@"ic_dakongbai"]];
        _backgroundImgView.contentMode = UIViewContentModeCenter;
    }
    
    return _backgroundImgView;
}
-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
@end
