//
//  ResumeListData.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/13.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeListData : NSObject

@property (nonatomic)         CGFloat   expendStringHeight;
@property (nonatomic)         CGFloat   normalStringHeight;

@property (nonatomic, strong) NSString *CVId;
@property (nonatomic, strong) NSString *workNature;
@property (nonatomic, strong) NSString *isDefault;
@property (nonatomic, strong) NSString *integrity;
@property (nonatomic, strong) NSString *skillPost;
@property (nonatomic, strong) NSString *uodateDate;
@property (nonatomic, strong) NSString *isOpen;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (ResumeListData *) getViewModelWithData:(id)data;

@end
