//
//  WeChatViewController.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^setingWechatInfoBlock)(NSString *name,NSString *openID);

@interface WeChatViewController : BaseViewController

@property(nonatomic,copy)setingWechatInfoBlock block;

@end
