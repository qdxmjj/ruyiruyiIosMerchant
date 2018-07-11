//
//  YMStoreTypePickerView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^storeTypeBlock)(NSString *storeType,NSString *typeID);

typedef void (^codeNumberBlock)(NSString *codeNumber);

@interface YMStoreTypePickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>


@property(nonatomic,strong)NSArray *typeArr;

-(void)show;

@property(nonatomic,copy)storeTypeBlock storeType;

@property(nonatomic,copy)codeNumberBlock codeNumberBlock;

@property(nonatomic,copy)NSString *status;
@end
