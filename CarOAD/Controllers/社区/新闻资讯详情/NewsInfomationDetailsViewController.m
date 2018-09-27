//
//  NewsInfomationDetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "NewsInfomationDetailsViewController.h"

#import "DetailsCommunityViewModel.h"
#import "ArtCommunityListRootModel.h"
#import "ArtInfoRootModel.h"
#import "ArticleListData.h"

#import "QADetailsAnswerListCell.h"

#import "OADPublishCommentAnswerViewController.h"
#import "OADCommentAnswerDetailsViewController.h"

@interface NewsInfomationDetailsViewController ()<QADetailsAnswerListCellDelegate, OADShareButtonViewDelegate, UIWebViewDelegate>
{

    NSInteger PageNo;

}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView    *otherBackView;
@property (nonatomic, strong) UILabel   *answerNumberLabel;
@property (nonatomic, strong) UIButton  *button;

@property (nonatomic, strong) ArtInfoData *rootData;
@property (nonatomic, strong) OADShareButtonView              *shareView;
@property (nonatomic, strong) NSMutableDictionary             *params;
@property (nonatomic, strong) NSMutableArray                  *datasArray;

@end

@implementation NewsInfomationDetailsViewController

- (OADShareButtonView *)shareView {

    if (!_shareView) {

        _shareView          = [[OADShareButtonView alloc] init];
        _shareView.delegate = self;
    }

    return _shareView;

}

- (NSMutableArray *)datasArray {

    if (!_datasArray) {

        _datasArray = [[NSMutableArray alloc] init];
    }

    return _datasArray;

}

- (NSMutableDictionary *)params {

    if (!_params) {

        _params = [[NSMutableDictionary alloc] init];
    }

    return _params;

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shareResoult:)
                                                 name:@"WXShareResoult"
                                               object:nil];

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"WXShareResoult"
                                                  object:nil];

}

#pragma mark - 分享结果通知
- (void) shareResoult:(NSNotification *)notification {

//    self.tmpButton.enabled = YES;

    NSString *message = [notification.userInfo valueForKey:@"message"];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];

    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

    }]];

    [self presentViewController:alert animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [self requstGetDetailsData];
    
}

