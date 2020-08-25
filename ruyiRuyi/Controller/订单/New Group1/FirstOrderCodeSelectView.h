//
//  FirstOrderCodeSelectView.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstOrderBaseView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^showSelectCodeViewBlock) (NSInteger section);
@interface FirstOrderCodeSelectView : FirstOrderBaseView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *selectCodeTableView;

///前后轮是否一致
@property (nonatomic, assign) BOOL isYiZhi;

@property (nonatomic, strong) NSMutableArray *frontCodeArray;

@property (nonatomic, strong) NSMutableArray *rearCodeArray;

///选择条形码赋值后，刷新页面
- (void)reload;

@property (nonatomic, copy) showSelectCodeViewBlock showBlock;

@end

NS_ASSUME_NONNULL_END
