//
//  QADetailsMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityDetailsView.h"

@protocol QADetailsMainViewDelegate <NSObject>

- (void) loadNewData;
- (void) loadMoreData;

- (void) checkAnswerDetailsWithAnswerData:(id)answerData;

- (void) clickGotoCommentViewWithQAId:(NSString *)qaId;

- (void) clickDetailsLikeButton;
- (void) clickDetailsListLikeButtonForData:(id)data;
- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;

@end

@interface QADetailsMainView : CommunityDetailsView

@property (nonatomic, weak) id <QADetailsMainViewDelegate> delegate;

@property (nonatomic, strong) id detailsData;

- (void) hideMJ;

- (void) uploadNewData;

//  更新tableView第一组数据
- (void) loadFirstSectionData;

//  更新tableView第二组数据
- (void) loadSecondSectionData;

@end
