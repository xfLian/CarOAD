//
//  ArticleHtmlFile.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/24.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ArticleHtmlFile.h"

@implementation ArticleHtmlFile

static ArticleHtmlFile *_articleHtmlFile;

+ (instancetype) allocWithZone:(struct _NSZone *)zone {

    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{

        _articleHtmlFile = [super allocWithZone:zone];

    });

    return _articleHtmlFile;
}

+ (instancetype) sharedArticleHtmlFile {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        _articleHtmlFile = [[self alloc] init];

    });

    return _articleHtmlFile;
}

- (id) copyWithZone:(NSZone *)zone {
    
    return _articleHtmlFile;

}

- (NSString *) createrHtmlFile {

    return nil;

}

- (NSString *) readingHtmlFile {

    NSString *filePath   = [[NSBundle mainBundle] pathForResource:@"richTextEditor" ofType:@"html"];
    NSData   *htmlData   = [NSData dataWithContentsOfFile:filePath];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];

    return htmlString;

}

@end
