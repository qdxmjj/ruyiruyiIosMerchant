//
//  MyServiceViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyServiceViewController.h"
#import "MyServiceTableViewController.h"

static const CGFloat topBtnH = 45;

static const CGFloat bottomBtnH = 40;


@interface MyServiceViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrView;

@property(nonatomic,strong)UIImageView *sliderView;//滑块

@property(nonatomic,strong)MyServiceTableViewController *baoyangVC;
@property(nonatomic,strong)MyServiceTableViewController *meirongVC;
@property(nonatomic,strong)MyServiceTableViewController *anzhuangVC;
@property(nonatomic,strong)MyServiceTableViewController *gaizhuangVC;
@end

@implementation MyServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"我的服务";

    NSArray  *titleArr = @[@"保养",@"美容清洗",@"安装",@"轮胎服务"];
    
    for (int i=0; i<=3; i++) {
        
        UIButton *tabbarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tabbarBtn.frame=CGRectMake(SCREEN_WIDTH/4*i,0 , SCREEN_WIDTH/4, topBtnH);
        tabbarBtn.backgroundColor=[UIColor whiteColor];
        [tabbarBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [tabbarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabbarBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];

        [tabbarBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tabbarBtn];
    }
    
    [self.view addSubview:self.contentScrView];
    [self.view addSubview:self.sliderView];
   
    
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:255.f/255 green:102.f/255 blue:35.f/255 alpha:1.f]];
    [bottomBtn addTarget:self action:@selector(UploadDataToServer) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.layer.cornerRadius = 5.f;
     [self.view addSubview:bottomBtn];
    
     [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
         if (@available(iOS 11.0, *)) {
             make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
         } else {
             make.bottom.mas_equalTo(self.view.mas_bottom);
         }
         
         make.left.mas_equalTo(self.view.mas_left).offset(10);
         make.right.mas_equalTo(self.view.mas_right).offset(-10);
         make.height.mas_equalTo(bottomBtnH);
    }];
}


-(void)UploadDataToServer{
    
    NSMutableArray *subClassService = [NSMutableArray array];
    
    NSMutableArray *arrays = [NSMutableArray arrayWithObjects:self.baoyangVC.selectDataArr,self.meirongVC.selectDataArr,self.gaizhuangVC.selectDataArr,self.anzhuangVC.selectDataArr, nil];
    
    for (NSArray *a in arrays) {
        
        if (a.count>0) {
            
            for (int j = 0; j < a.count; j++) {
                [subClassService addObject:a[j]];
            }
        }
    }
    
    NSString *serviceStr = [NSString stringWithFormat:@"%@",[subClassService componentsJoinedByString:@","]];
    
    [ServiceRequest addStoreServicesSubClassWithInfo:@{@"storeId":[UserConfig storeID],@"services":serviceStr} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}



-(void)viewWillAppear:(BOOL)animated{
    
    [self.baoyangVC getServiceList];
    [self.meirongVC getServiceList];
    [self.gaizhuangVC getServiceList];
    [self.anzhuangVC getServiceList];
}

#pragma mark topButton event
-(void)topBtnPressed:(UIButton *)btn{
    
    [self.contentScrView setContentOffset:CGPointMake(btn.frame.origin.x*4, 0) animated:YES];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    self.sliderView.mj_x = scrollView.contentOffset.x/4;
}




#pragma mark 视图加载
-(UIScrollView *)contentScrView{
    if (_contentScrView==nil) {
        
        _contentScrView=[UIScrollView new];
        if (KIsiPhoneX) {
            
            _contentScrView.frame = CGRectMake(0, topBtnH+2.5, SCREEN_WIDTH, SCREEN_HEIGHT-88-34-bottomBtnH-topBtnH);
        }else{
            _contentScrView.frame = CGRectMake(0, topBtnH+2.5, SCREEN_WIDTH, SCREEN_HEIGHT-64-bottomBtnH-topBtnH);
        }
        _contentScrView.delegate=self;
        _contentScrView.bounces=NO;
        _contentScrView.contentSize=CGSizeMake(SCREEN_WIDTH*4, 0);
        _contentScrView.backgroundColor=[UIColor lightGrayColor];
        _contentScrView.showsVerticalScrollIndicator=NO;
        _contentScrView.delegate=self;
        _contentScrView.showsHorizontalScrollIndicator=NO;
        _contentScrView.pagingEnabled=YES;
        
    }
    
    return _contentScrView;
}
-(UIImageView *)sliderView{
    
    if (_sliderView==nil) {

        _sliderView = [UIImageView new];
        if (KIsiPhoneX) {
            
            _sliderView.frame = CGRectMake(0, topBtnH, SCREEN_WIDTH/4, 2.5);

        }else{
            
            _sliderView.frame = CGRectMake(0, topBtnH, SCREEN_WIDTH/4, 2.5);
        }
        _sliderView.backgroundColor=JJThemeColor;

    }
    return _sliderView;
}

-(MyServiceTableViewController *)baoyangVC{
    if (!_baoyangVC) {
        
        _baoyangVC = [[MyServiceTableViewController alloc] initWithServiceType:ServiceTypeBaoyang];
        _baoyangVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        [self addChildViewController:self.baoyangVC];
        [self.contentScrView addSubview:self.baoyangVC.view];
        
    }
    return _baoyangVC;
}
-(MyServiceTableViewController *)meirongVC{
    if (!_meirongVC) {
        
        _meirongVC = [[MyServiceTableViewController alloc] initWithServiceType:ServiceTypeMeirong];
        _meirongVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        [self addChildViewController:self.meirongVC];
        [self.contentScrView addSubview:self.meirongVC.view];
        
    }
    return _meirongVC;
}
-(MyServiceTableViewController *)anzhuangVC{
    if (!_anzhuangVC) {
        
        _anzhuangVC = [[MyServiceTableViewController alloc] initWithServiceType:ServiceTypeAnzhuang];
        _anzhuangVC.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        
        [self addChildViewController:self.anzhuangVC];
        [self.contentScrView addSubview:self.anzhuangVC.view];
    }
    return _anzhuangVC;
}
-(MyServiceTableViewController *)gaizhuangVC{
    if (!_gaizhuangVC) {
        
        _gaizhuangVC = [[MyServiceTableViewController alloc] initWithServiceType:ServiceTypeGaizhuang];
        _gaizhuangVC.view.frame = CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
        
        [self addChildViewController:self.gaizhuangVC];
        [self.contentScrView addSubview:self.gaizhuangVC.view];
    }
    return _gaizhuangVC;
}



@end
