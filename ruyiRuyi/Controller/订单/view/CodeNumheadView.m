//
//  CodeNumheadView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "CodeNumheadView.h"
#import "JJMacro.h"
@implementation CodeNumheadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 40)];
        leftLab.text = @"条形码";
        leftLab.textAlignment = NSTextAlignmentCenter;
        leftLab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:leftLab];
        
        UILabel *rigthLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 40)];
        rigthLab.text = @"是否不一致";
        rigthLab.textAlignment = NSTextAlignmentCenter;
        rigthLab.backgroundColor = [UIColor whiteColor];
        rigthLab.tag = 1001011;
        [self.contentView addSubview:rigthLab];
        
    }
    return self;
}

-(void)setRigthTextHidden:(BOOL)rigthTextHidden{
    
    UILabel *lab = [self viewWithTag:1001011];
    if (rigthTextHidden) {
         lab.text = @"";
    }
   
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
