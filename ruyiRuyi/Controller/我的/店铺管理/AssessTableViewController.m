//
//  AssessTableViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AssessTableViewController.h"
#import "AssessCell.h"
#import "ShopInfoRequest.h"

@interface AssessTableViewController ()
{
    NSInteger pageNumber;
}

@property(nonatomic,assign)BOOL isRefresh;
@property(nonatomic,strong)NSMutableArray *dataArr;//数据源

@end

@implementation AssessTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    pageNumber = 1;
    _isRefresh = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AssessCell class]) bundle:nil] forCellReuseIdentifier:@"assessCellID"];
    
    //上拉更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
      
        [self loadMoreData];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
    }];
    
    
}

-(void)loadNewData{
    
    self.isRefresh = YES;
    pageNumber=1;
    self.tableView.mj_footer.hidden = NO;
    [self getAssessInfo:[NSString stringWithFormat:@"%ld",(long)pageNumber]];
    [self.tableView.mj_header endRefreshing];

}

-(void)loadMoreData{
    
    JJWeakSelf
    self.isRefresh = YES;
    pageNumber +=1;
    [weakSelf getAssessInfo:[NSString stringWithFormat:@"%ld",(long)pageNumber]];
    [weakSelf.tableView.mj_footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getAssessInfo:(NSString *)number{
    
    if (self.isRefresh == NO) {
        
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在获取..." showView:self.view];
    
    JJWeakSelf
    [ShopInfoRequest getCommitByConditionWithInfo:@{@"page":number,@"rows":@"10",@"storeId":[UserConfig storeID],@"userId":@""} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ( self->pageNumber==1) {
            [self.dataArr removeAllObjects];
        }
        
        self.isRefresh = NO;
        
        [weakSelf.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];

        if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
            
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        [weakSelf.tableView reloadData];

    } failure:^(NSError * _Nullable error) {
        
        [MBProgressHUD hideWaitViewAnimated:self.view];
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
    
    AssessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assessCellID" forIndexPath:indexPath];

    AssessModel *model = [[AssessModel alloc] init];
    [model setValuesForKeysWithDictionary:self.dataArr[indexPath.row]];
    cell.model = model;
        
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",self.dataArr[indexPath.row]);
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //预估高度
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //计算后高度
    return UITableViewAutomaticDimension;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
