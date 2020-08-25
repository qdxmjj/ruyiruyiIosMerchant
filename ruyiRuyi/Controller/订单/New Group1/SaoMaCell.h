//
//  SaoMaCell.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/16.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^delBarCodeBlock) (void);
@interface SaoMaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@property (nonatomic, copy) delBarCodeBlock delBlock;

@end

NS_ASSUME_NONNULL_END
