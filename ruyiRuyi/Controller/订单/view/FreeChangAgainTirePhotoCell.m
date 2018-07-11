//
//  FreeChangAgainTirePhotoCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangAgainTirePhotoCell.h"
#import "ZZYPhotoHelper.h"

@implementation FreeChangAgainTirePhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

}
- (IBAction)selectTirePhotoEvent:(UIButton *)sender {
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        if (data) {
            
            [sender setImage:(UIImage *)data forState:UIControlStateNormal];
            self.deleteTirePhotoBtn.hidden = NO;
        }
        
    }];
    
}

- (IBAction)deleteTirePhotoEvent:(UIButton *)sender {
    
    [self.selectTirePhotoBtn setImage:nil forState:UIControlStateNormal];
    [self.selectTirePhotoBtn.imageView setImage:nil];
    self.deleteTirePhotoBtn.hidden = YES;
    
}

- (IBAction)selectBarCodePhotoEvent:(UIButton *)sender {
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        if (data) {
            
            [sender setImage:(UIImage *)data forState:UIControlStateNormal];
            self.deleteBarCodeBtn.hidden = NO;
        }
        
    }];
}

- (IBAction)deleteBarCodePhotoEvent:(UIButton *)sender {
    
    [self.selectBarCodeBtn setImage:nil forState:UIControlStateNormal];
    [self.selectBarCodeBtn.imageView setImage:nil];
    self.deleteBarCodeBtn.hidden = YES;
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
