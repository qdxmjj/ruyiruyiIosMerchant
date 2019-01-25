//
//  AddCommodityCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCommodityCell;
@protocol addCommodityCellDelegate <NSObject>

- (void)addCommodityCell:(AddCommodityCell *)cell isSpecialPriceGoods:(BOOL)on;

@end

@interface AddCommodityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *addCommoditySwitch;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *cell1TitleLab;
@property (weak, nonatomic) IBOutlet UITextView *contentLab;

@property (weak, nonatomic) id <addCommodityCellDelegate >delegate;

@end
