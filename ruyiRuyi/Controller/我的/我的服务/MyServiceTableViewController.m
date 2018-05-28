//
//  MyServiceTableViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyServiceTableViewController.h"
#import "MyServiceCell.h"
@interface MyServiceTableViewController ()

@property(nonatomic,assign)ServiceTypeList serviecType;

@property(nonatomic,strong)NSArray *dataArr;


@end

@implementation MyServiceTableViewController

-(instancetype)initWithServiceType:(ServiceTypeList)listType{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        self.serviecType = listType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyServiceCell class]) bundle:nil] forCellReuseIdentifier:@"myServiceCellID"];

}


-(void)getServiceList{
    
    
    [ServiceRequest getStoreServiceSubClassWithInfo:@{@"storeId":[UserConfig storeID],@"serviceTypeId":@(self.serviecType)} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        self.dataArr = data;
        
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    MyServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myServiceCellID" forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.serviceLab.text = [self.dataArr[indexPath.row] objectForKey:@"name"];
    
    if ([[self.dataArr[indexPath.row] objectForKey:@"selectState"] longLongValue] == 1 ){
        
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
        cell.selelctImg.hidden = NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyServiceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selelctImg.hidden = !cell.selelctImg.hidden;
 
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyServiceCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    cell.selelctImg.hidden = !cell.selelctImg.hidden;
}

-(NSArray *)selectDataArr{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (self.tableView.indexPathsForSelectedRows.count<=0 ||self.dataArr<=0) {
        
        return @[];
    }
    
    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        
        [arr addObject:[self.dataArr[indexPath.row] objectForKey:@"id"]];
    }
    
    
    return arr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 5.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 5.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return [UIView new];
}
-(NSArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [[NSArray alloc] init];
    }
    
    return _dataArr;
}

@end
