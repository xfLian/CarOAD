//
//  QTHttpTool.h
//
//  封装整个项目的GET\POST请求

#import <Foundation/Foundation.h>

@interface QTHttpTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param name    请求方法名
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void) postWithURL:(NSString *)url
                name:(NSString *)name
              params:(NSDictionary *)params
             success:(void (^)(id json))success
             failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url       请求路径
 *  @param name      请求方法名
 *  @param params    请求参数
 *  @param success   请求成功后的回调
 *  @param failure   请求失败后的回调
 */
+ (void) postWithURL:(NSString *)url
                name:(NSString *)name
              params:(id)params
       formDataArray:(id)formDataArray
             success:(void (^)(id json))success
             failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param name    请求方法名
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void) getWithURL:(NSString *)url
               name:(NSString *)name
             params:(NSDictionary *)params
            success:(void (^)(id json))success
            failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param name    请求方法名
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void) logCompletegetWithURL:(NSString *)url
                          name:(NSString *)name
                        params:(NSDictionary *)params
                       success:(void (^)(id))success
                       failure:(void (^)(NSError *))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param name    请求方法名
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void) logCompletepostWithURL:(NSString *)url
                           name:(NSString *)name
                         params:(NSDictionary *)params
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param name    请求方法名
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void) postWithURL:(NSString *)url
                name:(NSString *)name
          paramsDict:(NSDictionary *)params
             success:(void (^)(id))success
             failure:(void (^)(NSError *))failure;

/**
 *  发送一个GET请求
 *
 *  @param url             请求路径
 *  @param name            请求方法名
 *  @param params          请求参数
 *  @param viewController  请求控制器
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
+ (void) lxfGetWithURL:(NSString *)url
                  name:(NSString *)name
                params:(NSDictionary *)params
        viewController:(id)viewController
               success:(void (^)(id data))success
               failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url             请求路径
 *  @param name            请求方法名
 *  @param params          请求参数
 *  @param viewController  请求控制器
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
+ (void) lxfPostWithURL:(NSString *)url
                   name:(NSString *)name
                 params:(NSDictionary *)params
         viewController:(id)viewController
                success:(void (^)(id data))success
                failure:(void (^)(NSError *error))failure;

@end


/**
 *  用来封装文件数据的模型
 */
@interface QTFormData : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
