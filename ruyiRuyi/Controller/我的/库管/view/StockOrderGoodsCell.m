//
//  StockOrderGoodsCell.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/25.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockOrderGoodsCell.h"
#import "MBProgressHUD+YYM_category.h"
@implementation StockOrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.shuliangTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textChanged:(UITextField *)sender{
    
    CGFloat danjia = [self.model.totalMoney floatValue];
    NSInteger sl = [sender.text integerValue];
    NSString *je = [NSString stringWithFormat:@"%.2f",danjia * sl];
    self.jineLab.text = je;
    
    self.model.totalPrice = je;
    self.model.stockNumber = [NSString stringWithFormat:@"%ld",(long)sl];
    
    if (self.editBlock) {
        self.editBlock(sender.text);
    }
}
- (IBAction)caozuoAction:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"添加"]) {
        
        if ([self.shuliangTextField.text longLongValue] <= 0) {
            [MBProgressHUD showTextMessage:@"请输入数量！"];
            return;
        }
        if (self.addBlock) {
            self.addBlock(self.model);
        }
    }else{
        if (self.deleteBlock) {
            self.deleteBlock(self.model);
        }
    }
    
}

- (void)setModel:(StockOrderGoodsModel *)model{
    _model = model;
    
    self.danjiaLab.text = [NSString stringWithFormat:@"%@",model.totalMoney];
    self.huawenLab.text = [NSString stringWithFormat:@"%@",model.flgureName];
    self.leibieLab.text = [NSString stringWithFormat:@"%@",model.type];
    self.guigeLab.text = [NSString stringWithFormat:@"%@",model.size];
    
    self.shuliangTextField.text = [NSString stringWithFormat:@"%@",model.stockNumber];
    
    if ([model.totalPrice longLongValue] <=0) {
        self.jineLab.text = @"0.00";
    }else{
        self.jineLab.text = [NSString stringWithFormat:@"%@",model.totalPrice];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
