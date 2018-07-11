//
//  SelectServiceCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SelectServiceCell.h"
#import "JJMacro.h"
@interface SelectServiceCell ()
@end


@implementation SelectServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)setCellType:(StoreServiceType)serviceType{
    
    switch (serviceType) {
        case StoreConfirmServiceType:
            
            [self.ServiceTypeBtn setBackgroundColor:JJThemeColor];
            [self.ServiceTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.ServiceTypeBtn.layer.cornerRadius = 5.f;
            self.ServiceTypeBtn.layer.masksToBounds =YES;
            [self.ServiceTypeBtn setTitle:@"确认服务" forState:UIControlStateNormal];
            
            break;
        case StoreRefuseServiceType:
            
            [self.ServiceTypeBtn setTitle:@"拒绝服务" forState:UIControlStateNormal];
            [self.ServiceTypeBtn setBackgroundColor:[UIColor whiteColor]];
            [self.ServiceTypeBtn setTitleColor:JJThemeColor forState:UIControlStateNormal];
            
            self.ServiceTypeBtn.layer.borderColor = [JJThemeColor CGColor];
            self.ServiceTypeBtn.layer.borderWidth = 1.0f;
            self.ServiceTypeBtn.layer.cornerRadius = 5.f;
            self.ServiceTypeBtn.layer.masksToBounds =YES;
            
            break;
        case clientSelfHelpServiceType:
            
            [self.ServiceTypeBtn setTitle:@"客户自提" forState:UIControlStateNormal];
            [self.ServiceTypeBtn setBackgroundColor:[UIColor whiteColor]];
            
            self.ServiceTypeBtn.layer.borderColor = [JJThemeColor CGColor];
            self.ServiceTypeBtn.layer.borderWidth = 1.0f;
            [self.ServiceTypeBtn setTitleColor:JJThemeColor forState:UIControlStateNormal];
            self.ServiceTypeBtn.layer.cornerRadius = 5.f;
            self.ServiceTypeBtn.layer.masksToBounds =YES;
            
            break;
            
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
