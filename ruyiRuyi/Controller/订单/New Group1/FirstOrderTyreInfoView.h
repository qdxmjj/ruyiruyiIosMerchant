//
//  FirstOrderTyreInfoView.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstOrderBaseView.h"
#import "TiresCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstOrderTyreInfoView : FirstOrderBaseView <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tyreTableView;

@property (strong, nonatomic) NSArray *tiresNumArr;

@end

NS_ASSUME_NONNULL_END
