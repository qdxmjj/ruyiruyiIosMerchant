//
//  MyOrdersDetailsController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyOrdersDetailsController.h"
#import "MainOrdersRequest.h"
#import "OrdersInfoCell.h"
@interface MyOrdersDetailsController ()

@property(nonatomic,strong)NSMutableArray *myOrdersContentArr;

@end

@implementation MyOrdersDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrdersInfoCell class]) bundle:nil] forCellReuseIdentifier:@"myOrdersDetailsCellID"];
}

-(void)getMyOrdersDetailsInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    
    
 [MainOrdersRequest getStoreOrderInfoByNoAndTypeWithInfo:@{@"orderNo":orderNo,@"orderType":orderType,@"storeId":storeId} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
     
     [self.myOrdersContentArr addObject:[data objectForKey:@"userName"]];
     [self.myOrdersContentArr addObject:[data objectForKey:@"userPhone"]];
     [self.myOrdersContentArr addObject:[data objectForKey:@"platNumber"]];
     [self.myOrdersContentArr addObject:[data objectForKey:@"orderNo"]];
     
     NSLog(@"d-----%@",self.myOrdersContentArr);
     
     [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            
            return 4;
            break;
        case 1:
            
            
            return 1;
            break;
            
        default:
            break;
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrdersInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myOrdersDetailsCellID" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            
            cell.titleLab.text = @[@"联系人",@"联系电话",@"车牌号",@"订单编号"][indexPath.row];
            if (self.myOrdersContentArr.count>0) {
                cell.contentLab.text = self.myOrdersContentArr[indexPath.row];
            }
            
            break;
            
        default:
            break;
    }

    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}
-(NSMutableArray *)myOrdersContentArr{
    
    if (!_myOrdersContentArr) {
        
        _myOrdersContentArr = [NSMutableArray array];
    }
    return _myOrdersContentArr;
}
@end
