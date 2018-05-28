//
//  JJFileStorage.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJFileStorage : NSObject


-(void)setFile:(id )data;

-(NSMutableArray *)getFile;

-(void)deleFile;

-(void)changeFile:(NSMutableArray *)arr;

-(NSString *)lastObjectTime;

@end
