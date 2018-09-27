//
//  ArticleHtmlFile.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleHtmlFile : NSObject

//  创建单例
+ (instancetype)sharedArticleHtmlFile;

- (NSString *) readingHtmlFile;

@end
