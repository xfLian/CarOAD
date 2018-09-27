//
//  SearchRecruitListView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchRecruitListViewDelegate <NSObject>

- (void) searchRecruitListWithText:(NSString *)text;

@end

@interface SearchRecruitListView : UIView

@property (nonatomic, weak) id <SearchRecruitListViewDelegate> delegate;

- (void) show;
- (void) hide;

@end
