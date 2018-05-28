//
//  AssessModel.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AssessModel.h"

@implementation AssessModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"content"]) {
        
        _content = value;
    }
    if ([key isEqualToString:@"img1Url"]) {
        
//        _img1 =value;
        
        [_imaArr addObject:value];
    }
    if ([key isEqualToString:@"img2Url"]) {
        
//        _img2 = value;
        [_imaArr addObject:value];

    }
    if ([key isEqualToString:@"img3Url"]) {
        
//        _img3  = value;
        [_imaArr addObject:value];


    }
    if ([key isEqualToString:@"img4Url"]) {
        
//        _img4  = value;
        [_imaArr addObject:value];

    }
    if ([key isEqualToString:@"img5Url"]) {
        
//        _img5  = value;
        [self.imaArr addObject:value];


    }
    if ([key isEqualToString:@"storeCommitUserHeadImg"]) {
        
        _handImg = [NSURL URLWithString:value];
    }
    if ([key isEqualToString:@"time"]) {
        
        _time = value;
    }
    
    if ([key isEqualToString:@"storeCommitUserName"]) {
        
        _userName = value;
    }
    
}

-(NSMutableArray *)imaArr{
    
    if (!_imaArr) {
        
        _imaArr = [NSMutableArray array];
    }
    
    
    return _imaArr;
}
@end
