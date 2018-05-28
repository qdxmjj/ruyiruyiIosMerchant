//
//  SellingTableViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/14.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SellingTableViewController.h"
#import "SellingCell.h"
#import "AddCommodityViewController.h"

@interface SellingTableViewController ()<UINavigationControllerDelegate,UINavigationBarDelegate>
{
    NSInteger pageNumber;
}

@property(nonatomic,assign)CommodityType commodityType;

@property(nonatomic,strong)NSMutableArray *sellingDataArr;//本页面数据源
@end

@implementation SellingTableViewController

-(instancetype)initWithServiceType:(CommodityType )listType{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        self.commodityType = listType;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];


    pageNumber=1;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SellingCell class]) bundle:nil] forCellReuseIdentifier:@"sellingCellID"];
    

    //上拉更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
        
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getStockByConditionWithPage:@"1" serviceTypeId:@"" servicesId:@"" stockStatus:[NSString stringWithFormat:@"%lu",self.commodityType]];
}
//下拉刷新
-(void)loadNewData{
    
    pageNumber=1;
    self.tableView.mj_footer.hidden = NO;
    if (!self.servicesId||!self.serviceTypeId) {
        
        [self getStockByConditionWithPage:[NSString stringWithFormat:@"%ld",(long)pageNumber] serviceTypeId:@"" servicesId:@"" stockStatus:[NSString stringWithFormat:@"%lu",(unsigned long)self.commodityType]];
    }else{
        
        [self getStockByConditionWithPage:[NSString stringWithFormat:@"%ld",(long)pageNumber] serviceTypeId:self.serviceTypeId servicesId:self.servicesId stockStatus:[NSString stringWithFormat:@"%lu",(unsigned long)self.commodityType]];
    }
    [self.tableView.mj_header endRefreshing];
    
}

//上拉加载
-(void)loadMoreData{
    
    JJWeakSelf
    
    pageNumber +=1;
    if (!self.servicesId||!self.serviceTypeId) {
        
        [self getStockByConditionWithPage:[NSString stringWithFormat:@"%ld",(long)pageNumber] serviceTypeId:@"" servicesId:@"" stockStatus:@"1"];
        
    }else{
        
        [self getStockByConditionWithPage:[NSString stringWithFormat:@"%ld",(long)pageNumber] serviceTypeId:self.serviceTypeId servicesId:self.servicesId stockStatus:@"1"];
    }
    [weakSelf.tableView.mj_footer endRefreshing];
    
}


//条件查询商品数据
-(void)getStockByConditionWithPage:(NSString *)page serviceTypeId:(NSString *)serviceTypeId servicesId:(NSString *)servicesId stockStatus:(NSString *)stockStatus{
    
    [MyCommodityRequest getStockByConditionWithIno:@{
                                                     @"page":page,
                                                     @"rows":@"10",
                                                     @"storeId":[UserConfig storeID],
                                                     @"serviceTypeId": serviceTypeId,
                                                     @"servicesId":servicesId,
                                                     @"stockStatus":stockStatus
                                                     } succrss:
     ^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
         NSLog(@"出售中商品信息：%@",data);
        
         if ( self->pageNumber==1) {
             
             [self.sellingDataArr removeAllObjects];
         }
         
         [self.sellingDataArr addObjectsFromArray:[data objectForKey:@"rows"]];
        
         if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
             
             [self.tableView.mj_footer setHidden:YES];
         }
         [self.tableView reloadData];
         
     } failure:^(NSError * _Nullable error) {
    }];
}

