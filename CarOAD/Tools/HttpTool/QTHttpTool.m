//
//  QTHttpTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "QTHttpTool.h"
#import "AppDelegate.h"
#import "QTHttpsManager.h"

@implementation QTHttpTool

//  注册登录时调用不需要在header里面添加token和userid
+ (void)postWithURL:(NSString *)url name:(NSString *)name params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure; {
    
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            //NSInteger code = (long)[[responseObject objectForKey:@"code"] integerValue];

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
            [MBProgressHUD hideHUD];
        }
        
    }];
}
+ (void)postWithURL:(NSString *)url name:(NSString *)name paramsDict:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    // 2.发送请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];
        }
        
    }];
}

//  上传文件时调用
+ (void) postWithURL:(NSString *)url name:(NSString *)name params:(id )params formDataArray:(id)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i = 0; i< [formDataArray count]; i++) {
        
        QTFormData *formData = [[QTFormData alloc] init];
        
        //  压缩图片
        formData.data = UIImageJPEGRepresentation(formDataArray[i],0.5);
        
        if ([formDataArray count] == 1) {
            
            formData.name = @"file";
        } else {
            
            formData.name = [NSString stringWithFormat:@"file%d",i];
        }
        formData.filename = [NSString stringWithFormat:@"image%d",i];
        formData.mimeType = @"image/jpg";
        [dataArray addObject:formData];
    }
    
    // 2.发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        
        for (QTFormData *formData in dataArray) {
            
            [totalFormData appendPartWithFileData:formData.data
                                             name:formData.name
                                         fileName:formData.filename
                                         mimeType:formData.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) {
            
            failure(error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];
        }
        
    }];
    
}

//  这个用于请求手机验证码
+ (void) getWithURL:(NSString *)url name:(NSString *)name params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    // 2.发送请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];
        }
        
    }];
}

//  需要token和userid的请求
+ (void) logCompletegetWithURL:(NSString *)url name:(NSString *)name params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    // 2.发送请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];
        }
        
    }];
}

//  获取当前所在的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                appDelegate.window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[appDelegate.window subviews] objectAtIndex:0];
    id nextResponder  = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        result = nextResponder;
    else
        result = appDelegate.window.rootViewController;
    
    return result;
    
}

+ (void) logCompletepostWithURL:(NSString *)url name:(NSString *)name params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    // 2.发送请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];

        }
        
    }];
    
}

+ (void) lxfGetWithURL:(NSString *)url name:(NSString *)name params:(NSDictionary *)params viewController:(id)viewController success:(void (^)(id data))success failure:(void (^)(NSError *error))failure; {
    
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf   = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    // 2.发送请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            

            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            CarOadLog(@"%@",error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];
            
        }
        
    }];
    
}

+ (void)lxfPostWithURL:(NSString *)url name:(NSString *)name params:(NSDictionary *)params viewController:(id)viewController success:(void (^)(id data))success failure:(void (^)(NSError *error))failure; {
    
    // 1.创建请求管理对象
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManagerWithApiName:name];
    
    // 2.发送请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"请求超时，请稍后重试"];
            
        }
        
    }];
    
}

//  获取已经验证过证书的manager
+ (AFHTTPSessionManager *) getAuthenticationHttpsManagerWithApiName:(NSString *)name {
    
    //  单向验证
    AFHTTPSessionManager *manager = [QTHttpsManager creatOneWayAuthenticationHttpsManagerWithApiName:name];
    
    //  双向验证,使用p12证书
//    AFHTTPSessionManager *manager = [QTHttpsManager creatTwoWayAuthenticationHttpsManagerWithApiName:name];
    
    return manager;

}

@end

/**
 *  用来封装文件数据的模型
 */
@implementation QTFormData

@end
