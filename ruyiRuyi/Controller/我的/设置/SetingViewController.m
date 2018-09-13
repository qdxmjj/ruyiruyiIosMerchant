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

#import <JPUSHService.h>
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

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];


    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"setingCellID"];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改密码";
            cell.imageView.image = [UIImage imageNamed:@"ic_gaimima"];
            cell.imageView.contentMode = UIViewContentModeCenter;
            break;
        case 1:
            
            cell.textLabel.text = @"设置通知";
            if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
                UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
                if (UIUserNotificationTypeNone == setting.types) {

                    cell.detailTextLabel.text = @"推送已关闭";
                }else{

                    cell.detailTextLabel.text = @"推送已开启";
                }
            }
            cell.imageView.image = [UIImage imageNamed:@"ic_gaimima"];
            cell.imageView.contentMode = UIViewContentModeCenter;
            break;
        case 2:{
            cell.textLabel.text = @"清理缓存";
            NSString *path = [NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()];
            
            float pathSize = [self folderSizeAtPath:path];
            float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
            float allSize = pathSize + tmpSize;
            NSString *clearCacheSizeStr = allSize >= 1 ? [NSString stringWithFormat:@"%.2fM",allSize] : [NSString stringWithFormat:@"%.2fK",allSize * 1024];
            cell.detailTextLabel.text = clearCacheSizeStr;
            
            cell.imageView.image = [UIImage imageNamed:@"ic_gaimima"];
            cell.imageView.contentMode = UIViewContentModeCenter;
            
        }
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
            
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
            if (@available(iOS 10.0, *)) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                    
                    NSLog(@"%@",success == YES? @"YES":@"NO");
                }];
                
            } else {

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }
            break;
        case 2:{
            
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"是否清空所有的缓存数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    
                }];
                
                NSString *path = [NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()];
                [self clearfoder:path mainThread:^{
                    [tableView reloadData];
                    [MBProgressHUD showTextMessage:@"清理成功"];
                }];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];

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

//退出登录
-(void)signOut{
    
    [UserConfig userDefaultsSetObject:nil key:kFirstLogIn];
    
    //退出登录设置一个永远不会触发的别名
    [JPUSHService setAlias:@"999" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        //0成功
        NSLog(@"%ld :  %@",iResCode,iAlias);
    } seq:0];
    
    BaseNavigation *nav = [[BaseNavigation alloc] initWithRootViewController: [[LogInViewController alloc] init]];
    
    [[UIApplication sharedApplication] delegate].window.rootViewController = nav;
//    [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
}

//清理缓存文件夹
-(void)clearfoder:(NSString *)path mainThread:(dispatch_block_t)block
{
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) return;
    NSArray *subPaths = [manager subpathsAtPath:path];
    dispatch_queue_t systemQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(systemQueue, ^{
        for (NSString *subPath in subPaths) {
            [manager removeItemAtPath:[path stringByAppendingPathComponent:subPath] error:nil];
        }
        dispatch_sync(dispatch_get_main_queue(), block);
    });
    
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    
    return 0;
    
}
@end
