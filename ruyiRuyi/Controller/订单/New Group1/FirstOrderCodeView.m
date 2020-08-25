//
//  FirstOrderCodeView.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderCodeView.h"

@implementation FirstOrderCodeView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.codeTableView.tableFooterView = [UIView new];

    [self.codeTableView registerClass:[CodeNumheadView class] forHeaderFooterViewReuseIdentifier:@"codeNumHeadView"];
    [self.codeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CodeNumberCell class]) bundle:nil] forCellReuseIdentifier:@"CodeNumberCell_id"];
}
- (void)setCodeNumArr:(NSArray *)codeNumArr{
    _codeNumArr = codeNumArr;

    if (!self.codeTableView.delegate) {
        self.codeTableView.delegate = self;
        self.codeTableView.dataSource=  self;
    }
    
    [self.codeTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CodeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeNumberCell_id" forIndexPath:indexPath];
    cell.barCodeLab.text = [self.codeNumArr[indexPath.row] objectForKey:@"barCode"];
    cell.statusButton.hidden = !self.switchHidden;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.codeNumArr) {
        return self.codeNumArr.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CodeNumheadView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"codeNumHeadView"];
    
    header.rigthTextHidden = !self.switchHidden;
    
    return header;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.codeNumArr) {
        return self.codeNumArr.count >0 ? 44 : 0.01;
    }
    return 0.01;
}

@end
