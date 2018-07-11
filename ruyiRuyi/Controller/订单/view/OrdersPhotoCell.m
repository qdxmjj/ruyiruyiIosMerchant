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


@end
@implementation OrdersPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.exampleBtn.layer.cornerRadius = 3;
    self.exampleBtn.layer.borderWidth = 1;
    self.exampleBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];//
    self.exampleBtn.layer.masksToBounds = YES;
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
    
    [self.selectPhotoBen setImage:nil forState:UIControlStateNormal];
    [self.selectPhotoBen.imageView setImage:nil];
    self.delPhotoBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
