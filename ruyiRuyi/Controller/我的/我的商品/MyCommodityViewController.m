//
//  MyCommodityViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/14.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyCommodityViewController.h"
#import "CommodityBottomView.h"
#import "SellingTableViewController.h"
#import "DropTableViewController.h"
#import "AddCommodityViewController.h"

#import "YMCommodityTypePickerView.h"
#import "MyCommodityRequest.h"

#import "CommodityTypeModel.h"
static const CGFloat topBtnH = 50;

static const CGFloat sliderH = 2.5;

static const CGFloat bottomH = 45;

@interface MyCommodityViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView *contentScrView;

@property(nonatomic,strong)UIImageView *sliderView;//滑块

@property(nonatomic,strong)CommodityBottomView *bottomView;

@property(nonatomic,strong)SellingTableViewController *sellingVC;

@property(nonatomic,strong)SellingTableViewController *dropVC;

@property(nonatomic,strong)CommodityTypeModel *Cmodel;
@end

@implementation MyCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    NSArray  *titleArr = @[@"出售中",@"已下架"];
    
    for (int i=0; i<=1; i++) {
        
        UIButton *tabbarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tabbarBtn.frame=CGRectMake(SCREEN_WIDTH/2*i,0 , SCREEN_WIDTH/2, topBtnH);
        tabbarBtn.backgroundColor=[UIColor cyanColor];
        [tabbarBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [tabbarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [tabbarBtn addTarget:self action:@selector(topBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tabbarBtn];
    }
    
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.contentScrView];
    [self.view addSubview:self.bottomView];
    
    [self addChildViewController:self.sellingVC];
    [self addChildViewController:self.dropVC];
    
    [self.contentScrView addSubview:self.sellingVC.tableView];
    [self.contentScrView addSubview:self.dropVC.tableView];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getCommodityTypeRequest];//获取商家的服务类型


    self.hidesBottomBarWhenPushed = YES;

}


#pragma mark topButton event
-(void)topBtnPressed:(UIButton *)btn{
    
    [self.contentScrView setContentOffset:CGPointMake(btn.frame.origin.x*2, 0) animated:YES];
}


-(void)UploadDataToServer{
    
    
    
}



-(void)pushAddCommodityVC{
    
    AddCommodityViewController *addVC = [[AddCommodityViewController alloc]init];
    addVC.aModel = self.Cmodel;
    addVC.bButtonTitle = @"提交商品";
    [self.navigationController pushViewController:addVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}


-(void)showSelectCommodityTypeVC:(UIButton *)sender{
    
    JJWeakSelf
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    
    self.bottomView.imgV.transform = transform;

    YMCommodityTypePickerView * commodityPV = [[YMCommodityTypePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    commodityPV.dataDic = self.Cmodel.commodityTypeDic;

    commodityPV.disBlock = ^(NSString *FieldText, NSString *selectServiceTypeID, NSString *selectServiceID, BOOL isDismis) {
            
        if (isDismis) {

            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2+M_PI);
            weakSelf.bottomView.imgV.transform = transform;
        }

        if(self.contentScrView.contentOffset.x == 0){
            
            weakSelf.sellingVC.serviceTypeId = selectServiceTypeID;
            weakSelf.sellingVC.servicesId = selectServiceID;
            [weakSelf.sellingVC RefreshData];
            
        }else{
            
            weakSelf.dropVC.servicesId = selectServiceID;
            weakSelf.dropVC.serviceTypeId = selectServiceTypeID;
            [weakSelf.dropVC RefreshData];
        }
    
    };

    [commodityPV show];
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.sliderView.mj_x = scrollView.contentOffset.x/2;
}


#pragma mark 视图加载
-(UIScrollView *)contentScrView{
    if (_contentScrView==nil) {
        
        _contentScrView=[UIScrollView new];
        if (KIsiPhoneX) {
            
            _contentScrView.frame = CGRectMake(0, topBtnH+sliderH, SCREEN_WIDTH, SCREEN_HEIGHT-topBtnH-sliderH-bottomH-34-88);
        }else{
            
            _contentScrView.frame = CGRectMake(0,topBtnH+sliderH, SCREEN_WIDTH, SCREEN_HEIGHT-topBtnH-sliderH-bottomH-64);
        }
        _contentScrView.delegate=self;
        _contentScrView.bounces=NO;
        _contentScrView.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
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
        _sliderView.frame = CGRectMake(0, topBtnH, SCREEN_WIDTH/2, sliderH);
        _sliderView.backgroundColor=[UIColor colorWithRed:0 green:144/255.0 blue:254/255.0 alpha:1];
    }
    return _sliderView;
}


-(CommodityBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[CommodityBottomView alloc] initWithFrame:CGRectMake(0, self.contentScrView.mj_h+topBtnH+sliderH, SCREEN_WIDTH, bottomH)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView.addBtn addTarget:self action:@selector(pushAddCommodityVC) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.btn addTarget:self action:@selector(showSelectCommodityTypeVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bottomView;
}

-(SellingTableViewController *)sellingVC{
    
    if (!_sellingVC) {
        
        
        _sellingVC = [[SellingTableViewController alloc] initWithServiceType:CommodityTypeSell];
        _sellingVC.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
    }
    
    return _sellingVC;
}

-(SellingTableViewController *)dropVC{
    
    if (!_dropVC) {
        
        
        _dropVC = [[SellingTableViewController alloc] initWithServiceType:CommodityTypeDrop];
        _dropVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(self.contentScrView.frame));
    }
    
    return _dropVC;
}


-(void)getCommodityTypeRequest{
    
    
    [MyCommodityRequest getStoreAddedServicesWithInfo:@{@"storeId":[UserConfig storeID]} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        [self.Cmodel setValuesForKeysWithDictionary:data];
        self.Cmodel.commodityTypeDic = data;
        self.sellingVC.cModel = self.Cmodel;
        self.dropVC.cModel = self.Cmodel;
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(CommodityTypeModel *)Cmodel{
    
    if (!_Cmodel) {
        
        _Cmodel = [[CommodityTypeModel alloc] init];
    }
    
    
    return _Cmodel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
