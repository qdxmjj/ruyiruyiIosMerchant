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
   
    if ([key isEqualToString:@"storeCommitUserHeadImg"]) {
        
        
        self.handImg = [NSURL URLWithString:value];
    }
    if ([key isEqualToString:@"time"]) {
        
        
        _time = value;

    }
    
    if ([key isEqualToString:@"storeCommitUserName"]) {
        
        _userName = value;
    }
    
}

- (BOOL)isUrlString:(NSString *)urlStr{
    
    NSString *emailRegex = @"[a-zA-z]+://.*";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:urlStr];
    
}

-(NSMutableArray *)imaArr{
    
    if (!_imaArr) {
        _imaArr = [NSMutableArray array];
        
        if ([self isUrlString:self.img1Url]) {
            [_imaArr addObject:self.img1Url];
        }
        if ([self isUrlString:self.img2Url]) {
            [_imaArr addObject:self.img2Url];
        }
        if ([self isUrlString:self.img3Url]) {
            [_imaArr addObject:self.img3Url];
        }
        if ([self isUrlString:self.img4Url]) {
            [_imaArr addObject:self.img4Url];
        }
        if ([self isUrlString:self.img5Url]) {
            [_imaArr addObject:self.img5Url];
        }
    }
    return _imaArr;
}
@end
