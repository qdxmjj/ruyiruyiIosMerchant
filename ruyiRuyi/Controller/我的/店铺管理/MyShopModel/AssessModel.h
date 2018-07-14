//
//  AssessModel.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssessModel : NSObject

@property(nonatomic,strong)NSURL *handImg;

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *img1Url;

@property(nonatomic,copy)NSString *img2Url;

@property(nonatomic,copy)NSString *img3Url;

@property(nonatomic,copy)NSString *img4Url;

@property(nonatomic,copy)NSString *img5Url;

@property(nonatomic,strong)NSMutableArray *imaArr;

@property(nonatomic,copy)NSString *storeCommitUserName;

@property(nonatomic,copy)NSString *storeAddress;

@property(nonatomic,copy)NSString *storeLocation;

@property(nonatomic,copy)NSString *storeName;

@end
