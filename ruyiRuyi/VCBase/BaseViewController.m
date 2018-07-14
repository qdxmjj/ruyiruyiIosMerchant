//
//  BaseViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
    
    UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBar.width = -20;

    self.navigationItem.leftBarButtonItems =@[spaceBar,[self BarButtonItemWithImage:[UIImage imageNamed:@"ic_back"] target:self action:@selector(backButtonAction)]];
}

- (void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIBarButtonItem *)BarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton*bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:image forState:UIControlStateNormal];
    bt.frame=CGRectMake(0, 0, 33, 33);
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:bt];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    NSLog(@"%@页面释放",[self class]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
