//
//  IncomeOrderCell.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeOrderCell.h"
#import "UIImage+ImageRoundedCorner.h"
@implementation IncomeOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImage *image = [UIImage imageNamed:@"shareIMG"];
    image = [image imageAddCornerWithRadius:25.f andSize:CGSizeMake(50, 50)];
    self.serviceCellImageView.image = image;
    
    UIImage *saleImage = [UIImage imageNamed:@"shareIMG"];
    saleImage = [saleImage imageAddCornerWithRadius:40.f andSize:CGSizeMake(80, 80)];
    self.saleCellImageView.image = saleImage;
}

-(void)setIncomeInfoByModel:(IncomeModel *)model{
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
