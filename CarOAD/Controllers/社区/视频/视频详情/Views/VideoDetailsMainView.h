//
//  VideoDetailsMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityDetailsView.h"

@protocol VideoDetailsMainViewDelegate <NSObject>

- (void) loadNewData;
- (void) loadMoreData;

- (void) checkAnswerDetailsWithAnswerData:(id)answerData;

- (void) clickGotoCommentViewWithVideoId:(NSString *)videoId;

- (void) clickDetailsLikeButton;
- (void) clickDetailsListLikeButtonForData:(id)data;

@end

@interface VideoDetailsMainView : CommunityDetailsView

@property (nonatomic, weak) id <VideoDetailsMainViewDelegate> delegate;

@property (nonatomic, strong) id detailsData;

- (void) hideMJ;

- (void) loadHeaderData;

//  更新tableView第一组数据
- (void) loadFirstSectionData;

//  更新tableView第二组数据
- (void) loadSecondSectionData;

@end
