//
//  MyOrderTableViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyOrderTableViewController.h"

#import "MyOrdersDetailsController.h"

#import "MyOrdersCell.h"
@interface MyOrderTableViewController ()


@property(nonatomic,assign)MyOrdersTypeList ordersType;

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
    
    self.pageNumber = 1;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyOrdersCell class]) bundle:nil] forCellReuseIdentifier:@"myOrdersCellID"];

    
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
    
    [MyOrdersRequeset getStoreGeneralOrderByStateWithInfo:@{@"page":number,@"rows":@"10",@"storeId":[UserConfig storeID],@"state":[NSString stringWithFormat:@"%ld",self.ordersType]} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ( weakSelf.pageNumber==1) {
            [weakSelf.dataArr removeAllObjects];
        }
        
        [weakSelf.dataArr addObjectsFromArray:[data objectForKey:@"rows"]];

        if ([[data objectForKey:@"rows"] count]<10 ||data == nil) {
            
            [weakSelf.tableView.mj_footer setHidden:YES];
        }
        if (weakSelf.dataArr.count>0) {
            
            [weakSelf.tableView reloadData];
        }
        
        
        
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
    cell.ordersName.text = [self.dataArr[indexPath.row] objectForKey:@"orderName"];
    cell.ordersNumber.text = [self.dataArr[indexPath.row] objectForKey:@"orderNo"];
    cell.ordersPrice.text = [self.dataArr[indexPath.row] objectForKey:@"orderPrice"];
    cell.ordersStatus.text = [self.dataArr[indexPath.row] objectForKey:@"orderType"];
    [cell.ordersImg sd_setImageWithURL:[NSURL URLWithString:[self.dataArr[indexPath.row] objectForKey:@"orderImage"]]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyOrdersDetailsController *myOrdersDetailsVC = [[MyOrdersDetailsController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [myOrdersDetailsVC getMyOrdersDetailsInfo:[self.dataArr[indexPath.row] objectForKey:@"orderNo"] orderType:[self.dataArr[indexPath.row] objectForKey:@"orderType"] storeId:[UserConfig storeID]];
    
    [self.navigationController pushViewController:myOrdersDetailsVC animated:YES];
    
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

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    
    
    return _dataArr;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
