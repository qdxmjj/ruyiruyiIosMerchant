//
//  AssessFlowLayout.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AssessFlowLayout.h"
#import "JJMacro.h"
@implementation AssessFlowLayout



-(void)prepareLayout{
    [super prepareLayout];
    
//    self.estimatedItemSize = CGSizeMake(50, 50);
    
    // 1.设置列间距
    self.minimumInteritemSpacing = 10;
    // 2.设置行间距
//    self.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    
    // 5.设置布局方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    //133.4 109.4    行间距10  每个item距离左右都是10   五个item  每个item两个间距   5*2=10 10*10=100；
    self.itemSize = CGSizeMake((SCREEN_WIDTH-100)/5,(SCREEN_WIDTH-100)/5);
    
}

@end
