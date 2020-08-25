//
//  YMRequest.m
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "YMRequest.h"
#import "LoginViewController.h"
@implementation YMRequest

+ (instancetype)sharedManager {
    static YMRequest *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
        
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        securityPolicy.validatesDomainName = NO;
//        securityPolicy.allowInvalidCertificates = YES;
//        manager.securityPolicy = securityPolicy;
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        //http请求格式
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 30;
        
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
                [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        ///json解析格式
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    }
    return self;
}


- (void)getRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(ymRequestSuccessBlock)successHandler
           failure:(requestFailureBlock)failureHandler
{
    
    NSMutableDictionary *paramsM = [NSMutableDictionary dictionary];
    
    [paramsM addEntriesFromDictionary:params];

    
    NSLog(@"GET请求参数：%@",paramsM);
    
    [self GET:[NSString stringWithFormat:@"%@%@",YMBaseUrl,url] parameters:paramsM progress: nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSLog(@"get请求原始数据：%@",responseObject);

        NSArray *allKeys = [responseObject allKeys];
        
        NSInteger code = [allKeys containsObject:@"status"] ? [[responseObject objectForKey:@"status"] integerValue] : 999;
        NSString *message = [allKeys containsObject:@"msg"] ? [responseObject objectForKey:@"msg"] : @"";
        id data = [allKeys containsObject:@"data"] ? [responseObject objectForKey:@"data"] : @{};
        
         [self requestSuccesErrorCode:code message:message];
        successHandler(code,message,data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        [self requestErrorCode:error.code];
        failureHandler(error);
    }];
    
}

- (void)postRequest:(NSString *)url
             params:(NSDictionary *)params
            success:(ymRequestSuccessBlock)successHandler
            failure:(requestFailureBlock)failureHandler
{
    NSMutableDictionary *paramsM = [NSMutableDictionary dictionary];
    
    [paramsM addEntriesFromDictionary:params];

    
    NSLog(@"POST请求参数：%@",paramsM);
    
    [self POST:[NSString stringWithFormat:@"%@%@",YMBaseUrl,url] parameters:paramsM progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSLog(@"post请求原始数据：%@",responseObject);
        NSArray *allKeys = [responseObject allKeys];
        
        NSInteger code = [allKeys containsObject:@"status"] ? [[responseObject objectForKey:@"status"] integerValue] : 999;
        NSString *message = [allKeys containsObject:@"msg"] ? [responseObject objectForKey:@"msg"] : @"";
        id data = [allKeys containsObject:@"data"] ? [responseObject objectForKey:@"data"] : @{};
        [self requestSuccesErrorCode:code message:message];
        successHandler(code,message,data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        [self requestErrorCode:error.code];
        failureHandler(error);
    }];
}

