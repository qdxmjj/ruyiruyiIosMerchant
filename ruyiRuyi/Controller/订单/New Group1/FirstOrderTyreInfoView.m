//
//  FirstOrderTyreInfoView.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderTyreInfoView.h"

@implementation FirstOrderTyreInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.tyreTableView.tableFooterView = [UIView new];
    [self.tyreTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TiresCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TiresCell_id"];
}
- (void)setTiresNumArr:(NSArray *)tiresNumArr{
    _tiresNumArr = tiresNumArr;
    
    if (!self.tyreTableView.delegate) {
        self.tyreTableView.delegate = self;
        self.tyreTableView.dataSource = self;
    }

    [self.tyreTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TiresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TiresCell_id" forIndexPath:indexPath];
    [cell setTiresModel:self.tiresNumArr[indexPath.row] orderType:@"1"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.tiresNumArr) {
        return self.tiresNumArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}


@end
