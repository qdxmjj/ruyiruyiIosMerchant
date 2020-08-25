//
//  CALayer+kCGColor.m
//  YeMai
//
//  Created by yym on 2020/4/8.
//  Copyright © 2020 jacob. All rights reserved.
//

#import "CALayer+kCGColor.h"
@implementation CALayer (kCGColor)

- (void)setBorderUIColor:(UIColor *)borderUIColor{
    
    self.borderColor = borderUIColor.CGColor;
}

- (UIColor *)borderUIColor{
    
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setShadowXIBColor:(UIColor *)shadowXIBColor{
    
    self.shadowColor = shadowXIBColor.CGColor;
}

- (UIColor *)shadowXIBColor{
    
    return [UIColor colorWithCGColor:self.shadowColor];
}
@end