- (void)setNavigationController {

    self.leftItemText = @"返回";
    
    [super setNavigationController];

    UIButton *rightNavButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavButton.frame           = CGRectMake(0, 0, 44, 44);
    UIImage  *ima                 = [UIImage imageNamed:@"分享"];
    rightNavButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [rightNavButton setImage:ima forState:UIControlStateNormal];
    [rightNavButton addTarget:self
                      action:@selector(clickRightItem)
            forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)clickRightItem {

    [self.shareView show];

}

- (void) clickSureButtonWithTag:(NSInteger)tag; {

    ArticleListData *detailsTitleModel = self.detailsData;
    ArtInfoData     *detailsInfoModel  = self.rootData;
    
    //  获取分享数据
    NSString *title       = @"凯路登技师端";
    NSString *description = detailsTitleModel.title;
    UIImage  *image       = [UIImage imageNamed:@"wx_icon_hy"];
    NSString *shareUrl    = detailsInfoModel.artHtmlUrl;

    if (tag == 1000) {
        
        [QTShareMessage shareToWXSceneSessionWithTitle:title description:description image:image shareUrl:shareUrl];

    } else if (tag == 1001) {

        [QTShareMessage shareToWXSceneTimelineWithTitle:title description:description image:image shareUrl:shareUrl];

    } else if (tag == 1002) {

        [QTShareMessage shareToWXSceneFavoriteWithTitle:title description:description image:image shareUrl:shareUrl];

    }

}

- (void)buildSubView {
    
    [super buildSubView];
    
    {
        
        UIWebView *webView               = [[UIWebView alloc] initWithFrame:CGRectZero];
        webView.backgroundColor          = [UIColor whiteColor];
        webView.delegate                 = self;
        webView.scrollView.scrollEnabled = NO;//设置webview不可滚动，让tableview本身滚动即可
        webView.scrollView.bounces       = NO;
        webView.opaque                   = NO;
        self.webView = webView;
        
        [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
        self.otherBackView                 = [[UIView alloc] initWithFrame:CGRectZero];
        self.otherBackView.backgroundColor = [UIColor clearColor];
        [webView addSubview:self.otherBackView];
        
        self.answerNumberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                     labelType:kLabelNormal
                                                          text:@""
                                                          font:UIFont_14
                                                     textColor:TextGrayColor
                                                 textAlignment:NSTextAlignmentRight
                                                           tag:104];
        [self.otherBackView addSubview:self.answerNumberLabel];
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                buttonType:kButtonSize
                                                     title:nil
                                                     image:[UIImage imageNamed:@"点赞灰"]
                                                  higImage:[UIImage imageNamed:@"点赞蓝"]
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [self.otherBackView addSubview:button];
        self.button = button;
        
    }
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, self.view.width, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight - 50 *Scale_Height);
    self.tableView.frame = self.contentView.bounds;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [QADetailsAnswerListCell registerToTableView:self.tableView];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                  refreshingAction:@selector(loadMoreData)];
    
    self.tableView.mj_footer = footer;
    
    {
        
        self.bottomView.hidden = NO;
        self.bottomView.frame = CGRectMake(0, self.view.height - 50 *Scale_Height - SafeAreaBottomHeight, self.view.width, 50 *Scale_Height + SafeAreaBottomHeight);
        self.bottomView.backgroundColor = MainColor;
        
        UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bottomView.width, 0.5f)];
        lineView.backgroundColor = LineColor;
        [self.bottomView addSubview:lineView];
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, self.bottomView.width, 50 *Scale_Height)
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
        [self.bottomView addSubview:button];
        
    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        ArticleListData *tmpModel = self.detailsData;
        
        OADPublishCommentAnswerViewController *viewController = [OADPublishCommentAnswerViewController new];
        if ([tmpModel.type isEqualToString:@"文章"]) {
            
            viewController.type = @"文章";
            
        } else if ([tmpModel.type isEqualToString:@"资讯"]) {
            
            viewController.type = @"资讯";
            
        } else if ([tmpModel.type isEqualToString:@"新闻"]) {
            
            viewController.type = @"新闻";
            
        }
        viewController.navTitle = @"评论";
        viewController.qaId     = tmpModel.artId;
        viewController.content  = tmpModel.title;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else {
        
        ArtInfoData *model = self.detailsData;
        
        NSString *type = nil;
        
        if ([model.type isEqualToString:@"问答"]) {
            
            type = @"1";
            
        } else if ([model.type isEqualToString:@"视频"]) {
            
            type = @"2";
            
        } else if ([model.type isEqualToString:@"文章"]) {
            
            type = @"3";
            
        } else if ([model.type isEqualToString:@"资讯"]) {
            
            type = @"4";
            
        } else if ([model.type isEqualToString:@"新闻"]) {
            
            type = @"5";
            
        }
        
        [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:type detailsId:model.artId];
        
        [self loadLickButtonType];
        
    }
    
}

- (void) requstGetDetailsData {

    ArticleListData *model = self.detailsData;
    
    NSDictionary *params = @{@"userId" : @"",
                             @"artId"  : model.artId};
    
    [DetailsCommunityViewModel requestPost_getQTDetailsNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                
        ArtInfoRootModel *rootModel = [[ArtInfoRootModel alloc] initWithDictionary:info];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray *detailsArray = rootModel.data;
            
            NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
            
            for (ArtInfoData *data in detailsArray) {
                
                data.type = model.type;
                [tmpDataArray addObject:data];
            }
            
            self.rootData = tmpDataArray[0];
            
            if (self.rootData.artHtmlUrl.length > 0) {
                
                NSURL        *url     = [NSURL URLWithString:self.rootData.artHtmlUrl];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [self.webView loadRequest:request];
                
            }
            
            [self loadLickButtonType];
            
            [self loadNewData];
            
        });
        
    } error:^(NSString *errorMessage) {


    } failure:^(NSError *error) {

    }];

}

