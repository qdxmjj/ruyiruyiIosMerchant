//
//  StoresViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "StoresViewController.h"
#import "OrderDetailsViewController.h"
#import "OrderFactory.h"
#import "MainOrdersRequest.h"
#import "StoresHeadView.h"
#import "MainStoresCell.h"
#import "StoresModel.h"
@interface StoresViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UIImageView *backgroundImgView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger pageNumber;

@property(nonatomic,strong)StoresHeadView *headView;

@end

@implementation StoresViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableview];
    
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
    
    [self getStoresInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];
    [weakSelf.tableview.mj_header endRefreshing];
    
}

//上拉加载
-(void)loadMoreData{
    
    JJWeakSelf
    
    weakSelf.pageNumber +=1;
    
    [self getStoresInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];
    
    [weakSelf.tableview.mj_footer endRefreshing];
    
}

-(void)getStoresInfo:(NSString *)number{
    
    JJWeakSelf
    
    [MainOrdersRequest getStoreGeneralOrderByTypeWithInfo:@{@"page":number,@"rows":@"10",@"storeId":[UserConfig storeID],@"type":@"1"} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if (weakSelf.pageNumber==1) {
            
            [self.dataArr removeAllObjects];
        }
        
        [self.dataArr addObjectsFromArray: [data objectForKey:@"rows"]];
        
        self.headView.monthIncomeStr =[data objectForKey:@"monthIncome"] ;
        self.headView.totalIncomeStr = [data objectForKey:@"totalIncome"];
        
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
    
    MainStoresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storesCellID" forIndexPath:indexPath];
    
    StoresModel *model = [[StoresModel alloc] init];
    
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
    
    return 60.f;
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
        
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MainStoresCell class]) bundle:nil] forCellReuseIdentifier:@"storesCellID"];
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

-(StoresHeadView *)headView{
    
    if (!_headView) {
        
        _headView = [[StoresHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
    }
    return _headView;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
