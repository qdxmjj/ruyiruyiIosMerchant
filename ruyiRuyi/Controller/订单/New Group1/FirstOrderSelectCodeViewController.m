//
//  FirstOrderSelectCodeViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderSelectCodeViewController.h"
#import "OrderSelectCodeCell.h"
@interface FirstOrderSelectCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *selectArray;
@end

@implementation FirstOrderSelectCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell_id"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderSelectCodeCell class]) bundle:nil] forCellReuseIdentifier:@"FirstOrderSelectCodeCell_id"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (touch.view == self.view) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
- (IBAction)querenAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"firstOrderSelectCodeNotice" object:@{@"selectArray":self.selectArray,@"type":self.type}];
    
    [self dismissViewControllerAnimated:false completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    OrderSelectCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstOrderSelectCodeCell_id" forIndexPath:indexPath];
    cell.titleLab.text = self.codeArray[indexPath.row][@"barcode"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.codeArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderSelectCodeCell *cell = (OrderSelectCodeCell *)[tableView cellForRowAtIndexPath:indexPath];

    if (self.selectArray.count < self.maxSelectCout) {
        cell.selectBtn.selected = YES;
        [self.selectArray addObject:self.codeArray[indexPath.row]];
    }else{
        [MBProgressHUD showTextMessage:[NSString stringWithFormat:@"当前轮胎最多选择%ld条",self.maxSelectCout]];
        cell.selected = NO;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderSelectCodeCell *cell = (OrderSelectCodeCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectBtn.isSelected) {
        [self.selectArray removeObject:self.codeArray[indexPath.row]];
    }
    cell.selectBtn.selected = NO;
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
@end
