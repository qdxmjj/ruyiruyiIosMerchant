//
//  UserViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "UserViewController.h"
#import "UserCell.h"
#import "HanderView.h"

#import "MyServiceViewController.h"
#import "MyOrdersViewController.h"
#import "MyShopViewController.h"
#import "MyCommodityViewController.h"
#import "SetingViewController.h"
#import "PromotionAwardViewController.h"
#import "DeliveryOrderViewController.h"
#import "StockViewController.h"
@interface UserViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)HanderView *handerView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.tableHeaderView = self.handerView;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserCell class]) bundle:nil] forCellReuseIdentifier:@"userCellID"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataHeadphoto) name:@"updataHeadPhotoNotification" object:nil];
}

-(void)updataHeadphoto{
    
    self.handerView.Avatar = [UserConfig storeImgUrl];
    
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
    
    if (self.titleArr.count>0) {
        return self.titleArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCellID" forIndexPath:indexPath];
    
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imgView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    
    cell.titleLab.text = self.titleArr[indexPath.row];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[MyServiceViewController alloc]init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[MyCommodityViewController alloc]init] animated:YES];
            break;
        case 2:{
            [MBProgressHUD showTextMessage:@"活动已结束！"];
//            [self.navigationController pushViewController:[[PromotionAwardViewController alloc]init] animated:YES];
        }
            break;
//        case 3:{
//
//            [MBProgressHUD showWaitMessage:@"正在查询权限.." showView:self.view];
//            NSDictionary *params = @{@"storeId":[UserConfig storeID]};
//            [JJRequest postRequest:@"/checkStoreAuth" params:@{@"reqJson":[JJTools convertToJsonData:params]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
//
//                [MBProgressHUD hideWaitViewAnimated:self.view];
//
//                if ([code longLongValue] == 1) {
//
//                    if ([data boolValue] == true) {
//
//                        [self.navigationController pushViewController:[[DeliveryOrderViewController alloc]init] animated:YES];
//                    }else{
//                        [MBProgressHUD showTextMessage:@"您没有发货权限！"];
//                    }
//                }
//
//            } failure:^(NSError * _Nullable error) {
//                [MBProgressHUD hideWaitViewAnimated:self.view];
//            }];
//        }
//            break;
        case 3:
        {
            [MBProgressHUD showTextMessage:@"正在开发中.."];
        }
            break;
        case 4:
        {
            StockViewController *stockVC = [[StockViewController alloc] init];
            [self.navigationController pushViewController:stockVC animated:YES];
        }
            break;
        case 5:{
            [self.navigationController pushViewController:[[SetingViewController alloc]init] animated:YES];
        }
        default:
            break;
    }
    
}

#pragma mark button Event
-(void)pushMyOrderViewControllerEvent{
    [self.navigationController pushViewController:[[MyOrdersViewController alloc]init] animated:YES];
}

-(void)pushMyShopViewControllerEvent{
    [self.navigationController pushViewController:[[MyShopViewController alloc]init] animated:YES];
}

-(NSArray *)imgArr{
    if (!_imgArr) {
//        _imgArr = [NSArray arrayWithObjects:@"ic_service",@"ic_thing",@"ic_gift",@"ic_m_fahuo",@"ic_word",@"icon_kuguan",@"ic_zhanghao", nil];
        _imgArr = [NSArray arrayWithObjects:@"ic_service",@"ic_thing",@"ic_gift",@"ic_word",@"icon_kuguan",@"ic_zhanghao", nil];
    }
    return _imgArr;
}
-(NSArray *)titleArr{
    if (!_titleArr) {
//        _titleArr = [NSArray arrayWithObjects:@"我的服务",@"我的商品",@"推广奖励",@"订单发货",@"店主有话说",@"一键申请,免费铺货",@"设置", nil];
        _titleArr = [NSArray arrayWithObjects:@"我的服务",@"我的商品",@"推广奖励",@"店主有话说",@"一键申请,免费铺货",@"设置", nil];
    }
    return _titleArr;
}


-(HanderView *)handerView{
    if (!_handerView) {
        _handerView = [[HanderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height*0.4)];
        _handerView.Avatar = [UserConfig storeImgUrl];
        _handerView.userName = [UserConfig storeName];
        [_handerView.leftBtn addTarget:self action:@selector(pushMyOrderViewControllerEvent) forControlEvents:UIControlEventTouchUpInside];
        [_handerView.rigBtn addTarget:self action:@selector(pushMyShopViewControllerEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handerView;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ///全局的 谁签订谁生效 全局 viewDidLoad只执行一次  nav栈内的视图没有销毁 所以 当下一个视图 签订代理 返回上一视图时  上一视图代理将不会执行
    self.navigationController.delegate = self;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updataHeadPhotoNotification" object:nil];
}

@end
