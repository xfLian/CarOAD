//
//  QTHttpsManager.m
//  LinJiaMaMa
//
//  Created by qiantang on 16/12/23.
//  Copyright © 2016年 qiantang. All rights reserved.
//

#import "QTHttpsManager.h"

@interface QTHttpsManager()

@end

@implementation QTHttpsManager

+ (AFHTTPSessionManager *) creatOneWayAuthenticationHttpsManagerWithApiName:(NSString *)name; {
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    manager.responseSerializer    = [AFJSONResponseSerializer serializer];
    manager.securityPolicy        = [[QTHttpsManager class] getOneWayCustomHttpsPolicy:manager];

    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    //关闭缓存避免干扰测试r
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    return manager;

}

+ (AFSecurityPolicy *) getOneWayCustomHttpsPolicy:(AFHTTPSessionManager*)manager{

    NSString *cerPath  = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];//自签名证书
    NSData   *caCert   = [NSData dataWithContentsOfFile:cerPath];
    NSArray  *cerArray = @[caCert];
    NSSet    *set      = [NSSet setWithArray:cerArray];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates  = set;
    
    return securityPolicy;

}

+ (AFHTTPSessionManager *) creatTwoWayAuthenticationHttpsManagerWithApiName:(NSString *)name; {

    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy        = [[QTHttpsManager class] getCustomHttpsPolicy:manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    manager.responseSerializer    = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //关闭缓存避免干扰测试r
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    return manager;


}

+ (AFSecurityPolicy *) getCustomHttpsPolicy:(AFHTTPSessionManager*)manager{
    
    //https 公钥证书配置
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"der"];
    NSData   *certData     = [NSData dataWithContentsOfFile:certFilePath];
    NSSet    *certSet      = [NSSet setWithObject:certData];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    
    policy.allowInvalidCertificates = YES;
    
    policy.validatesDomainName = NO;//是否校验证书上域名与请求域名一致
    
    //https回调 客户端验证
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        
        NSLog(@"setSessionDidBecomeInvalidBlock");
        
    }];
    
    __weak typeof(manager)weakManger = manager;
    
    __weak typeof(self)weakSelf = self;
    
    //客户端请求验证 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        
        __autoreleasing NSURLCredential *credential = nil;
        
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            
            if([weakManger.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                
                if(credential) {
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                    
                } else {
                    
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                    
                }
                
            } else {
                
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                
            }
            
        } else {
            
            // client authentication
            
            SecIdentityRef identity = NULL;
            
            SecTrustRef trust = NULL;
            
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client"ofType:@"p12"];
            
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12])
                
            {
                
                NSLog(@"client.p12:not exist");
                
            }
            
            else
                
            {
                
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if ([[weakSelf class]extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                    
                {
                    
                    SecCertificateRef certificate = NULL;
                    
                    SecIdentityCopyCertificate(identity, &certificate);
                    
                    const void*certs[] = {certificate};
                    
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                    
                }
                
            }
            
        }
        
        *_credential = credential;
        
        return disposition;
        
    }];
    
    return policy;
    
}

+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"qiantang"
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        
        CFDictionaryRef  myIdentityAndTrust = CFArrayGetValueAtIndex(items,0);
        const void      *tempIdentity       = NULL;
                         tempIdentity       = CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
                        *outIdentity        = (SecIdentityRef)tempIdentity;
        const void      *tempTrust          = NULL;
                         tempTrust          = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
                        *outTrust           = (SecTrustRef)tempTrust;
        
    } else {
        
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
        
    }
    
    return YES;
    
}

@end
