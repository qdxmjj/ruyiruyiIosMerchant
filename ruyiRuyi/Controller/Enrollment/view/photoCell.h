//
//  photoCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJFileParam.h"
@interface photoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *photoTitle;//分别设置当前cell的标题

@property(nonatomic,strong)NSArray *itemContentArr;//item提示内容

@property(nonatomic,strong)UIImage *img1;
@property(nonatomic,strong)UIImage *img2;
@property(nonatomic,strong)UIImage *img3;

@end
