//
//  SetingViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/25.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SetingViewController.h"
#import "LogInViewController.h"
#import "ChangePwdViewController.h"
#import "BaseNavigation.h"
#import <Masonry.h>
@interface SetingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton *signOutBtn;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SetingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.signOutBtn];
    
    [self.signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(5);
        } else {
            
            make.bottom.mas_equalTo(self.view.mas_bottom).inset(5);
        }
        make.left.mas_equalTo(self.view.mas_left).inset(16);
        make.right.mas_equalTo(self.view.mas_right).inset(16);
        make.height.mas_equalTo(@40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.signOutBtn.mas_top);
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

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setingCellID" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改密码";
            cell.imageView.image = [UIImage imageNamed:@"ic_gaimima"];
            cell.imageView.contentMode = UIViewContentModeCenter;
            break;
        default:
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:[[ChangePwdViewController alloc]init] animated:YES];
        }
            
            break;
        case 1:{
            

        }
            
            break;
            
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2;
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

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.scrollEnabled = NO;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setingCellID"];
        
    }
    
    
    return _tableView;
}

-(UIButton *)signOutBtn{
    
    if (!_signOutBtn) {
        
        _signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_signOutBtn setBackgroundColor:JJThemeColor];
        [_signOutBtn setTintColor:[UIColor whiteColor]];
        [_signOutBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        _signOutBtn.layer.cornerRadius = 5.f;
        _signOutBtn.layer.masksToBounds = YES;
        [_signOutBtn addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _signOutBtn;
}

-(void)signOut{
    
    [UserConfig userDefaultsSetObject:nil key:kFirstLogIn];
    
//    [[SDImageCache sharedImageCache] clearMemory];
//
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//
//    }];
    
    BaseNavigation *nav = [[BaseNavigation alloc] initWithRootViewController: [[LogInViewController alloc] init]];
    
    [[UIApplication sharedApplication] delegate].window.rootViewController = nav;

//    [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
}
@end
