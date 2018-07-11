//
//  StoresCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "StoresCell.h"
#import "JJMacro.h"
#import "JJTools.h"
#import "YMDatePickerView.h"
#import "YMStoreTypePickerView.h"
#import "YMCityPickerView.h"
#import "EnrollmentRequestData.h"

#import "JJFileStorage.h"
@interface StoresCell()


@property(nonatomic,strong)JJFileStorage *fileStorage;
@property(nonatomic,strong)NSArray *typeArr;

@end

@implementation StoresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    
    if (self) {
    JJWeakSelf
        
        [EnrollmentRequestData getStoreTypeWithSuccrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    
            if ([data valueForKeyPath:@"name"]) {
                
                weakSelf.typeArr = (NSArray *)data;
            }
            
        } failure:^(NSError * _Nullable error) {
        
        }];
        
        NSDictionary *dic;

        if (self.fileStorage.getFile.count<=0) {
            
            dic = @{@"time":@"2000-00-00 00:00:00"};
            
        }else{
            
            dic = @{@"time":[JJTools getTimestampFromTime:self.fileStorage.lastObjectTime formatter:@"yyyy-MM-dd HH:mm:ss"]};
        }
        
        [EnrollmentRequestData getCityListWithJson:[JJTools convertToJsonData:dic] succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
            if ([data isEqualToArray:@[]]) {
                
                return ;
            }
            [weakSelf.fileStorage setFile:data];

            
        } failure:^(NSError * _Nullable error) {
        
        }];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectTime:(UIButton *)sender {
    
    JJWeakSelf
    YMDatePickerView *dateView = [[YMDatePickerView alloc] init];
    
    dateView.selectTime = ^(NSString *starTime, NSString *stopTime) {
      
        
        [weakSelf.storeTime setTitle:[NSString stringWithFormat:@"%@至%@",starTime,stopTime] forState:UIControlStateNormal];
    };
    [dateView show];
    
}


- (IBAction)storeType:(UIButton *)sender {
    
    JJWeakSelf
    YMStoreTypePickerView *store = [[YMStoreTypePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    store.storeType = ^(NSString *storeType,NSString *typeID) {
        
        [weakSelf.storeType setTitle:[NSString stringWithFormat:@"%@",storeType] forState:UIControlStateNormal];

        weakSelf.storeTypeID = typeID;
    };
    
    if (weakSelf.typeArr.count>0) {
        store.typeArr = weakSelf.typeArr;
        
    }else{store.typeArr  = @[@{@"name":@"未获取到数据!"}];};
    [store show];
}


- (IBAction)selectCity:(id)sender{
    
    JJWeakSelf
    YMCityPickerView *city = [[YMCityPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    city.cityBlcok = ^(NSString *province, NSString *city, NSString *area, NSString *cityID, NSString *areaID) {
      
        [weakSelf.storeCity setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
        
        weakSelf.cityID = cityID;
        weakSelf.areaID = areaID;
    };
    
    if (weakSelf.fileStorage.getFile.count>0) {
        city.cityArr = weakSelf.fileStorage.getFile;
        
    }else{city.cityArr  = @[@"未获取到数据!"];}
    [city show];
}

-(NSArray *)typeArr{
    
    if (!_typeArr) {
        
        _typeArr = [NSArray array];
    }
    return _typeArr;
}

-(JJFileStorage *)fileStorage{
    
    if (!_fileStorage) {
        
        _fileStorage = [[JJFileStorage alloc] init];
    }
    return _fileStorage;
}
@end
