//
//  FirstOrderBaseView.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderBaseView.h"

@implementation FirstOrderBaseView


-(instancetype)init{
//    self = [super init];
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    
    return self;
}

@end
