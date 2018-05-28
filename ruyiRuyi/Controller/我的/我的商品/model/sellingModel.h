//
//  sellingModel.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sellingModel : NSObject

@property(nonatomic,copy)NSString *imgUrl;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)NSNumber *price;

@property(nonatomic,strong)NSNumber *amount;

@property(nonatomic,strong)NSNumber *soldNo;


@end
