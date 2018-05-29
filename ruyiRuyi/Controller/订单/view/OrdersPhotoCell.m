//
//  OrdersPhotoCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrdersPhotoCell.h"
#import "ZZYPhotoHelper.h"
@interface OrdersPhotoCell ()

@property (weak, nonatomic) IBOutlet UIButton *delPhotoBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectPhotoBen;

@end
@implementation OrdersPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)selectPhoto:(UIButton *)sender {
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        if (data) {
            
            [sender setImage:(UIImage *)data forState:UIControlStateNormal];
            self.delPhotoBtn.hidden = NO;
        }
        
    }];
    
}
- (IBAction)delPhoto:(UIButton *)sender {
    
    [self.selectPhotoBen setImage:NULL forState:UIControlStateNormal];
    self.delPhotoBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
