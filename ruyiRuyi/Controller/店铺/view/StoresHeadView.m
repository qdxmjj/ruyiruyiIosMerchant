//
//  StoresHeadView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/24.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "StoresHeadView.h"
#import "UserConfig.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "ZZYPhotoHelper.h"

#import "StoresRequest.h"
#import "JJMacro.h"
@implementation StoresHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUI];
    }
    
    return self;
}

-(void)layoutSubviews{
    
    
    
    
}

-(void)setMonthIncomeStr:(NSString *)monthIncomeStr{
    
    [self.leftBtn setTitle:[NSString stringWithFormat:@"%@（元）",monthIncomeStr] forState:UIControlStateNormal];

}


-(void)setTotalIncomeStr:(NSString *)totalIncomeStr{
    
    [self.rigBtn setTitle:[NSString stringWithFormat:@"%@（元）",totalIncomeStr] forState:UIControlStateNormal];

    
}

-(void)setUI{
    
    UIImageView *handerImg = [[UIImageView alloc] init];
    handerImg.image = [UIImage imageNamed:@"ic_ground"];
    handerImg.userInteractionEnabled = YES;
    [self addSubview:handerImg];
    
    
    self.subImg = [[UIImageView alloc] init];
    self.subImg.backgroundColor = [UIColor lightGrayColor];
    self.subImg.userInteractionEnabled = YES;
    NSString *url = [NSString stringWithFormat:@"%@",[UserConfig storeImgUrl]];
    UITapGestureRecognizer *soingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [self.subImg addGestureRecognizer:soingleTap];
    [self.subImg sd_setImageWithURL:[NSURL URLWithString:url]];
    
    [handerImg addSubview:self.subImg];
    
    self.titlLab = [[UILabel alloc] init];
    self.titlLab.text = [UserConfig storeName];
    self.titlLab.textAlignment = NSTextAlignmentCenter;
    self.titlLab.textColor = [UIColor whiteColor];
    [handerImg addSubview:self.titlLab];
    
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor whiteColor];
    toolView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    toolView.layer.shadowOpacity = 0.8;
    toolView.layer.shadowOffset = CGSizeMake(0, 0);
    toolView.layer.cornerRadius = 5;
    [self addSubview:toolView];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [toolView addSubview:lineView];
    
    UILabel *undoneLab = [[UILabel alloc] init];
    undoneLab.text = @"本月收益";
    undoneLab.textAlignment = NSTextAlignmentCenter;
    undoneLab.textColor = [UIColor blackColor];
    [toolView addSubview:undoneLab];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [toolView addSubview:self.leftBtn];
    
    
    UILabel *fulfilLab = [[UILabel alloc] init];
    fulfilLab.text = @"总收益";
    fulfilLab.textAlignment = NSTextAlignmentCenter;
    fulfilLab.textColor = [UIColor blackColor];
    [toolView addSubview:fulfilLab];
    
    
    self.rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rigBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.rigBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [toolView addSubview:self.rigBtn];
    
    
    [handerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(self.bounds.size.height*0.8);
        
    }];
    
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
        make.bottom.mas_equalTo(self.mas_bottom).inset(10);
        
    }];
    
    
    [self.titlLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(toolView.mas_top).inset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@20);
    }];
    
    [self.subImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.and.height.mas_equalTo(CGSizeMake(100, 100));
        make.bottom.mas_equalTo(self.titlLab.mas_top).inset(5);
        make.centerX.mas_equalTo(handerImg.mas_centerX);
        
        
    }];
    self.subImg.layer.cornerRadius = 50.f;
    self.subImg.layer.masksToBounds =YES;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(toolView.mas_centerX);
        make.centerY.mas_equalTo(toolView.mas_centerY);
        make.height.mas_equalTo(toolView.mas_height).offset(-20);
        
    }];
    
    
    [undoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(toolView.mas_top);
        make.left.mas_equalTo(toolView.mas_left);
        make.right.mas_equalTo(lineView.mas_left);
        make.height.mas_equalTo(toolView.mas_height).multipliedBy(0.5);
        
    }];
    
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(toolView.mas_left);
        make.right.mas_equalTo(lineView.mas_left);
        make.top.mas_equalTo(undoneLab.mas_bottom).offset(5);
        make.bottom.mas_equalTo(toolView.mas_bottom);
    }];
    
    
    [fulfilLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(toolView.mas_top);
        make.left.mas_equalTo(lineView.mas_right);
        make.right.mas_equalTo(toolView.mas_right);
        make.height.mas_equalTo(toolView.mas_height).multipliedBy(0.5);
        
    }];
    
    
    [self.rigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(lineView.mas_right);
        make.right.mas_equalTo(toolView.mas_right);
        make.top.mas_equalTo(fulfilLab.mas_bottom).offset(5);
        make.bottom.mas_equalTo(toolView.mas_bottom);
        
    }];
}

- (void)selectPhoto:(UIGestureRecognizer *)sender
{
        [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
    
            self.subImg.image = (UIImage *)data;
    
            NSData *imgData = UIImageJPEGRepresentation((UIImage *)data, 0.3);
    
            NSLog(@"%@",imgData);
            
            [StoresRequest updateStoreHeadImgByStoreIdWithInfo:@{@"storeId":[UserConfig storeID],@"headImgUrl":[UserConfig storeImgUrl]} headPhoto:@[[JJFileParam fileConfigWithfileData:imgData name:@"store_head_img" fileName:@"newheadPhoto.png" mimeType:@"image/jpg/png/jpeg"]] succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    
    
                [UserConfig userDefaultsSetObject:data key:KstoreImgUrl];
    
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updataHeadPhotoNotification" object:nil];
                
            } failure:^(NSError * _Nullable error) {
    
            }];
        }];
}

@end
