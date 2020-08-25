//
//  FirstOrderSelectCodeViewController.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstOrderSelectCodeViewController : BaseViewController

@property (nonatomic, assign) NSInteger maxSelectCout;
@property (nonatomic, strong) NSArray *codeArray;
@property (nonatomic, strong) NSString *type;

@end

NS_ASSUME_NONNULL_END
