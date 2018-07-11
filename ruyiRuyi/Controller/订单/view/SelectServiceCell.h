//
//  SelectServiceCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainOrdersRequest.h"

@interface SelectServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *ServiceTypeBtn;

-(void)setCellType:(StoreServiceType )serviceType;



@end
