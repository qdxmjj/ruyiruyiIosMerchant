//
//  ShopInfoCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopInfoCell.h"
#import "YMDatePickerView.h"
@implementation ShopInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selelctStoreTime:(id)sender {
    
    
    YMDatePickerView *dateView = [[YMDatePickerView alloc] init];
    
    dateView.selectTime = ^(NSString *starTime, NSString *stopTime) {
        
        
        [self.storeTimeBtn setTitle:[NSString stringWithFormat:@"%@至%@",starTime,stopTime] forState:UIControlStateNormal];
    };
    [dateView show];
    
    
}

@end
