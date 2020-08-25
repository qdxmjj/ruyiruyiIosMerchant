//
//  SaoMaCell.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/16.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "SaoMaCell.h"

@implementation SaoMaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)delAction:(id)sender {
    
    if (self.delBlock) {
        self.delBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
