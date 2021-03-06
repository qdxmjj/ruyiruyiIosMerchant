//
//  ProjectLayout.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ProjectLayout.h"
#import "JJMacro.h"
@implementation ProjectLayout
-(void)prepareLayout{
    [super prepareLayout];
    // 1.设置列间距
    self.minimumInteritemSpacing = 1;
    // 2.设置行间距
    self.minimumLineSpacing = 5;
    // 3.设置每个item的大小
    // 4.设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //    self.estimatedItemSize = CGSizeMake(320, 60);
    // 5.设置布局方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);

    self.itemSize = CGSizeMake((SCREEN_WIDTH - 20 - 32)/3, 35);
}
@end
