//
//  JJFileParam.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJFileParam : NSObject

//图片文件 二进制数据
@property (nonatomic,strong) NSData *fileData;
//服务器对应的参数名
@property (nonatomic,copy) NSString *name;
//文件的名称（上传到服务器后，服务器保存的文件名）
@property (nonatomic,copy) NSString *fileName;
//文件的类型（image/png,image/jpg等）
@property (nonatomic,copy) NSString *mimeType;
//文件大小
@property (nonatomic,copy) NSString *fileSize;



/**
 *  JCUploadParam
 *
 *  @param fileData 图片文件 二进制数据
 *  @param name     服务器对应的参数名
 *  @param fileName 文件的名称（上传到服务器后，服务器保存的文件名）
 *  @param mimeType 文件的类型（image/png,image/jpg等）
 *
 *  @return JCUploadParam
 */
+ (instancetype)fileConfigWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

- (instancetype)initWithfileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
