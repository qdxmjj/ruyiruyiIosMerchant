//
//  IncomeListTableViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeListTableViewController.h"
#import "OrderDetailsViewController.h"
#import "IncomeOrderCell.h"
#import "OrderFactory.h"
#import "IncomeModel.h"

#import "ServiceIncomeModel.h"
#import "CommodityIncomeModel.h"
#import "SellIncomeModel.h"
#import "AdditionalIncomeModel.h"
@interface IncomeListTableViewController ()

@property(nonatomic,strong)NSString *identifier;

@property(nonatomic,assign)NSInteger cellIndex;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger incomdeType;
@end

@implementation IncomeListTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style withIncometype:(incomeType )IncomeType{
    if (self = [super initWithStyle:style]) {
        
        switch (IncomeType) {
            case ServiceIncomeType:
                
                self.cellIndex = 0;
                self.identifier = @"serviceCellID";
                break;
            case CommodityIncomeType:
                
                
                self.cellIndex = 0;
                self.identifier = @"serviceCellID";
                break;
            case SellIncomeType:
                
                self.cellIndex = 1;
                self.identifier = @"sellCellID";
                break;
            case AdditionalIncomeType:
                
                self.cellIndex = 1;
                self.identifier = @"sellCellID";
                break;
            default:
                break;
        }
        self.incomdeType = IncomeType;
        self.page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRefreshControl];
    
    [self getIncomeInfo:[NSString stringWithFormat:@"%@-01 00:00:00",[JJTools getDateWithformatter:@"yyyy-MM"]] page:@"1"];
    
    self.tableView.tableFooterView = [UIView new];
}

-(void)loadNewData{
    JJWeakSelf
    
    self.page = 1;
    
    if (self.selectData.length>0) {
        
        [self getIncomeInfo:_selectData page:@"1"];

    }else{
        
        [self getIncomeInfo:[NSString stringWithFormat:@"%@-01 00:00:00",[JJTools getDateWithformatter:@"yyyy-MM"]] page:@"1"];
    }
    
    [weakSelf.tableView.mj_header endRefreshing];
}

-(void)loadMoreData{
    JJWeakSelf
    
    self.page ++;
    if (self.selectData.length>0) {
        
        [self getIncomeInfo:_selectData page:@"1"];
        
    }else{
        [self getIncomeInfo:[NSString stringWithFormat:@"%@-01 00:00:00",[JJTools getDateWithformatter:@"yyyy-MM"]] page:[NSString stringWithFormat:@"%ld",self.page]];
    }
    [weakSelf.tableView.mj_footer endRefreshing];
}

-(void)setSelectData:(NSString *)selectData{
    
    _selectData = selectData;
    
    [self getIncomeInfo:selectData page:@"1"];
}

-(void)getIncomeInfo:(NSString *)data page:(NSString *)page{
    
    NSString *incomeType ;
    
    switch (self.incomdeType) {
        case ServiceIncomeType:
            
            incomeType = @"/getStoreServiceEarnings";
            break;
        case CommodityIncomeType:
            
            incomeType = @"/getStoreSaleGoodsEarnings";
            break;
        case SellIncomeType:
            
            incomeType = @"/getStoreSaleShoeEarnings";
            break;
        case AdditionalIncomeType:
            
            incomeType = @"/getStoreInstallAppEarnings";
            break;
        default:
            break;
    }
    
    [JJRequest postRequest:incomeType params:@{@"reqJson":[JJTools convertToJsonData:@{@"storeId":[UserConfig storeID],@"date":data,@"page":page,@"rows":@"10"}]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ( self.page==1) {
            
            [self.dataArr removeAllObjects];
        }
        
        if ([[data objectForKey:@"rows"] count]<10 ||data == nil || data == [NSNull null]) {
            
            [self.tableView.mj_footer setHidden:YES];
        }
        
        for (NSDictionary *dic in [data objectForKey:@"rows"]) {
            
            //之前四种收益类型 数据格式不一样 key不一致 所以使用此方法创建model
            IncomeModel *model =  [IncomeModel initWithType:self.incomdeType];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArr addObject:model];
        }

        [self.tableView reloadData];
        
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
    
    IncomeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IncomeOrderCell" owner:self options:nil] objectAtIndex:_cellIndex];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setIncomeInfoByModel:self.dataArr[indexPath.row] withModelType:self.incomdeType];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJWeakSelf
    
    IncomeModel *model = self.dataArr[indexPath.row];
    
    NSInteger orderType = 0 ;
    
    NSString *orderNumber;
    switch (self.incomdeType) {
        case ServiceIncomeType:{
            
            ServiceIncomeModel *smodel = (ServiceIncomeModel *)model;
            
            orderType = [smodel.orderType integerValue];
            orderNumber = smodel.orderNo;
        }
            break;
        case CommodityIncomeType:{
            
            CommodityIncomeModel *cmodel = (CommodityIncomeModel *)model;
            
            orderType = [cmodel.orderType integerValue];
            orderNumber = cmodel.orderNo;
        }
            break;
        default:
            break;
    }
    
    OrderDetailsViewController *orderDetailsVC = [OrderFactory GenerateOrders:orderType orderStatus:ordersStateFulfill];
    
    if (orderDetailsVC == nil) {
        
        return;
    }
    [orderDetailsVC getOrdersInfo:orderNumber orderType:[NSString stringWithFormat:@"%ld",(long)orderType] storeId:[UserConfig storeID]];
    
    orderDetailsVC.popOrdersVCBlock = ^(BOOL isPop) {
        
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    
    [self.navigationController pushViewController:orderDetailsVC animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100.f;
}
-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
