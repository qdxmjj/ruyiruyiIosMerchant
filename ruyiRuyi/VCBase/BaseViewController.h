//
//  BaseViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJMacro.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "JJTools.h"
#import "JJRequest.h"
#import "MBProgressHUD+YYM_category.h"
#import "MD5Encrypt.h"
#import "UserConfig.h"

#import <UIImageView+WebCache.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ItemPosition){
    itemLeft = 0,
    itemRight = 1,
};
@interface BaseViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *dataArray;       //数据源
@property(nonatomic,assign)NSInteger    currentPage;        //加载数据分页计数

@property (nonatomic, strong) UITableView *baseTableView;

/**
 * 添加上下拉刷新部件
 */
- (void)addRefreshParts;
/**
 * 添加上拉下拉刷新
 */
-(void)addRefreshFooter:(BOOL)beginRefresh;
-(void)addRefreshHeader:(BOOL)beginRefresh;
/**
 * 上拉刷新
 */
- (void)loadNewData;
/**
 * 下拉加载更多
 */
- (void)loadMoreData;

/**
 * 加载数据
 */
- (void)getDataList;


- (void)backButtonAction;

- (void)setNavigationItem:(NSString *)title imageName:(NSString *)name position:(ItemPosition)position addTarget:(nullable id)target action:(SEL)action ;

- (void)setNavigationItemWithView:(UIView *)view position:(ItemPosition)position;
@end
NS_ASSUME_NONNULL_END
