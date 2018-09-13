//
//  TireNumberCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TireNumberCell.h"

@implementation TireNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CAShapeLayer *dottedLineBorder  = [[CAShapeLayer alloc] init];
    dottedLineBorder.frame = CGRectMake(0, 0, self.photoBtn.frame.size.width, self.photoBtn.frame.size.height);
    [dottedLineBorder setLineWidth:2];
    [dottedLineBorder setStrokeColor:[UIColor lightGrayColor].CGColor];
    [dottedLineBorder setFillColor:[UIColor clearColor].CGColor];
    dottedLineBorder.lineDashPattern = @[@3,@3];//10 - 线段长度 ，20 － 线段与线段间距
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:dottedLineBorder.frame];
    dottedLineBorder.path = path.CGPath;
    [self.photoBtn.layer addSublayer:dottedLineBorder];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
