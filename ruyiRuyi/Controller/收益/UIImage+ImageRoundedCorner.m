//
//  UIImage+ImageRoundedCorner.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "UIImage+ImageRoundedCorner.h"

@implementation UIImage (ImageRoundedCorner)

- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//作者：doudo
//链接：https://www.jianshu.com/p/e879aeff93f3
//來源：简书
//简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
@end
