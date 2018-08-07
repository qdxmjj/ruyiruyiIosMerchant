//
//  DegreeCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickProtocolEventBlock)(BOOL isClick);

@interface DegreeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *confirmProtocolBtn;
@property(nonatomic,copy)NSString *selectBtn;

@property(nonatomic,copy)ClickProtocolEventBlock eventBlock;

@end
