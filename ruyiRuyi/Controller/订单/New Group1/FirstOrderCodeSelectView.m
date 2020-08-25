//
//  FirstOrderCodeSelectView.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderCodeSelectView.h"
#import "JJMacro.h"
#import "UIColor+YM.h"
@implementation FirstOrderCodeSelectView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.selectCodeTableView.tableFooterView = [UIView new];
    //    [self.selectCodeTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"selectCodeHeaderView_id"];
    [self.selectCodeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selectCodeCell_id"];
}


- (void)reload{
    
    if (!self.selectCodeTableView.delegate) {
        self.selectCodeTableView.delegate = self;
        self.selectCodeTableView.dataSource = self;
    }
    [self.selectCodeTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectCodeCell_id" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (self.frontCodeArray) {
            cell.textLabel.text = self.frontCodeArray[indexPath.row];
        }else if (!self.frontCodeArray && self.rearCodeArray){
            cell.textLabel.text = self.rearCodeArray[indexPath.row];
        }else{
            cell.textLabel.text = @"";
        }
    }else{
        if (self.rearCodeArray) {
            cell.textLabel.text = self.rearCodeArray[indexPath.row];
        }else{
            cell.textLabel.text = @"";
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.isYiZhi) {
            return self.frontCodeArray.count;
        }else{
            if (self.frontCodeArray) {
                return self.frontCodeArray.count;
            }else if (!self.frontCodeArray && self.rearCodeArray){
                return self.rearCodeArray.count;
            }
        }
        
        return 0;
    }
    
    if (self.rearCodeArray) {
        return self.rearCodeArray.count;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 44)];
    titleLab.textColor = [UIColor ym_colorFromHexString:@"333333"];
    titleLab.font = [UIFont systemFontOfSize:15.f];
    if (section == 0) {
        titleLab.text = @"轮胎编码";
    }else{
        titleLab.text = @"后轮条形码";
    }
    [headerView addSubview:titleLab];
    
    UIButton *selectCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectCodeBtn setTitle:@"选择条形码" forState:UIControlStateNormal];
    [selectCodeBtn setTitleColor:[UIColor ym_colorFromHexString:@"#333333"] forState:UIControlStateNormal];
    [selectCodeBtn setFrame:CGRectMake(SCREEN_WIDTH-100-16, 0, 100, 44)];
    selectCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [selectCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [selectCodeBtn addTarget:self action:@selector(showSelectCodeViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    selectCodeBtn.tag = 1000+section;
    [headerView addSubview:selectCodeBtn];
    
    return headerView;
}

- (void)showSelectCodeViewAction:(UIButton *)sender{
    
    if (self.showBlock) {
        self.showBlock(sender.tag - 1000);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.isYiZhi) {
        return 1;
    }
    return 2;
}

@end
