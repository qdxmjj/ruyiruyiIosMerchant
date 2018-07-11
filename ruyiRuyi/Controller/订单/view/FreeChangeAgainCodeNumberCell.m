//
//  FreeChangeAgainCodeNumberCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "FreeChangeAgainCodeNumberCell.h"
#import "YMStoreTypePickerView.h"
#import <Masonry.h>
#import "JJMacro.h"

@implementation FreeChangeAgainCodeNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self.contentView addSubview:self.replaceCodeNumberlab];
        [self.contentView addSubview:self.deleCodeNumberBtn];
        
        [self.deleCodeNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.contentView.mas_right).inset(16);
            make.width.height.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            
        }];
        
        [self.replaceCodeNumberlab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.deleCodeNumberBtn.mas_left);
            make.height.mas_equalTo(self.contentView.mas_height);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            
        }];
        
    }
    
    return self;
}

-(void)newBarCodeHidden:(BOOL)hidden{
    
    self.replaceCodeNumberlab.hidden = hidden;
    self.deleCodeNumberBtn.hidden = hidden;
    
}

-(UILabel *)replaceCodeNumberlab{
    
    if (!_replaceCodeNumberlab ) {
        
        _replaceCodeNumberlab = [[UILabel alloc] init];
        _replaceCodeNumberlab.textAlignment = NSTextAlignmentRight;
        _replaceCodeNumberlab.hidden = YES;
    }
    return _replaceCodeNumberlab;
}

-(UIButton *)deleCodeNumberBtn{
    
    if (!_deleCodeNumberBtn) {
        
        _deleCodeNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleCodeNumberBtn setImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
        [_deleCodeNumberBtn setHidden:YES];
    }
    
    return _deleCodeNumberBtn;
}

@end
