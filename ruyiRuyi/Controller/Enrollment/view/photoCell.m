//
//  photoCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "photoCell.h"
#import "PhotoCollectionViewCell.h"
#import "ZZYPhotoHelper.h"
#import "JJMacro.h"
#import <UIImageView+WebCache.h>
@interface photoCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;


@end
@implementation photoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"photoCollectionCell"];
}

-(void)setItemContentArr:(NSArray *)itemContentArr{
    
    _itemContentArr = itemContentArr;
    
    [self.photoCollectionView reloadData];
}


//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.itemContentArr.count>0) {
        
        return self.itemContentArr.count;
    }
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PhotoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"photoCollectionCell" forIndexPath:indexPath];
    [cell.deleteImageBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.itemContentArr.count >=3) {
        cell.bottonTitleLab.text = self.itemContentArr[indexPath.row];
    }

    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    JJWeakSelf
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        
        cell.imageView.image =(UIImage *)data;
        
        switch (indexPath.row) {
            case 0:
                weakSelf.img1 = (UIImage *)data;
                break;
            case 1:
                weakSelf.img2 = (UIImage *)data;
                break;
            case 2:
                weakSelf.img3 = (UIImage *)data;
                break;
                
            default:
                break;
        }
        
        cell.bottonTitleLab.hidden = YES;
    }];
}

- (void)deleteImage:(UIButton *)sender {
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)sender.superview.superview;
    NSIndexPath *itemIndex = [self.photoCollectionView indexPathForCell:cell];
    switch (itemIndex.row) {
        case 0:
            self.img1 = NULL;
            break;
        case 1:
            self.img2 = NULL;
            break;
        case 2:
            self.img3 = NULL;
            break;
            
        default:
            break;
    }
    cell.imageView.image =  NULL;
    cell.bottonTitleLab.hidden = NO;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
