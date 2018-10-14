//
//  IncomeListTableViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeListTableViewController.h"
#import "IncomeOrderCell.h"
@interface IncomeListTableViewController ()

@property(nonatomic,strong)NSString *identifier;

@property(nonatomic,assign)NSInteger cellIndex;

@end

@implementation IncomeListTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style withIdentifier:(NSString *)cellIdentifier{
    
    if (self = [super initWithStyle:style]) {
        
        if ([cellIdentifier isEqualToString:@"serviceCellID"]) {
            
            self.cellIndex = 0;
        }else{
            
            self.cellIndex = 1;
        }
        self.identifier = cellIdentifier;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRefreshControl];
}

-(void)loadNewData{
    JJWeakSelf
    
    [weakSelf.tableView.mj_header endRefreshing];
}


-(void)loadMoreData{
    JJWeakSelf
    
    [weakSelf.tableView.mj_footer endRefreshing];
}

-(void)getIncomeInfo{
    
    
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IncomeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IncomeOrderCell" owner:self options:nil] objectAtIndex:_cellIndex];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
