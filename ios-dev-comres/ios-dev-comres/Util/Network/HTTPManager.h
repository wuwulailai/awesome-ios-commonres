//
//  HTTPManager.h
//  ios-dev-comres
//
//  Created by 吴保来 on 2017/3/21.
//  Copyright © 2017年 test. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HTTPManager : AFHTTPSessionManager

#pragma mark - get 请求
/**
 *  get请求
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)getInfoWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

/**
 *  get请求 忽略缓存
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)getInfoIgnoringCacheWithUrl:(NSString *)url
                         parameters:(NSDictionary *)parameters
                              block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

/**
 *  get请求 带超时时间
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)getInfoWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
               timeOut:(NSInteger)timeOut
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

/**
 *  get请求 带cookies
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)getInfoWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
               cookies:(NSString *) cookies
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block;
/**
 *  get请求 带超时、 cookies
 *
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)getInfoWithUrl:(NSString *)subUrl
            parameters:(NSDictionary *)parameters
               timeOut:(NSInteger)timeOut
               cookies:(NSString *) cookies
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

#pragma mark - post 请求

/**
 *  post请求
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block;
/**
 *  post请求 带超时时间
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeOut:(NSInteger)timeOut
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

/**
 *  post请求 带cookies
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
            cookies:(NSString *) cookies
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block;
/**
 *  post请求 超时 cookies
 *
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)postWithUrl:(NSString *)subUrl
         parameters:(NSDictionary *)parameters
            timeOut:(NSInteger)timeOut
            cookies:(NSString *) cookies
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

/**
 *  post上传图片或video
 *
 *  @param parameters 参数
 *  @param suburl     url
 *  @param imageDatas 图片对象数组
 *  @param names      图片名称
 *  @param video      video
 *  @param block      返回block
 */
+ (void)postWithParameters:(NSDictionary *)parameters
                    subUrl:(NSString *)suburl
                imageDatas:(NSArray *)imageDatas
                     names:(NSArray *)names
                 fileNames:(NSArray *)fileNames
                     video:(NSData *)video
                    cookie:(NSString *)cookies
                     block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

/**
 *  带有httpbasic的请求
 *
 *  @param url           url
 *  @param parameters    参数
 *  @param ishttpbasic   是否httpbasic
 *  @param block 取消
 */

+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
          httpbasic:(BOOL) ishttpbasic
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block;

#pragma mark - delete 请求
/**
 *  delete请求
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      回调block
 */
+ (void)deleteWithUrl:(NSString *)url
           parameters:(NSDictionary *)parameters
               cookie:(NSString *)cookie
                block:(void (^)(NSDictionary *resDictionary, NSError *error))block;
/**
 *  取消请求
 */
+ (void)cancelRequest;

@end
