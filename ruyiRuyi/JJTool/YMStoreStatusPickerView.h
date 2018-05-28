//
//  YMStoreStatusPickerView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/21.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^statusBlcok)(NSString *statusID,NSString *statusStr);


@interface YMStoreStatusPickerView : UIView



@property(nonatomic,copy)statusBlcok statusBlcok;

-(void)show;
@end
