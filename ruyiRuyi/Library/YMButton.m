//
//  YMButton.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "YMButton.h"

@implementation YMButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    CGFloat titleX = 0;
//    CGFloat titleY = contentRect.size.height *0.3;
//    CGFloat titleW = contentRect.size.width;
//    CGFloat titleH = contentRect.size.height - titleY;
//    return CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleH = CGRectGetHeight(contentRect)/2;
    return CGRectMake(0,  CGRectGetHeight(contentRect) - titleH, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = CGRectGetWidth(contentRect) * self.ym_imageMultiplier;
    CGFloat imageH = CGRectGetHeight(contentRect) * self.ym_imageMultiplier;
    return CGRectMake(CGRectGetWidth(contentRect)/2 - imageW/2,  CGRectGetHeight(contentRect)/2 - imageH, imageW, imageH);
}

@end
