//
//  PromotionAwardViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "PromotionAwardViewController.h"
#import "MyCodeViewController.h"
#import "promotionAwardCell.h"
#import "PromotionRequest.h"
#import "ExtensionInfo.h"
#import "JJShare.h"

@interface PromotionAwardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *InvitationCodeLab;

@property (weak, nonatomic) IBOutlet UILabel *rewardContentLab;

@property(nonatomic,strong)NSArray *rewardUserArr;

@property(nonatomic,strong)ExtensionInfo *extensionInfo;

@end

@implementation PromotionAwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推广有礼";

    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-nav_height-bottom_height-44-25);
    
    self.tableView.tableHeaderView = self.headerView;
    
    if (IS_iPhone_5) {
        
        self.rewardContentLab.font = [UIFont systemFontOfSize:11.f];
    }
    if (IS_iPhone_6) {
        
        self.rewardContentLab.font = [UIFont systemFontOfSize:12.f];
    }
    if (IS_iPhone6_Plus) {
        
        self.rewardContentLab.font = [UIFont systemFontOfSize:13.f];
    }
    if (KIsiPhoneX) {
        
        self.rewardContentLab.font = [UIFont systemFontOfSize:14.f];
    }
    
    UIButton*bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:[UIImage imageNamed:@"ic_erweima"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(pushQRCodeVC) forControlEvents:UIControlEventTouchUpInside];
    bt.frame=CGRectMake(0, 0, 33, 33);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bt];
    
    [self getPromotionInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.hidesBottomBarWhenPushed = YES;
    
}
-(void)pushQRCodeVC{
    
    if (self.extensionInfo) {
        
        MyCodeViewController *myCodeVC = [[MyCodeViewController alloc] init];
        
        myCodeVC.extensionInfo = self.extensionInfo;
        [self.navigationController pushViewController:myCodeVC animated:YES];
    } 
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.rewardUserArr.count>0) {
        
        return self.rewardUserArr.count+2;
    }
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath.row) {
        case 0:
            identifier = @"promotionAwardCellID";
            index = 0;
            break;
        case 1:
            if (self.rewardUserArr.count<=0) {
                
                identifier = @"promotionHintCellID";
                index = 3;
            }else{
                identifier = @"promotionTitlCellID";
                index = 1;
            }
            break;
        default:
            
            identifier = @"promotionDefaultCellID";
            index = 2;
   
            break;
    }
    
    promotionAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"promotionAwardCell" owner:self options:nil] objectAtIndex:index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.rewardUserArr.count>0) {
        
        if (indexPath.row>1) {
            
            cell.phoneLab.text = [self.rewardUserArr[indexPath.row-2] objectForKey:@"phone"];
            cell.dateLab.text = [JJTools getTimestampFromTime:[self.rewardUserArr[indexPath.row-2] objectForKey:@"createdTime"] formatter:@"yyyy-MM-dd"];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            return 44;
            break;
        case 1:
            if (self.rewardUserArr.count<=0) {
                
                return 50;
            }
            return 25;
            break;
            
        default:
            break;
    }
    
    return 25;
}

-(void)getPromotionInfo{
    
    [PromotionRequest getPromotionAwardInfoWithReqjson:@{@"storeId":[UserConfig storeID]} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        self.rewardContentLab.text = [data objectForKey:@"award"];
        self.InvitationCodeLab.text = [data objectForKey:@"invitationCode"];
        
        self.rewardUserArr = [data objectForKey:@"shareRelationList"];
//
        [self.tableView reloadData];
        
        self.extensionInfo = [[ExtensionInfo alloc] init];
        [self.extensionInfo setValuesForKeysWithDictionary:data];
        
    } failure:^(NSError * _Nullable error) {
    }];
}

-(void)setViewPhoneEnable:(BOOL)viewPhoneEnable{
    
    _viewPhoneEnable = viewPhoneEnable;
    
}


- (IBAction)shareEvent:(UIButton *)sender {
    
    [JJShare ShareDescribe:@"分享下载app，注册并添加车辆即赠送两张精致洗车券，购买轮胎，更有精美大礼赠送！" images:@[[UIImage imageNamed:@"shareIMG"]] url:self.extensionInfo.url title:@"如驿如意" type:SSDKContentTypeAuto];
    
}

-(NSArray *)rewardUserArr{
    
    if (!_rewardUserArr) {
        
        _rewardUserArr = [NSArray array];
        
//        _rewardUserArr =  @[
//
//  @{@"createdTime": @"1527150989000",@"phone": @"17864239822"},
//  @{@"createdTime": @"1527150989000",@"phone": @"17864239820"},
//  @{@"createdTime": @"1527150989000",@"phone": @"17864239829"}];
   
    }
    
    
    return _rewardUserArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
