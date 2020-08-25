//
//  FirstOrderSelectServiceTypeView.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderSelectServiceTypeView.h"
#import "CALayer+kCGColor.h"
@implementation FirstOrderSelectServiceTypeView

- (IBAction)selectServiceTypeAction:(UIButton *)sender {
    
    StoreServiceType type = 0;

    if (sender == self.querenBtn) {
        type = StoreConfirmServiceType;
    }
    if (sender == self.jujueBtn) {
        type = StoreRefuseServiceType;

    }
    if (sender == self.zitiBtn) {
        type = clientSelfHelpServiceType;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(FirstOrderSelectServiceTypeView:serviceType:)]) {
        
        [self.delegate FirstOrderSelectServiceTypeView:self serviceType:type];
    }
}

@end