//- (void)postFormRequest:(NSString *)url
//                 params:(NSDictionary *)params
//                success:(requestFormSuccessBlock)successHandler
//                failure:(requestFailureBlock)failureHandler
//{
//    NSMutableDictionary *paramsM = [NSMutableDictionary dictionary];
//
//
//    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:paramsM progress:nil
//       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//        YMLog(@"post请求原始数据：%@",responseObject);
//
//        NSArray *allKeys = [responseObject allKeys];
//
//        NSInteger code = [allKeys containsObject:@"code"] ? [[responseObject objectForKey:@"code"] integerValue] : 999;
//        NSString *message = [allKeys containsObject:@"msg"] ? [responseObject objectForKey:@"msg"] : @"";
//        NSInteger total = [allKeys containsObject:@"total"] ? [[responseObject objectForKey:@"total"] integerValue] : 1;
//        id data = [allKeys containsObject:@"rows"] ? [responseObject objectForKey:@"rows"] : @{};
//
//        if ([self requestSuccesErrorCode:code message:message]) {
//            successHandler(code,message,total,data);
//        }else{
//            YMLog(@"服务器错误：%@",responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        YMLog(@"------请求失败-------%@",error);
//        [self requestErrorCode:error.code];
//        failureHandler(error);
//    }];
//}
//
//- (void)putRequest:(NSString *)url
//            params:(NSDictionary *)params
//           success:(requestSuccessBlock)successHandler
//           failure:(requestFailureBlock)failureHandler
//{
//    [self PUT:url parameters:params
//      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
//        NSString *message = [responseObject objectForKey:@"msg"];
//        id data = [responseObject objectForKey:@"data"];
//        if ([self requestSuccesErrorCode:code message:@""]) {
//            successHandler(code,message,data);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        YMLog(@"------请求失败-------%@",error);
//        failureHandler(error);
//        [self requestErrorCode:error.code];
//    }];
//}
//
//- (void)deleteRequest:(NSString *)url
//               params:(NSDictionary *)params
//              success:(requestSuccessBlock)successHandler
//              failure:(requestFailureBlock)failureHandler
//{
//    [self DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
//        NSString *message = [responseObject objectForKey:@"msg"];
//        id data = [responseObject objectForKey:@"data"];
//        if ([self requestSuccesErrorCode:code message:@""]) {
//            successHandler(code,message,data);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        YMLog(@"------请求失败-------%@",error);
//        failureHandler(error);
//        [self requestErrorCode:error.code];
//    }];
//}
//
//
///**
// 下载文件，监听下载进度
// */
//- (void)downloadRequest:(NSString *)url
//           fileSavePath:(nonnull NSString *)path
//     successAndProgress:(progressBlock)progressHandler
//            destination:(ymDestinationBlock _Nullable)destinationHandler
//               complete:(responseBlock _Nullable)completionHandler
//{
//
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    __block  NSProgress *kProgress = nil;
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        kProgress = downloadProgress;
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//        NSURL *documentUrl = [[NSURL alloc] initFileURLWithPath:path];
//        destinationHandler(path);
//        return documentUrl;
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error){
//        if (error) {
//            YMLog(@"------下载失败-------%@",error);
//            [self requestErrorCode:error.code];
//        }
//        completionHandler(response, error);
//    }];
//
//    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
//
//        progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//
//    }];
//    [downloadTask resume];
//}
///**
// 下载文件，不带path
// */
//- (void)downloadRequest:(NSString *)url
//     successAndProgress:(progressBlock)progressHandler
//            destination:(ymDestinationBlock _Nullable)destinationHandler
//               complete:(responseBlock _Nullable)completionHandler
//{
//
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    __block  NSProgress *kProgress = nil;
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        kProgress = downloadProgress;
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//        NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//
//        NSString *cachePath = [cacPath objectAtIndex:0];
//
//        cachePath = [NSString stringWithFormat:@"%@/%@",cachePath,[response suggestedFilename]];
//
//        ///字符串路径转url会自动追加file://协议头
//        NSURL *documentUrl = [[NSURL alloc] initFileURLWithPath:cachePath];
//
//        destinationHandler(cachePath);
//        return documentUrl;
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error){
//        if (error) {
//            YMLog(@"------下载失败-------%@",error);
//            [self requestErrorCode:error.code];
//        }
//        completionHandler(response, error);
//    }];
//
//    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
//
//        progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//
//    }];
//    [downloadTask resume];
//}
///**
// *
// *   上传文件，监听上传进度
// */
//- (void)updateRequest:(NSString *)url
//               params:(NSDictionary *)params
//           fileConfig:(NSArray<YMFileParam*> *)fileArray
//             progress:(progressBlock)progressHandler
//              success:(requestSuccessBlock)successHandler
//             complete:(responseBlock)completionHandler
//{
//
//    //上传图片延长 上传时间
//    self.requestSerializer.timeoutInterval = 40;
//
//    NSMutableDictionary *paramsM = [NSMutableDictionary dictionary];
//
//    [paramsM addEntriesFromDictionary:params];
//    [paramsM setValue:[UserConfig uid] forKey:@"uid"];
//    [paramsM setValue:[UserConfig time] forKey:@"time"];
//    [paramsM setValue:[UserConfig key] forKey:@"key"];
//
//    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:paramsM constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
//
//        if (fileArray.count>0 && fileArray != NULL) {
//            for (YMFileParam *upload in fileArray) {
//                [formData appendPartWithFileData:upload.fileData name:upload.name fileName:upload.fileName mimeType:upload.mimeType];
//            }
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress){
//        progressHandler(0,0,0);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
//        NSString *message = [responseObject objectForKey:@"msg"];
//        id data = responseObject;
//        [self requestSuccesErrorCode:code message:@""];
//
//        successHandler(code,message,data);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        [self requestErrorCode:error.code];
//        completionHandler(task,error);
//    }];
//}


/// 网络请求错误
/// @param errorCode 错误代码
- (void)requestErrorCode:(NSUInteger )errorCode{
    
    switch (errorCode) {
        case -1001:
            [MBProgressHUD showError:@"网络请求超时！" integer:errorCode];
            break;
        case -1004:
            [MBProgressHUD showError:@"无法连接服务器！" integer:errorCode];
            break;
        case -1009:
            [MBProgressHUD showError:@"无网络连接，请检查网络！" integer:errorCode];
            break;
        default:
            [MBProgressHUD showError:@"请求失败！" integer:errorCode];
            break;
    }
}

///服务器错误
- (BOOL)requestSuccesErrorCode:(NSInteger )errorCode message:(NSString *)msg{
    switch (errorCode) {
        case 1:
            return YES;
            break;
        case 200:
            return YES;
            break;
        case 301:
            return YES;
            break;
        case 201:
            [MBProgressHUD showError:@"服务器错误！" integer:errorCode];
            return NO;
            break;
        case 401:{
            [MBProgressHUD showTextMessage:msg];
        }
            return NO;
            break;
        case 403:
            [MBProgressHUD showError:@"服务器拒绝访问！" integer:errorCode];
            return NO;
            break;
        case 404:
            [MBProgressHUD showError:@"服务器请求失败！" integer:errorCode];
            return NO;
            break;
        default:
            [MBProgressHUD showTextMessage:msg];
            return NO;
            break;
    }
}
@end
