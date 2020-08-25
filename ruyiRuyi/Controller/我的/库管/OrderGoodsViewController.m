//
//  OrderGoodsViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/25.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "OrderGoodsViewController.h"
#import "OrderGoodsSearchController.h"
#import "StockBuyCartViewController.h"
#import "StockOrderGoodsModel.h"
#import "StockOrderGoodsCell.h"
#import "YMRequest.h"
@interface OrderGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *selectArray;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (strong, nonatomic) NSMutableDictionary *searchDic;

@end

@implementation OrderGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要订货";
    
    [self getUserDefaultsData];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StockOrderGoodsCell class]) bundle:nil] forCellReuseIdentifier:@"StockOrderGoodsCell_id"];
    self.baseTableView = self.tableView;
    [self getDataList:[NSMutableDictionary dictionary]];
    
    [self addRefreshParts];
}

- (void)searchAction{
    JJWeakSelf;
    OrderGoodsSearchController *searchVC = [[OrderGoodsSearchController alloc] init];
    searchVC.searchDic = self.searchDic;
    searchVC.searchBlock = ^(NSMutableDictionary * _Nonnull searchDic) {
        weakSelf.currentPage = 1;
        weakSelf.searchDic = searchDic;
        [weakSelf getDataList:weakSelf.searchDic];
    };
    searchVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    searchVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    searchVC.definesPresentationContext = YES; //self is presenting view controller
    [self presentViewController:searchVC animated:NO completion:nil];
}

- (void)getUserDefaultsData{
    ///查询是否有存储的库存商品数据
    if ([UserConfig userDefaultsGetObjectForKey:@"kStockGoods"] && [UserConfig userDefaultsGetObjectForKey:@"kStockGoods"] != NULL) {
        
        //原数据
        NSMutableArray *dataAry = [NSMutableArray arrayWithArray:[UserConfig userDefaultsGetObjectForKey:@"kStockGoods"]];
        
        for (NSData *data in dataAry) {
            //解档
            StockOrderGoodsModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            //赋值给当前选择数据
            
            NSLog(@"解档内存地址：%p",model);
            [self.selectArray addObject:model];
        }
    }
    NSLog(@"%@",_selectArray);
}

- (void)getDataList{
    
    [self getDataList:self.searchDic];
}
- (void)getDataList:(NSMutableDictionary *)searchDic{
    
    [MBProgressHUD showWaitMessage:@"正在获取列表..." showView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params addEntriesFromDictionary:searchDic];
    [params setObject:[UserConfig storeID] forKey:@"id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"page"];
    [params setObject:@"20" forKey:@"pageSize"];

    [[YMRequest sharedManager] getRequest:kStockOrderList params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        if (code == 1) {
            
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:[StockOrderGoodsModel mj_objectArrayWithKeyValuesArray:data[@"data"]]];
            
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}
- (IBAction)saveAction:(id)sender {
    if (self.selectArray.count<=0) {
        [MBProgressHUD showTextMessage:@"请先添加库存商品！"];
        return;
    }
    JJWeakSelf;
    NSMutableArray *selectDataArray = [NSMutableArray array];
    for (StockOrderGoodsModel *model in self.selectArray) {
        //归档
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [selectDataArray addObject:data];
    }
    NSArray *array = [NSArray arrayWithArray:selectDataArray];
    
    [UserConfig userDefaultsSetObject:array key:@"kStockGoods"];
    
    //    NSArray *ary = [UserConfig userDefaultsGetObjectForKey:@"kStockGoods"];
    //    NSLog(@"%@",ary);
    
    StockBuyCartViewController *buyCartVC = [[StockBuyCartViewController alloc] init];
    buyCartVC.goodsDataArray = self.selectArray;
    
    buyCartVC.cleanBlock = ^{
        weakSelf.selectArray = [NSMutableArray array];
    };
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:buyCartVC animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JJWeakSelf;
    StockOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockOrderGoodsCell_id" forIndexPath:indexPath];
    
    cell.addBlock = ^(StockOrderGoodsModel * _Nonnull model) {
        
        __block bool isBe = NO;
        [MBProgressHUD showWaitMessage:@"正在添加..." showView:self.view];
        
        [weakSelf.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            StockOrderGoodsModel *objModel = obj;
            
            if (objModel.shoeId == model.shoeId) {
                
                isBe = YES;
                //替换数据并停止遍历
                [weakSelf.selectArray replaceObjectAtIndex:idx withObject:model];
                [MBProgressHUD showTextMessage:@"替换成功！" afterDelay:0.4];
                *stop = YES;
            }
        }];
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if (!isBe) {
            [weakSelf.selectArray addObject:model];
            [MBProgressHUD showTextMessage:@"添加成功！" afterDelay:0.4];
        }
        
        StockOrderGoodsModel *model1 = self.selectArray[0];
        NSLog(@"覆盖后金额为：%@", model1.totalPrice);
        
    };
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
- (NSMutableDictionary *)searchDic{
    if (!_searchDic) {
        _searchDic = [NSMutableDictionary dictionary];
    }
    return _searchDic;
}
@end
