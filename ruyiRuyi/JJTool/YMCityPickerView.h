//
//  YMCityPickerView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cityBlcok)(NSString *province,NSString *city,NSString *area,NSString *cityID,NSString *areaID);

@interface YMCityPickerView : UIView

@property(nonatomic,strong)NSArray *cityArr;

-(void)show;
@property(nonatomic,copy)cityBlcok cityBlcok;

@end
