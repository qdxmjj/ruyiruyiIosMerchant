//
//  ShopItemCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopItemCell.h"
#import "ShopItemCollectionViewCell.h"

@interface ShopItemCell()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *ShopCollectionView;


@end
@implementation ShopItemCell

- (void)awakeFromNib {
    [super awakeFromNib];


    self.ShopCollectionView.delegate = self;
    self.ShopCollectionView.dataSource = self;
    self.ShopCollectionView.allowsMultipleSelection = YES;//允许多选

    [self.ShopCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopItemCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ShopItemCollectionCell"];

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        

    }
    return self;
}
//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (self.shopItemArr.count>0) {
        
        return self.shopItemArr.count;
    }

    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShopItemCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ShopItemCollectionCell" forIndexPath:indexPath];
    
    cell.itemTextLab.text =[self.shopItemArr[indexPath.row] objectForKey:@"name"];
    


    BOOL isSelect = [self.defaultSelectItems containsObject:cell.itemTextLab.text];
    if (isSelect) {
        
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
//        [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        
        cell.selected = YES;//必须得设置，不然默认选中无效
        cell.itemTextLab.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f];
        cell.itemTextLab.textColor = [UIColor whiteColor];
    }


    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopItemCollectionViewCell *cell = (ShopItemCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.itemTextLab.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1.f];
    cell.itemTextLab.textColor = [UIColor whiteColor];

}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopItemCollectionViewCell *cell = (ShopItemCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.itemTextLab.backgroundColor = [UIColor colorWithRed:169.f/255.f green:169.f/255.f blue:169.f/255.f alpha:1.f];
    cell.itemTextLab.textColor = [UIColor whiteColor];
    
}
-(void)setShopItemArr:(NSArray *)shopItemArr{
    
    _shopItemArr = shopItemArr;
    if (self.shopItemArr.count>0) {
        
        [self.ShopCollectionView reloadData];
    }

}


-(NSArray *)selelItems{
    
    NSMutableArray *arr = [NSMutableArray array];

    
    if (self.ShopCollectionView.indexPathsForSelectedItems.count<=0) {
        
        return @[];
    }
    
    for (NSIndexPath *indexPath in self.ShopCollectionView.indexPathsForSelectedItems) {
        
        
        [arr addObject:[self.shopItemArr[indexPath.item] objectForKey:@"id"]];
        
    }
    
    return arr;
}


-(void)setDefaultSelectItems:(NSArray *)defaultSelectItems{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in defaultSelectItems) {
        
        [arr addObject:[dic objectForKey:@"service"]];
    }

    NSMutableArray *nameArr = [NSMutableArray array];
    for (NSDictionary *serviceDic in arr) {
        
        [nameArr addObject:[serviceDic objectForKey:@"name"]];
    }
    
    _defaultSelectItems = nameArr;
    
    if (_defaultSelectItems.count>0) {
        
        [self.ShopCollectionView reloadData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
