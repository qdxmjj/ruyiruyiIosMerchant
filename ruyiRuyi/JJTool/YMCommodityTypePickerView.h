//
//  YMCommodityTypePickerView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^dismisBlock)(NSString *FieldText,NSString *selectServiceTypeID,NSString *selectServiceID,BOOL isDismis);


@interface YMCommodityTypePickerView : UIView

@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,copy)dismisBlock disBlock;

-(void)show;

@end
