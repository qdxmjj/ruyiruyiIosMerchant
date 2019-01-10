//
//  IncomeDatePickerView.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IncomeDatePickerView;

@protocol selectDateDelegate <NSObject>

-(void)selectDateWithYear:(NSString *)year month:(NSString *)month;

@end
@interface IncomeDatePickerView : UIView

-(void)showWithSuperView:(UIView *)view;

@property(nonatomic,assign)id <selectDateDelegate> delegate;

@end
