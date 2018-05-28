//
//  YMDatePickerView.h
//  YMDatePickerView
//
//  Created by 小马驾驾 on 2018/4/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectTimeBlock)(NSString *starTime,NSString *stopTime);

@interface YMDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *startPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *stopPickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property(nonatomic,copy)selectTimeBlock selectTime;

-(void)show;


@end
