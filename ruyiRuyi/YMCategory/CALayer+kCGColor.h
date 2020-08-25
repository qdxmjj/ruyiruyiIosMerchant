//
//  CALayer+kCGColor.h
//  YeMai
//
//  Created by yym on 2020/4/8.
//  Copyright © 2020 jacob. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CALayer (kCGColor)

@property (nonatomic, weak)UIColor *borderUIColor;
@property (nonatomic, weak)UIColor *shadowXIBColor;

@end

NS_ASSUME_NONNULL_END
