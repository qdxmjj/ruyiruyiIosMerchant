//
//  DegreeCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "DegreeCell.h"

@implementation DegreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectBtn:(UIButton *)sender {
    
    
    [sender setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1]]
                      forState:UIControlStateSelected];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    if (!sender.selected) {
        
        
    }
    
    sender.selected = !sender.selected;
    
    if ([sender.titleLabel.text isEqualToString:@"熟练"]) {
        self.btn2.selected = !self.btn1.selected;
    }else{
        self.btn1.selected = !self.btn2.selected;
    }
    
    if (sender.selected) {
        
        self.selectBtn =sender.titleLabel.text;
    }else{
        
        self.selectBtn = @"";
    }
}


-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}
-(NSString *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn = [[NSString alloc] init];
    }
    
    
    return _selectBtn;
}
@end
