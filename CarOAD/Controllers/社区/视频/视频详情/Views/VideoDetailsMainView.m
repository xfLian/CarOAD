//
//  VideoDetailsMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "VideoDetailsMainView.h"

#import "QADetailsAnswerListCell.h"
#import "VideoDetailsCell.h"
#import "VideoDetailsView.h"

#import "VideoListData.h"
#import "DetailsCommunityViewModel.h"

@interface VideoDetailsMainView()<QADetailsAnswerListCellDelegate, VideoDetailsCellDelegate>

@property (nonatomic, strong) VideoDetailsView *detailsView;

@end

@implementation VideoDetailsMainView

- (void)buildSubview {

    [super buildSubview];

    self.detailsView = [[VideoDetailsView alloc] initWithFrame:CGRectMake(0, 0, self.width, 54 *Scale_Height)];
    [self addSubview:self.detailsView];

    self.tableView.frame = CGRectMake(0, self.detailsView.height, self.width, self.height - 50 *Scale_Height - self.detailsView.height - SafeAreaBottomHeight);

    [self.tableView registerClass:[VideoDetailsCell class] forCellReuseIdentifier:@"VideoDetailsCell"];
    [self.tableView registerClass:[QADetailsAnswerListCell class] forCellReuseIdentifier:@"QADetailsAnswerListCell"];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

    }];

    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                  refreshingAction:@selector(loadMoreData)];

    self.tableView.mj_footer = footer;

    {

        UIView *bottomBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 50 *Scale_Height - SafeAreaBottomHeight, self.width, 50 *Scale_Height + SafeAreaBottomHeight)];
        bottomBackView.backgroundColor = MainColor;
        [self addSubview:bottomBackView];

        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomBackView.width, 0.5f)];
        lineView.backgroundColor = LineColor;
        [bottomBackView addSubview:lineView];

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, bottomBackView.width, 50 *Scale_Height)
                                                buttonType:kButtonNormal
                                                     title:@"我来评论"
                                                     image:nil
                                                  higImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = MainColor;
        button.titleLabel.font = UIFont_17;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBackView addSubview:button];

    }

}

- (void) buttonEvent:(UIButton *)sender {

    [_delegate clickGotoCommentViewWithVideoId:nil];

}

- (void) loadHeaderData; {

    self.detailsView.data = self.detailsData;
    [self.detailsView loadContent];

}

- (void) hideMJ {

    [self.tableView.mj_footer endRefreshing];

}

- (void) loadNewData {

    [_delegate loadNewData];

}

- (void) loadMoreData {

    [_delegate loadMoreData];

}

- (void)loadContent {

    [self.tableView reloadData];

}

- (void) loadFirstSectionData; {

    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

}

- (void) loadSecondSectionData; {

    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        VideoListData *model = self.detailsData;

        if (model.title.length > 0) {

            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:0];
            style.lineSpacing = 4;
            NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};

            CGFloat labelHeight = [model.title heightWithStringAttribute:attribute fixedWidth:Screen_Width - 24 *Scale_Width - 10];

            return 50 *Scale_Height + labelHeight;

        } else {

            return 40 *Scale_Height;

        }

    } else {

        if (self.datasArray.count > 0) {

            DetailsCommunityViewModel *model = self.datasArray[indexPath.row];

            if (model.ansContent.length > 0) {

                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:0];
                style.lineSpacing = 4;
                NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};

                CGFloat labelHeight = [model.ansContent heightWithStringAttribute:attribute fixedWidth:Screen_Width - 64 *Scale_Width - 10];

                if (labelHeight > 60 *Scale_Height) {

                    labelHeight = 60 *Scale_Height;

                }

                if (model.reImgURL.length > 0) {

                    return 100 *Scale_Height + (self.width - 44 *Scale_Width) / 9 *2 + labelHeight;

                } else {

                    return 90 *Scale_Height + labelHeight;

                }

            } else {

                if (model.reImgURL.length > 0) {

                    return 90 *Scale_Height + (self.width - 44 *Scale_Width) / 9 *2;

                } else {

                    return 0;

                }

            }

        } else {

            return 0;

        }

    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {

        return 1;

    } else {

        return self.datasArray.count;

    }

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        VideoDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        VideoListData *model = self.detailsData;

        cell.data = model;
        [cell loadContent];

        return cell;

    } else {

        QADetailsAnswerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QADetailsAnswerListCell" forIndexPath:indexPath];
        cell.selectionStyle           = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if (self.datasArray.count > 0) {

            DetailsCommunityViewModel *model = self.datasArray[indexPath.row];

            cell.data = model;
            [cell loadContent];

        }

        return cell;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

    } else {
        
        DetailsCommunityViewModel *model = self.datasArray[indexPath.row];
        [_delegate checkAnswerDetailsWithAnswerData:model];

    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];

    headerView.backgroundColor = [UIColor whiteColor];

    if (section == 0) {

        headerView.frame = CGRectMake(0, 0, tableView.width, 0);

    } else {

        headerView.frame = CGRectMake(0, 0, tableView.width, 30 *Scale_Height);

        if (headerView.subviews) {

            for (UIView *subView in headerView.subviews) {

                [subView removeFromSuperview];

            }

        }

        VideoListData *model = self.detailsData;

        NSString *number = nil;

        if (model.commentNum.length > 0) {
            number = model.commentNum;
        } else {
            number = @"0";
        }

        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:[NSString stringWithFormat:@"全部评论(%@)",number]
                                                  font:UIFont_15
                                             textColor:MainColor
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];

        [headerView addSubview:label];
        [label sizeToFit];
        label.frame = CGRectMake((headerView.width - label.width) / 2, (headerView.height - label.height) / 2 - 0.5f, label.width, 20 *Scale_Height);

        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(12 *Scale_Width, headerView.height / 2, (headerView.width - label.width) / 2 - 22 *Scale_Width, 1.f)];
        leftLineView.backgroundColor = TextGrayColor;
        [headerView addSubview:leftLineView];

        UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake((headerView.width + label.width) / 2 + 10 *Scale_Width, headerView.height / 2 - 0.5f, leftLineView.width, 1.f)];
        rightLineView.backgroundColor = TextGrayColor;
        [headerView addSubview:rightLineView];

    }

    return headerView;

}

- (void) clickDetailsLikeButton; {

    [_delegate clickDetailsLikeButton];

}

- (void) clickDetailsListLikeButtonForData:(id)data; {

    [_delegate clickDetailsListLikeButtonForData:data];

}

@end