#pragma mark button event
-(void)PushEditCommodityVC:(UIButton *)sender{
    
    AddCommodityViewController *editCommodity = [[AddCommodityViewController alloc] init];
    
    NSDictionary *dic = self.sellingDataArr[sender.tag-10086];
    
    editCommodity.name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
    editCommodity.price =[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
        
    editCommodity.status =[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];

    editCommodity.amount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]];

    NSString *TypeID =  [dic objectForKey:@"serviceTypeId"];
    
    switch (TypeID.integerValue) {
        case 2:
            
         
            editCommodity.commodityTypeText = [self getServiceTypeContentText:@"汽车保养" serviceType:2 arrIndex:sender.tag-10086];
           
            break;
        case 3:
            
            editCommodity.commodityTypeText = [self getServiceTypeContentText:@"美容清洗" serviceType:3 arrIndex:sender.tag-10086];

            break;
        case 4:
            
            editCommodity.commodityTypeText = [self getServiceTypeContentText:@"安装" serviceType:4 arrIndex:sender.tag-10086];

            break;
        case 5:
            
            editCommodity.commodityTypeText = [self getServiceTypeContentText:@"轮胎服务" serviceType:5 arrIndex:sender.tag-10086];

            break;
            
        default:
            break;
    }
    
    editCommodity.ServicesId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"serviceId"]];

    editCommodity.ServiceTypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"serviceTypeId"]];

    editCommodity.headerImg = [dic objectForKey:@"imgUrl"];

    editCommodity.statusID = [dic objectForKey:@"id"];
    
    editCommodity.imgUrl = [dic objectForKey:@"imgUrl"];
    
    editCommodity.aModel = self.cModel;
    
    editCommodity.bButtonTitle = @"修改商品信息";
    
    [self.navigationController pushViewController:editCommodity animated:YES];

    self.hidesBottomBarWhenPushed = YES;
}


-(void)deleteCommodityEvent:(UIButton *)sender{
    
    NSDictionary *dic = self.sellingDataArr[sender.tag-10087];

    
    [MyCommodityRequest updateStockTypeWithInfo:@{@"id":[dic objectForKey:@"id"],@"status":@"3"} stock_img:nil succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        [self RefreshData];
        
    } failure:^(NSError * _Nullable error) {
        
        
    }];
    
    
}


-(void)RefreshData{
    
    [self.tableView.mj_header beginRefreshing];
}

//查询服务类型ID对应的服务类型文本内容，
-(NSString *)getServiceTypeContentText:(NSString *)text serviceType:(NSInteger )s arrIndex:(NSInteger )i{

    NSArray *arr;NSString *serviceContentText;
    
    NSDictionary *dataDic  = self.sellingDataArr[i];
    switch (s) {
        case 2:
            
            arr = self.cModel.qichebaoyang;
            break;
        case 3:
            arr = self.cModel.meirongqingxi;

            break;
        case 4:
            arr = self.cModel.anzhuang;

            break;
        case 5:
            arr = self.cModel.luntaifuwu;

            break;
            
        default:
            break;
    }

    NSString *datas = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"serviceId"]];
    
    for (NSDictionary *dic1 in arr) {
        
        if ([[dic1 objectForKey:@"serviceId"] longLongValue] == [datas longLongValue]) {
            
            serviceContentText = [NSString stringWithFormat:@"%@ %@",text,[dic1 objectForKey:@"serviceName"]];
        }
    }
    
    return serviceContentText;
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

    if (self.sellingDataArr.count<=0) {
        
        return 0;
    }
    return self.sellingDataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SellingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sellingCellID" forIndexPath:indexPath];
    
    sellingModel *model = [[sellingModel alloc] init];
    [model setValuesForKeysWithDictionary: self.sellingDataArr[indexPath.row]];
    [cell setValueWithModel:model];
    
    [cell.editBtn addTarget:self action:@selector(PushEditCommodityVC:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = 10086+indexPath.row;
    
    [cell.delBtn addTarget:self
                    action:@selector(deleteCommodityEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.delBtn.tag = 10087+indexPath.row;

    return cell;
}

-(NSMutableArray *)sellingDataArr{
    
    if (!_sellingDataArr) {
        
        _sellingDataArr = [NSMutableArray array];
    }
    
    return _sellingDataArr;
}
@end
