//
//  FreeChangeAgainCodeNumberCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeChangeAgainCodeNumberCell : UITableViewCell

//旧条形码
@property (weak, nonatomic) IBOutlet UILabel *codeNumberLab;
//替换按钮
@property (weak, nonatomic) IBOutlet UIButton *replaceBtn;

//新条形码
@property(strong,nonatomic)UILabel *replaceCodeNumberlab;
//删除新条形码
@property(strong,nonatomic)UIButton *deleCodeNumberBtn;


-(void)newBarCodeHidden:(BOOL)hidden;

@end
