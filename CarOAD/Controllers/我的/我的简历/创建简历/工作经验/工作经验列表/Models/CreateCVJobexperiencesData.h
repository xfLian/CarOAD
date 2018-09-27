//
//  CreateCVJobexperiencesData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

/**
 *  工作经历数据解析
 */
#import <Foundation/Foundation.h>

@interface CreateCVJobexperiencesData : NSObject

@property (nonatomic)         CGFloat   expendStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;
@property (nonatomic)         CGFloat   noDataStringHeight;

@property (nonatomic, strong) NSString *CVId;
@property (nonatomic, strong) NSString *workExpId;
@property (nonatomic, strong) NSString *entryDate;
@property (nonatomic, strong) NSString *quitDate;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *skillPostExp;
@property (nonatomic, strong) NSString *workContent;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
