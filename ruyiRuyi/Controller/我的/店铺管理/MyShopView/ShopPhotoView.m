//
//  ShopPhotoView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopPhotoView.h"
#import "ShopPhotoCollectionViewCell.h"
#import "ZZYPhotoHelper.h"
#import <UIImageView+WebCache.h>
#import "JJRequest.h"
#import "JJMacro.h"
@interface ShopPhotoView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UIImageView *imgView;

@end
@implementation ShopPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLab];
        [self addSubview:self.imgView];
        [self addSubview:self.collectionView];
    }
    return  self;
}


-(void)setImgUrlArr:(NSArray *)imgUrlArr{

    _imgUrlArr = imgUrlArr;
    
    [self.collectionView reloadData];
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH-80, 30)];
        _titleLab.text = @"上传门店照片";
    }
    return _titleLab;
}

-(UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-16, 0, 30, 30)];
        _imgView.image = [UIImage imageNamed:@"ic_picture"];
        _imgView.contentMode = UIViewContentModeCenter;
    }
    return _imgView;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 1.设置列间距
        layout.minimumInteritemSpacing = 1;
        // 2.设置行间距
        layout.minimumLineSpacing = 1;
        // 3.设置每个item的大小

        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 32 - 40)/3, 75);
//        // 4.设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
//        layout.estimatedItemSize = CGSizeMake(320, 60);
//        // 5.设置布局方向
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        // 6.设置头视图尺寸大小
//        layout.headerReferenceSize = CGSizeMake(50, 50);
//        // 7.设置尾视图尺寸大小
//        layout.footerReferenceSize = CGSizeMake(50, 50);
//        // 8.设置分区(组)的EdgeInset（四边距）
        layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
//        // 9.10.设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
//        layout.sectionFootersPinToVisibleBounds = YES;
//        layout.sectionHeadersPinToVisibleBounds = YES;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.frame), self.frame.size.height-30) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopPhotoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"ShopPhotoCollectionViewCellID"];
    }
    return _collectionView;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ShopPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopPhotoCollectionViewCellID" forIndexPath:indexPath];
    
    [cell.delBtn addTarget:self action:@selector(delPhotoEvent:) forControlEvents:UIControlEventTouchUpInside];

    if (self.imgUrlArr.count >= 3) {
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgUrlArr[indexPath.row]]];
        cell.delBtn.hidden = NO;
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.imgUrlArr.count>0) {
        
        return self.imgUrlArr.count;
    }
    return 3;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopPhotoCollectionViewCell *cell = (ShopPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.imgView.image) {
        
        return;
    }
    [[ZZYPhotoHelper shareHelper]showImageViewSelcteWithResultBlock:^(id data) {
      
        cell.imgView.image = (UIImage *)data;
        cell.delBtn.hidden = NO;
    }];
}

-(void)delPhotoEvent:(UIButton *)sender{
    
    ShopPhotoCollectionViewCell *cell = (ShopPhotoCollectionViewCell *) sender.superview.superview;
    
    cell.imgView.image = nil;
    cell.delBtn.hidden = YES;
}

-(UIImage *)location_img{
    
    ShopPhotoCollectionViewCell *cell = (ShopPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (cell.imgView.image) {
        
        return  cell.imgView.image;
    }
    return nil;
}
-(UIImage *)indoor_img{
    
    ShopPhotoCollectionViewCell *cell = (ShopPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (cell.imgView.image) {
        
        return  cell.imgView.image;
    }
    return nil;
}
-(UIImage *)factory_img{
    
    ShopPhotoCollectionViewCell *cell = (ShopPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (cell.imgView.image) {
        
        return  cell.imgView.image;
    }
    return nil;
}
@end
