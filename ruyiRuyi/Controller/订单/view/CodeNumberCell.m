//
//  CodeNumberCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "CodeNumberCell.h"

@implementation CodeNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //带有nib 就会执行此方法，所有对象意见初始化成功 而外添加可在此进行
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
