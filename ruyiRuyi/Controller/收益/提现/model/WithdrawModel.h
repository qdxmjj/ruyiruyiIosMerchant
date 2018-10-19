//
//  WithdrawModel.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawModel : NSObject

@property(nonatomic,copy)NSString *aliAccount;
@property(nonatomic,copy)NSNumber *applyTime;
@property(nonatomic,copy)NSString *auditResult;
@property(nonatomic,copy)NSString *auditResultDesc;
@property(nonatomic,copy)NSString *auditTime;
@property(nonatomic,copy)NSString *auditor;
@property(nonatomic,copy)NSString *availableMoney;
@property(nonatomic,copy)NSString *createdBy;
@property(nonatomic,copy)NSString *createdTime;
@property(nonatomic,copy)NSString *deletedBy;
@property(nonatomic,copy)NSString *deletedFlag;
@property(nonatomic,copy)NSString *iDNumber;
@property(nonatomic,copy)NSString *lastUpdatedBy;
@property(nonatomic,copy)NSString *lastUpdatedTime;
@property(nonatomic,copy)NSString *order;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *page;
@property(nonatomic,copy)NSString *realName;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,strong)NSNumber *status;//提现状态（1提现中/2提现成功/3提现失败）
@property(nonatomic,copy)NSNumber *type; //提现类型（1支付宝提现/2微信提现）
@property(nonatomic,copy)NSNumber *withdrawMoney;


@end
