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
#import "JJTools.h"
#import <UIImageView+WebCache.h>
#import "SDPhotoBrowser.h"
@interface AssessCell()<UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>


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
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ic_my_shibai" ofType:@"png"];

    [cell.itemImg sd_setImageWithURL:self.dataImgArr[indexPath.row]  placeholderImage:[[UIImage alloc] initWithContentsOfFile:imagePath]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    //设置容器视图,父视图
    browser.sourceImagesContainerView = self.imgCollectionView;
    
    browser.currentImageIndex = indexPath.item;
    
    browser.imageCount = self.dataImgArr.count;
    
    //设置代理
    browser.delegate = self;
    //显示图片浏览器
    [browser show];
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index

{
    //拿到显示的图片的高清图片地址
    NSURL *url = [NSURL URLWithString:self.dataImgArr[index]];
    return url;
}

//返回占位图片
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index

{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    AssessCollectionViewCell *cell = (AssessCollectionViewCell *)[self.imgCollectionView cellForItemAtIndexPath:indexPath];
    return cell.itemImg.image;
}

- (void)setModel:(AssessModel *)model
{
    
    self.contentlab.text = model.content;
    [self.headImg sd_setImageWithURL:model.handImg placeholderImage:[UIImage imageNamed:@"ic_my_shibai"] options:SDWebImageRefreshCached];
    
    self.titleLab.text = model.storeCommitUserName;
    self.timeLab.text = [JJTools getTimestampFromTime:[NSString stringWithFormat:@"%@",model.time] formatter:@"yyyy-MM-dd"];
    if (model.imaArr.count<=0) {

        self.bottomViewH.constant = 0.1f;
    }else{

        self.bottomViewH.constant = 50+10+10;
    }
    self.dataImgArr = model.imaArr;
    [self.imgCollectionView reloadData];
}

@end
