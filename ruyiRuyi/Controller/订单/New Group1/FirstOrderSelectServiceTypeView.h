//
//  FirstOrderSelectServiceTypeView.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstOrderBaseView.h"
#import "MainOrdersRequest.h"
@class FirstOrderSelectServiceTypeView;
NS_ASSUME_NONNULL_BEGIN


@protocol FirstOrderSelectServiceTypeViewDelegate <NSObject>

- (void)FirstOrderSelectServiceTypeView:(FirstOrderSelectServiceTypeView *)serviceView serviceType:(StoreServiceType )type;

@end

@interface FirstOrderSelectServiceTypeView : FirstOrderBaseView

@property (weak, nonatomic) IBOutlet UIButton *querenBtn;

@property (weak, nonatomic) IBOutlet UIButton *jujueBtn;

@property (weak, nonatomic) IBOutlet UIButton *zitiBtn;

@property (nonatomic, weak) id <FirstOrderSelectServiceTypeViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
