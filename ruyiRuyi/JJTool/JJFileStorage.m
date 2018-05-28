//
//  JJFileStorage.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJFileStorage.h"
#import "JJMacro.h"
@interface JJFileStorage ()

@property(nonatomic,copy)NSString *filePatch;

@end
@implementation JJFileStorage

-(void)setFile:(id)data{
    
    
    if ([self getFile] && [self getFile].count>0) {
        
        [self changeFile:data];
        
        return;
    }
    BOOL ifSave = [[self SortingWithArray:data] writeToFile:self.filePatch atomically:YES];
    
    if (ifSave) {
        
        NSLog(@"存储成功");
//        YLog(@"%@",[self getFile]);
    }
}

-(NSMutableArray *)getFile{
    
    if (!self.filePatch) {
        return @[].mutableCopy;
    }
    NSMutableArray *dataDictionary = [[NSMutableArray alloc] initWithContentsOfFile:self.filePatch];
    
    return dataDictionary;
}

-(void)deleFile;{
    
    
    
}

-(void)changeFile:(NSMutableArray *)arr{
    
    
    NSMutableArray *dataArr =[self getFile];
    
    if (dataArr.count<=0) {
        return;
    }
    
    for (id dic in arr) {
        
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[obj objectForKey:@"id"]longLongValue] ==[[dic objectForKey:@"id"] longLongValue]) {
                
                [dataArr replaceObjectAtIndex:idx withObject:dic];
                *stop = YES;
            }
        }];
    }
    
    //新的数据时间不同 需要重新排序存储
    BOOL ifSave = [[self SortingWithArray:dataArr] writeToFile:self.filePatch atomically:YES];
    
    if (ifSave) {
        
        NSLog(@"修改成功");
//        YLog(@"%@",[self getFile]);
    }
    
}


-(NSArray *)SortingWithArray:(id)data{
    
    //这里类似KVO的读取属性的方法，直接从字符串读取对象属性，注意不要写错
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    //这个数组保存的是排序好的对象
    NSArray *sortingArray = [data sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSLog(@"排序：%@",sortingArray);

    return sortingArray;
}


-(NSString *)lastObjectTime{
    
    NSMutableArray *dataArr =[self getFile];

    return [dataArr.lastObject objectForKey:@"time"];
}
-(NSString *)filePatch{
    if (!_filePatch) {
        _filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"city.plist"];
    }
    return _filePatch;
}

@end
