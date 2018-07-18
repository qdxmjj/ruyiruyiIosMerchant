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

@interface UserViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)HanderView *handerView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
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

    if (self.imgArr.count>0) {
        return self.imgArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCellID" forIndexPath:indexPath];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
            
            [self.navigationController pushViewController:[[PromotionAwardViewController alloc]init] animated:YES];
        }
            break;
        case 3:{
         
            [MBProgressHUD showTextMessage:@"正在开发中.."];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[[SetingViewController alloc]init] animated:YES];
        }
            
            break;
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
        
        _imgArr = [NSArray arrayWithObjects:@"ic_service",@"ic_thing",@"ic_gift",@"ic_word",@"ic_zhanghao", nil];
    }
    return _imgArr;
}
-(NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = [NSArray arrayWithObjects:@"我的服务",@"我的商品",@"推广奖励",@"店主有话说",@"设置", nil];
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

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updataHeadPhotoNotification" object:nil];
}

@end
