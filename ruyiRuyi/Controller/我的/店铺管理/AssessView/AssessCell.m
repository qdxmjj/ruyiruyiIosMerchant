//
//  AssessCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AssessCell.h"
#import "AssessModel.h"
#import "AssessCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@interface AssessCell()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewH;//底部视图的高

@property (weak, nonatomic) IBOutlet UICollectionView *imgCollectionView;


@property(nonatomic,strong)NSArray *dataImgArr;
@end

@implementation AssessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgCollectionView.delegate = self;
    self.imgCollectionView.dataSource = self;
    
    [self.imgCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AssessCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AssessCollectionCellID"];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (self.dataImgArr.count>0) {
        
        return self.dataImgArr.count;
    }
    
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AssessCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AssessCollectionCellID" forIndexPath:indexPath];
    
    [cell.itemImg sd_setImageWithURL:self.dataImgArr[indexPath.row]];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AssessCollectionViewCell *cell = (AssessCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    NSLog(@"点击的图片为：%@",cell.itemImg.image);
}


- (void)setModel:(AssessModel *)model
{
    self.contentlab.text = model.content;
    [self.headImg sd_setImageWithURL:model.handImg];
    
    
    if (model.imaArr.count<=0) {
        
        self.bottomViewH.constant = 0.f;
        
    }else{
        
        self.bottomViewH.constant = 50+10+10;
    }
    self.dataImgArr = model.imaArr;
    [self.imgCollectionView reloadData];
    
}

@end