#pragma mark - webview代理方法
- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    webView.frame = CGRectMake(0, 0, Screen_Width, fittingSize.height + 15 *Scale_Height);
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
        self.webView.frame = CGRectMake(0, 0, Screen_Width, fittingSize.height);
        
        self.otherBackView.frame = CGRectMake(12 *Scale_Width, self.webView.height - 24 *Scale_Height, self.webView.width - 24 *Scale_Width, 24 *Scale_Height);
        
        self.button.frame = CGRectMake(self.otherBackView.width - 24 *Scale_Width, 0, 24 *Scale_Height, 24 *Scale_Height);
        
        [self.answerNumberLabel sizeToFit];
        self.answerNumberLabel.frame = CGRectMake(self.otherBackView.width - self.button.width - self.answerNumberLabel.width - 5 *Scale_Width, 4 *Scale_Height, self.answerNumberLabel.width, 20 *Scale_Height);
        
        [self.tableView beginUpdates];
        [self.tableView setTableHeaderView:self.webView];
        [self.tableView endUpdates];
        
    }
    
}

- (void) loadLickButtonType {
    
    if ([self.rootData.isLike isEqualToString:@"1"]) {
        
        self.button.selected = YES;
        
        if (self.rootData.likeNum.length > 0) {
            
            self.answerNumberLabel.text = self.rootData.likeNum;
            
        } else {
            
            self.answerNumberLabel.text = @"0";
            
        }
        
    } else {
        
        NSString *type = nil;
        
        if ([self.rootData.type isEqualToString:@"问答"]) {
            
            type = @"1";
            
        } else if ([self.rootData.type isEqualToString:@"视频"]) {
            
            type = @"2";
            
        } else if ([self.rootData.type isEqualToString:@"文章"]) {
            
            type = @"3";
            
        } else if ([self.rootData.type isEqualToString:@"资讯"]) {
            
            type = @"4";
            
        } else if ([self.rootData.type isEqualToString:@"新闻"]) {
            
            type = @"5";
            
        }
        
        if (self.rootData.artId.length > 0) {
            
            BOOL isLike = [[PreserveLikeData initPreserveLikeData] isLikeThisDetailsWithType:type detailsId:self.rootData.artId];
            
            if (isLike == YES) {
                
                self.button.selected = YES;
                
                NSInteger totalLikeNum = [self.rootData.likeNum integerValue];
                totalLikeNum ++;
                self.answerNumberLabel.text = [NSString stringWithFormat:@"%ld",totalLikeNum];
                
            } else {
                
                if (self.rootData.likeNum.length > 0) {
                    
                    self.answerNumberLabel.text = self.rootData.likeNum;
                    
                } else {
                    
                    self.answerNumberLabel.text = @"0";
                    
                }
                
            }
            
        } else {
            
            self.answerNumberLabel.text = @"0";
            
        }
        
    }
    
}

#pragma mark - QADetailsMainViewDelegate
- (void)checkAnswerDetailsWithAnswerData:(id)answerData {

    ArticleListData *tmpModel = self.detailsData;

    DetailsCommunityViewModel *model = answerData;
    if ([tmpModel.type isEqualToString:@"文章"]) {
        
        model.type = @"文章";
        
    } else if ([tmpModel.type isEqualToString:@"资讯"]) {
        
        model.type = @"资讯";
        
    } else if ([tmpModel.type isEqualToString:@"新闻"]) {
        
        model.type = @"新闻";
        
    }
    model.typeId = tmpModel.artId;

    OADCommentAnswerDetailsViewController *viewController = [OADCommentAnswerDetailsViewController new];
    viewController.answerDetailsData                      = answerData;

    [self presentViewController:viewController animated:YES completion:^{

    }];

}

/**
 *  加载新数据
 */
- (void) loadNewData {

    PageNo = 1;

    ArtInfoData *model = self.detailsData;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"" forKey:@"userId"];
    [self.params setObject:model.artId forKey:@"artId"];
    
    [self startNetworking];

}

/**
 *  发送请求加载更多的微博数据
 */
- (void) loadMoreData {

    PageNo ++;

    ArtInfoData *model = self.detailsData;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"" forKey:@"userId"];
    [self.params setObject:model.artId forKey:@"artId"];

    [self startNetworking];

}

