//
//  RecordingDetailsView.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordingDetailsView : UIView

@property(nonatomic,copy)NSString *isPayStatus;

@property(nonatomic,copy)NSString *withdrawAmount;

@property(nonatomic,copy)NSString *withdrawStatus;

@property(nonatomic,copy)NSString *receiptInfo;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *orderNO;

-(void)show;

-(void)dismiss;

@end
