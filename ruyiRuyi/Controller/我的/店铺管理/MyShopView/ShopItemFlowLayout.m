//
//  ShopItemFlowLayout.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopItemFlowLayout.h"
#import "JJMacro.h"
@implementation ShopItemFlowLayout


-(void)prepareLayout{
    [super prepareLayout];
    // 1.设置列间距
    self.minimumInteritemSpacing = 10;
    // 2.设置行间距
    self.minimumLineSpacing = 5;
    // 3.设置每个item的大小
    // 4.设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //    self.estimatedItemSize = CGSizeMake(320, 60);
    // 5.设置布局方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    //32 = collection距离 collectionview的左右间距 16+16       60 = 三个item 左右两边 列间距10
    
    self.itemSize = CGSizeMake((SCREEN_WIDTH-60-32)/3, 35);

}

@end
