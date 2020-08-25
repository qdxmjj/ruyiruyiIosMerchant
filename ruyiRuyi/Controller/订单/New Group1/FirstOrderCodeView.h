//
//  FirstOrderCodeView.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstOrderBaseView.h"
#import "CodeNumberCell.h"
#import "CodeNumheadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstOrderCodeView : FirstOrderBaseView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *codeTableView;

@property (strong, nonatomic) NSArray *codeNumArr;

@property(nonatomic,assign)BOOL switchHidden;

//+ (instancetype)initXibView;

@end

NS_ASSUME_NONNULL_END
