//
//  HttpsManager.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HttpsManager.h"

@implementation HttpsManager

+ (AFHTTPSessionManager *) creatOneWayAuthenticationHttpsManager; {
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    manager.responseSerializer    = [AFJSONResponseSerializer serializer];
    //manager.securityPolicy        = [[HttpsManager class] getOneWayCustomHttpsPolicy:manager];
    
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    //关闭缓存避免干扰测试
    //manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    return manager;
    
}

+ (AFSecurityPolicy *) getOneWayCustomHttpsPolicy:(AFHTTPSessionManager*)manager{
    
    NSString *cerPath  = [[NSBundle mainBundle] pathForResource:@"*.juhe.cn" ofType:@"cer"];
    NSData   *caCert   = [NSData dataWithContentsOfFile:cerPath];
    NSArray  *cerArray = @[caCert];
    NSSet    *set      = [NSSet setWithArray:cerArray];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName      = NO;
    securityPolicy.pinnedCertificates       = set;
    
    return securityPolicy;
    
}

+ (AFHTTPSessionManager *) creatTwoWayAuthenticationHttpsManager; {
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy        = [[HttpsManager class] getCustomHttpsPolicy:manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    manager.responseSerializer    = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //关闭缓存避免干扰测试
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
        
//        MYLog(@"setSessionDidBecomeInvalidBlock");
        
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