- (void) clickDetailsListLikeButtonForData:(id)data; {

    DetailsCommunityViewModel *model = data;

    NSString *type = nil;

    if ([model.type isEqualToString:@"问答"]) {

        type = @"1";

    } else if ([model.type isEqualToString:@"视频"]) {

        type = @"2";

    } else if ([model.type isEqualToString:@"文章"]) {

        type = @"3";

    } else if ([model.type isEqualToString:@"资讯"]) {

        type = @"4";

    } else if ([model.type isEqualToString:@"新闻"]) {

        type = @"5";

    }
    
    [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:type detailsId:model.typeId communityId:model.answerId];
    [self.tableView reloadData];

}

#pragma mark -  获取服务器数据
- (void) startNetworking {

    [DetailsCommunityViewModel requestPost_getQTAnswerListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self requestSucessWithData:info];

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self requestFailedWithError:error];

    }];

}

- (void) requestSucessWithData:(id)data; {

    ArtCommunityListRootModel *rootModel = [[ArtCommunityListRootModel alloc] initWithDictionary:data];

    if ([rootModel.result integerValue] == 1) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            NSMutableArray *dataArray = [[NSMutableArray alloc] init];

            if (self.datasArray.count > 0) {

                for (DetailsCommunityViewModel *model in self.datasArray) {

                    [dataArray addObject:model];

                }

            }

            if (PageNo == 1) {

                [dataArray removeAllObjects];

            }

            if (rootModel.data.count > 0) {

                ArticleListData *model = self.detailsData;

                for (ArtCommunityListData *tmpData in rootModel.data) {

                    tmpData.type  = model.type;
                    tmpData.typeId = model.artId;

                    DetailsCommunityViewModel *model = [DetailsCommunityViewModel getQTCommunityListData:tmpData];

                    [dataArray addObject:model];

                }

            }

            self.datasArray = [dataArray mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableView reloadData];

            });

        });

    } else {

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView.mj_footer endRefreshing];

        });

    }

}

- (void) requestFailedWithError:(NSError *)error; {

    [self.tableView.mj_footer endRefreshing];
    [MBProgressHUD showMessageTitle:@"连接服务器失败！"];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                
                return 100 *Scale_Height + (self.view.width - 44 *Scale_Width) / 9 *2 + labelHeight;
                
            } else {
                
                return 90 *Scale_Height + labelHeight;
                
            }
            
        } else {
            
            if (model.reImgURL.length > 0) {
                
                return 90 *Scale_Height + (self.view.width - 44 *Scale_Width) / 9 *2;
                
            } else {
                
                return 0;
                
            }
            
        }
        
    } else {
        
        return 0;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasArray.count;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QADetailsAnswerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QADetailsAnswerListCell" forIndexPath:indexPath];
    cell.selectionStyle           = UITableViewCellSelectionStyleNone;
    cell.delegate                 = self;
    if (self.datasArray.count > 0) {
        
        DetailsCommunityViewModel *model = self.datasArray[indexPath.row];
        
        cell.data = model;
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        
    } else {
        
        DetailsCommunityViewModel *model = self.datasArray[indexPath.row];
        ArticleListData *tmpModel = self.detailsData;
        
        if ([tmpModel.type isEqualToString:@"文章"]) {
            
            model.type = @"文章";
            
        } else if ([tmpModel.type isEqualToString:@"资讯"]) {
            
            model.type = @"资讯";
            
        } else if ([tmpModel.type isEqualToString:@"新闻"]) {
            
            model.type = @"新闻";
            
        }
        model.typeId = tmpModel.artId;
        
        OADCommentAnswerDetailsViewController *viewController = [OADCommentAnswerDetailsViewController new];
        viewController.answerDetailsData                      = model;
        
        [self presentViewController:viewController animated:YES completion:^{
            
        }];
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame           = CGRectMake(0, 0, tableView.width, 30 *Scale_Height);
    
    if (headerView.subviews) {

        for (UIView *subView in headerView.subviews) {

            [subView removeFromSuperview];

        }

    }

    ArtInfoData *model = self.rootData;

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
    
    return headerView;
    
}

@end
