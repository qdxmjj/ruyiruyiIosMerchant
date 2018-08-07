//
//  ProjectCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ProjectCell.h"
#import "EnrollmentRequestData.h"
#import "ProjectCollectionViewCell.h"
#import "JJMacro.h"

@interface ProjectCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *projectCollectionView;


@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.projectCollectionView.delegate = self;
    self.projectCollectionView.dataSource = self;
    self.projectCollectionView.allowsMultipleSelection = YES;//实现多选必须实现这个方法

    [self.projectCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProjectCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ProjectCollectionCell"];
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        JJWeakSelf
        [EnrollmentRequestData getStoreServiceTypeWithSuccrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
            
            NSLog(@"服务列表：%@  %@  %@",code,message,data);
            
            weakSelf.dataArr =data;
            
            [weakSelf.projectCollectionView reloadData];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
    return self;
}
//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.dataArr.count>0) {
        
        return self.dataArr.count;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ProjectCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectCollectionCell" forIndexPath:indexPath];
    if (self.dataArr.count<=0) {
        cell.titleLab.text = @"无数据！";
    }else{
    cell.titleLab.text = [self.dataArr[indexPath.row] objectForKey:@"name"];
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectCollectionViewCell *cell = (ProjectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLab.backgroundColor = [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1];
    cell.titleLab.textColor = [UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1];
//    NSLog(@"cell状态：%@", cell.selected ? @"YES" : @"NO");
    if (self.dataArr.count!=0)
    [self.selectItems removeObject:[self.dataArr[indexPath.row] objectForKey:@"id"]];

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProjectCollectionViewCell *cell = (ProjectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLab.backgroundColor = [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:35.f/255.f alpha:1];
    cell.titleLab.textColor = [UIColor whiteColor];
    
    if (self.dataArr.count!=0)
    [self.selectItems addObject:[self.dataArr[indexPath.row] objectForKey:@"id"]];
        
//    NSLog(@"cell状态：%@", cell.selected ? @"YES" : @"NO");
}

//  允许选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    

        return YES;
}

//允许取消选中
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
     

         return YES;
 }

-(NSMutableArray *)selectItems{
    
    if (!_selectItems) {
        _selectItems = [NSMutableArray array];
    }
    
    
    return _selectItems;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
