//
//  MyOrderTableViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyOrderTableViewController.h"

#import "OrderDetailsViewController.h"

#import "MyOrdersCell.h"

#import "OrderFactory.h"

#import "MyOrdersDetailsModel.h"
@interface MyOrderTableViewController ()


@property(nonatomic,assign)MyOrdersTypeList ordersType;

@property(nonatomic,strong)UIImageView *backgroundImgView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger pageNumber;

@end

@implementation MyOrderTableViewController

-(instancetype)initWithServiceType:(MyOrdersTypeList)listType{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        
        self.ordersType = listType;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImgView];

    self.pageNumber = 1;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyOrdersCell class]) bundle:nil] forCellReuseIdentifier:@"myOrdersCellID"];

    [self getMyOrdersInfo:@"1"];
    //上拉更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
        
    }];
}

//下拉刷新
-(void)loadNewData{
    
    JJWeakSelf
    weakSelf.pageNumber=1;
    weakSelf.tableView.mj_footer.hidden = NO;
    
    [weakSelf getMyOrdersInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];

    [weakSelf.tableView.mj_header endRefreshing];
    
}

//上拉加载
-(void)loadMoreData{
    
    JJWeakSelf
    
    weakSelf.pageNumber +=1;
  
    [weakSelf getMyOrdersInfo:[NSString stringWithFormat:@"%ld",(long)weakSelf.pageNumber]];

    [weakSelf.tableView.mj_footer endRefreshing];
}

-(void)getMyOrdersInfo:(NSString *)number{
    JJWeakSelf

    
    [MyOrdersRequeset getStoreGeneralOrderByStateWithInfo:@{@"page":number,@"rows":@"10",@"storeId":[UserConfig storeID],@"state":[NSString stringWithFormat:@"%ld",(long)self.ordersType]} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ( weakSelf.pageNumber==1) {
            [weakSelf.dataArr removeAllObjects];
        }
        
        [weakSelf.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];

        if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
            
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        if (self.dataArr.count>0 ){
            
            self.backgroundImgView.hidden = YES;
        }
        
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    MyOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myOrdersCellID" forIndexPath:indexPath];

    MyOrdersDetailsModel *model = [[MyOrdersDetailsModel alloc] init];
    
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    
    [cell setModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger orderType = [[self.dataArr[indexPath.row] objectForKey:@"orderType"] integerValue];
    
    NSInteger i =  [[self.dataArr[indexPath.row] objectForKey:@"orderState"] integerValue];

    OrderDetailsViewController *orderDetailsVC = [OrderFactory GenerateOrders:orderType orderStatus:i];
    
    if (orderDetailsVC == nil) {
        
        return;
    }
    
    [orderDetailsVC getOrdersInfo:[self.dataArr[indexPath.row] objectForKey:@"orderNo"] orderType:[self.dataArr[indexPath.row] objectForKey:@"orderType"] storeId:[UserConfig storeID]];
    
    orderDetailsVC.orderNO = [self.dataArr[indexPath.row] objectForKey:@"orderNo"];
    orderDetailsVC.popOrdersVCBlock = ^(BOOL isPop) {
        
        [self.tableView.mj_header beginRefreshing];
    };
    
    [self.navigationController pushViewController:orderDetailsVC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 130.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 5.f;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIImageView *)backgroundImgView{
    
    if (!_backgroundImgView) {
        
        _backgroundImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
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
@end
