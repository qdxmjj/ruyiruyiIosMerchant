//
//  JJRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJFileParam.h"
#import "JJTools.h"
#import "MBProgressHUD+YYM_category.h"
#import "UserConfig.h"
/**
 请求成功block
 */
typedef void (^requestSuccessBlock)( NSString * _Nullable code, NSString * _Nullable message, _Nullable id data);

typedef void (^GL_requestSuccessBlock)( id _Nullable rows, _Nullable id total);

typedef void (^interchangeableRequestSuccessBlock)(id _Nullable data);
/**
 请求失败block
 */
typedef void (^requestFailureBlock) (NSError * _Nullable error);

/**
 请求响应block
 */
typedef void (^responseBlock)(_Nullable id dataObj, NSError * _Nullable error);

/**
 监听进度响应block
 */
typedef void (^progressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);
/**
 下载文件的路径响应block
 */
typedef void (^destinationBlock)(NSURL * _Nonnull documentUrl);

@interface JJRequest : NSObject


/**
 GET请求
 */
+ (void)getRequest:(nonnull NSString *)url params:(NSDictionary * _Nullable)params success:(_Nullable requestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

/**
 POST请求
 */
+ (void)postRequest:(nonnull NSString *)url params:(NSDictionary *_Nullable )params success:(_Nullable requestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;

/**
 龚林后台数据格式专用接口
 */
+ (void)GL_PostRequest:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(GL_requestSuccessBlock _Nullable )successHandler failure:(requestFailureBlock _Nullable )failureHandler;

+ (void)GL_UpdateRequest:(NSString * _Nullable )url params:( NSDictionary * _Nullable )params fileConfig:( NSArray<JJFileParam*> * _Nullable )fileArray progress:(_Nullable progressBlock)progressHandler success:(_Nullable requestSuccessBlock)successHandler complete:(_Nullable responseBlock)completionHandler;

+ (void)interchangeablePostRequest:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(interchangeableRequestSuccessBlock _Nullable )successHandler failure:(requestFailureBlock _Nullable )failureHandler;


/**
 PUT请求
 */
+ (void)putRequest:(nonnull NSString *)url params:(NSDictionary *_Nullable )params success:(_Nullable  requestSuccessBlock)successHandler failure:(_Nullable  requestFailureBlock)failureHandler;

/**
 DELETE请求
 */
+ (void)deleteRequest:(nonnull NSString *)url params:(NSDictionary *_Nullable )params success:(_Nullable requestSuccessBlock)successHandler failure:(_Nullable requestFailureBlock)failureHandler;


/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(nonnull NSString *)url successAndProgress:(_Nullable progressBlock)progressHandler destination:(_Nullable destinationBlock)destinationHandler complete:(_Nullable responseBlock)completionHandler;

/**
 文件上传，监听上传进度
 */
+ (void)updateRequest:(NSString * _Nullable )url params:( NSDictionary * _Nullable )params fileConfig:( NSArray<JJFileParam*> * _Nullable )fileArray progress:(_Nullable progressBlock)progressHandler success:(_Nullable requestSuccessBlock)successHandler complete:(_Nullable responseBlock)completionHandler;

@end
