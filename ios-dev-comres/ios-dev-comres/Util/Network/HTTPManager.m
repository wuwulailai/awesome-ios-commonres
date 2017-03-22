//
//  HTTPManager.m
//  ios-dev-comres
//
//  Created by 吴保来 on 2017/3/21.
//  Copyright © 2017年 test. All rights reserved.
//

#import "HTTPManager.h"

#define TIMEOUT 15.0

@implementation HTTPManager
#pragma mark - Manager
/**
 *  重写
 */
+ (instancetype)manager
{
    HTTPManager *manager = [super manager];
    
    if (manager) {
        
        // responseSerializer
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain",@"application/x-javascript", nil];
        
        // requestSerializer 普通post
        manager.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
        manager.requestSerializer.timeoutInterval = TIMEOUT;
        [manager.requestSerializer setValue:@"www.kankan.com" forHTTPHeaderField:@"Referer"];
        
        //添加证书验证
        //        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    return manager;
}

//自定义验证策略
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"pad.kankan.com" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    return securityPolicy;
}

#pragma mark - Request Base
+ (void)getWithManager:(HTTPManager *)manager url:(NSString *)url parameters:(NSDictionary *)parameters
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 增加平台参数 1-android; 2-iphone; 3-android_pad; 4-ipad
    if (parameters) {
        NSMutableDictionary *tempPar = [parameters mutableCopy];
        [tempPar setObject:@2 forKey:@"platform"];
        parameters = [tempPar copy];
    }
    else {
        parameters = @{@"platform" : @2};
    }
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        if (block) {
            block(dic,error);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (block) {
            block(nil,error);
        }
    }];
}
+ (void)postWithManager:(HTTPManager *)manager url:(NSString *)url parameters:(NSDictionary *)parameters
                  block:(void (^)(NSDictionary *resDictonary, NSError *error))block
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        if (block) {
            block(dic,error);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (block) {
            block(nil,error);
        }
    }];
}

#pragma mark - Get Method

// 搜索接口需要忽略掉缓存
+ (void)getInfoIgnoringCacheWithUrl:(NSString *)url
                         parameters:(NSDictionary *)parameters
                              block:(void (^)(NSDictionary *resDictionary, NSError *error))block
{
    HTTPManager *manager = [self manager];
    
    // 忽略掉缓存
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [self getWithManager:manager url:url parameters:parameters block:block];
}
+ (void)getInfoWithUrl:(NSString *)subUrl
            parameters:(NSDictionary *)parameters
               timeOut:(NSInteger)timeOut
               cookies:(NSString *) cookies
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    HTTPManager *manager = [self manager];
    
    // 设置超时时间
    manager.requestSerializer.timeoutInterval = timeOut;
    
    // 设置cookies
    if (cookies) [manager.requestSerializer setValue:cookies forHTTPHeaderField:@"Cookie"];
    
    [self getWithManager:manager url:subUrl parameters:parameters block:block];
}


+ (void)getInfoWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
               timeOut:(NSInteger)timeOut
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    [self getInfoWithUrl:url parameters:parameters timeOut:timeOut cookies:nil block:block];
}

+ (void)getInfoWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
               cookies:(NSString *) cookies
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    [self getInfoWithUrl:url parameters:parameters timeOut:TIMEOUT cookies:cookies block:block];
}

+ (void)getInfoWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
                 block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    [self getInfoWithUrl:url parameters:parameters timeOut:TIMEOUT cookies:nil block:block];
}

#pragma mark - Post Method

/**
 *  post请求
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    [self postWithUrl:url parameters:parameters timeOut:TIMEOUT cookies:nil block:block];
}
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
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    [self postWithUrl:url parameters:parameters timeOut:timeOut cookies:nil block:block];
}

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
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    [self postWithUrl:url parameters:parameters timeOut:TIMEOUT cookies:cookies block:block];
}
/**
 *  post请求 带Referer cookies
 *
 *  @param url     url
 *  @param parameters 参数
 *  @param block      返回block
 */
+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
            timeOut:(NSInteger)timeOut
            cookies:(NSString *) cookies
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    HTTPManager *manager = [self manager];
    
    // 设置超时时间
    manager.requestSerializer.timeoutInterval = timeOut;
    
    // 设置cookies
    if (cookies) [manager.requestSerializer setValue:cookies forHTTPHeaderField:@"Cookie"];
    
    [self postWithManager:manager url:url parameters:parameters block:block];
}




+ (void)postWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameters
          httpbasic:(BOOL) ishttpbasic
              block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    
    HTTPManager *manager = [self manager];
    
    // 添加referer
    if (ishttpbasic) {
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"cxkj2016" password:@"cxkjdevice"];
    }
    
    [self postWithManager:manager url:url parameters:parameters block:block];
}


#pragma mark - Upload File
+ (void)postWithParameters:(NSDictionary *)parameters
                    subUrl:(NSString *)suburl
                imageDatas:(NSArray *)imageDatas
                     names:(NSArray *)names
                 fileNames:(NSArray *)fileNames
                     video:(NSData *)video
                    cookie:(NSString *)cookies
                     block:(void (^)(NSDictionary *resDictionary, NSError *error))block{
    
    HTTPManager *manager = [self manager];
    
    
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    // 设置cookies
    if (cookies) [manager.requestSerializer setValue:cookies forHTTPHeaderField:@"Cookie"];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager  POST:suburl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i<imageDatas.count; i++) {
            [formData appendPartWithFileData:[imageDatas objectAtIndex:i]
                                        name:[names objectAtIndex:i]
                                    fileName:[fileNames objectAtIndex:i]
                                    mimeType:@"image/jpeg"];
            
        }
        
        
        if (video) {
            [formData appendPartWithFileData:video
                                        name:@"video"
                                    fileName:[NSString stringWithFormat:@"%@.mp4",@"video"]
                                    mimeType:@"video/mp4"];
        }
        
        
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        if (block) {
            block(dic,error);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (block) {
            block(nil,error);
        }
        
    }];
    
}

#pragma mark - Delete Method
+ (void)deleteWithUrl:(NSString *)url
           parameters:(NSDictionary *)parameters
               cookie:(NSString *)cookie
                block:(void (^)(NSDictionary *, NSError *))block{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    HTTPManager *manager = [self manager];
    if (cookie) [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSError *error = nil;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        if (error) {
            if (block) block(nil, error);
        } else {
            if (block) block(jsonDic, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (block) {
            block(nil, error);
        }
    }];
}

#pragma mark - Cancel Request

+ (void)cancelRequest{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[[self  manager] operationQueue] cancelAllOperations];
    
}
@end
