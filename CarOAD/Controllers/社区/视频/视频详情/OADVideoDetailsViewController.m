//
//  OADVideoDetailsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADVideoDetailsViewController.h"

#import "OADPublishCommentAnswerViewController.h"
#import "OADCommentAnswerDetailsViewController.h"

#import "DetailsCommunityViewModel.h"
#import "CommunityMainViewModel.h"
#import "ArtCommunityListRootModel.h"

#import "VideoDetailsMainView.h"
#import "VideoListData.h"

@interface OADVideoDetailsViewController ()<VideoDetailsMainViewDelegate, AliyunVodPlayerViewDelegate>
{

    NSInteger  PageNo;
    CGFloat    view_width;
    CGFloat    view_height;
    AliyunVodPlayerEvent tmp_event;
    NSString  *tmp_videoAuth;
    
}
@property (nonatomic, strong) NSMutableDictionary  *params;
@property (nonatomic, strong) VideoDetailsMainView *subView;
@property (nonatomic, strong) NSMutableArray       *datasArray;
@property (nonatomic, strong) AliyunVodPlayerView  *aliPlayerView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OADVideoDetailsViewController

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willChangeStatusBar:)
                                                 name:UIApplicationWillChangeStatusBarOrientationNotification
                                               object:nil];
    
    [self startPlayVideo];
    [self createTimer];
    
    [self loadNewData];
    
}

-(void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillChangeStatusBarOrientationNotification
                                                  object:nil];
    self.navigationController.navigationBarHidden = NO;

    [self.aliPlayerView pause];
    
    [self.timer invalidate];
    self.timer = nil;

}

- (void) willChangeStatusBar:(NSNotification *)notification {

    if ([notification.userInfo[UIApplicationStatusBarOrientationUserInfoKey] intValue] == 1) {

        self.subView.hidden = NO;

    } else if ([notification.userInfo[UIApplicationStatusBarOrientationUserInfoKey] intValue] == 3) {

        self.subView.hidden = YES;

    }

}

- (void)viewDidLoad {
    [super viewDidLoad];

    view_width  = Screen_Width;
    view_height = Screen_Height;

    [MBProgressHUD showMessage:nil toView:self.view];
    
}

- (void)setNavigationController {

    self.navTitle = @"视频详情";

    self.leftItemText = @"返回";

    [super setNavigationController];

}

- (void)buildSubView {

    VideoListData *tmpModel = self.detailsData;

    self.aliPlayerView = [[AliyunVodPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width *9 / 16) andSkin:AliyunVodPlayerViewSkinBlue];
    [self.aliPlayerView setDelegate:self];
    [self.view addSubview:self.aliPlayerView];
    [self.aliPlayerView setAutoPlay:YES];
    self.aliPlayerView.coverUrl     = [NSURL URLWithString:tmpModel.createrImg];
    [self.aliPlayerView setTitle:tmpModel.title];
    self.aliPlayerView.isLockScreen = NO;
    
    VideoDetailsMainView *subView = [[VideoDetailsMainView alloc] initWithFrame:CGRectMake(0, self.aliPlayerView.y + self.aliPlayerView.height, self.view.width, self.view.height - (self.aliPlayerView.y + self.aliPlayerView.height))];
    subView.detailsData        = self.detailsData;
    subView.delegate           = self;
    [self.view addSubview:subView];
    self.subView = subView;
    [self.subView loadHeaderData];
    [self.subView loadFirstSectionData];
    
}

#pragma mark - QADetailsMainViewDelegate
- (void)checkAnswerDetailsWithAnswerData:(id)answerData {

    VideoListData *tmpModel = self.detailsData;

    DetailsCommunityViewModel *model = answerData;
    model.type                       = @"视频";
    model.typeId                     = tmpModel.videoId;

    OADCommentAnswerDetailsViewController *viewController = [OADCommentAnswerDetailsViewController new];
    viewController.answerDetailsData                      = answerData;
    [self presentViewController:viewController animated:YES completion:^{
        
    }];

}

- (void) clickGotoCommentViewWithVideoId:(NSString *)videoId; {

    VideoListData *model = self.detailsData;

    OADPublishCommentAnswerViewController *viewController = [OADPublishCommentAnswerViewController new];
    viewController.type     = @"视频";
    viewController.navTitle = @"评论";
    viewController.qaId     = model.videoId;
    viewController.content  = model.title;
    [self.navigationController pushViewController:viewController animated:YES];

}

/**
 *  加载新数据
 */
- (void) loadNewData {

    PageNo = 1;

    VideoListData *model = self.detailsData;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"" forKey:@"userId"];
    [self.params setObject:model.videoId forKey:@"artId"];

    [self startNetworking];

}

/**
 *  发送请求加载更多的数据
 */
- (void) loadMoreData {

    PageNo ++;

    VideoListData *model = self.detailsData;

    [self.params setObject:[NSString stringWithFormat:@"%ld",PageNo] forKey:@"pageNo"];
    [self.params setObject:@"15" forKey:@"pageStep"];
    [self.params setObject:@"" forKey:@"userId"];
    [self.params setObject:model.videoId forKey:@"artId"];

    [self startNetworking];

}

- (void) clickDetailsLikeButton; {

    VideoListData *model = self.detailsData;
    [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:@"2" detailsId:model.videoId];

    [self.subView loadFirstSectionData];

}

- (void) clickDetailsListLikeButtonForData:(id)data; {

    DetailsCommunityViewModel *model = data;

    [[PreserveLikeData initPreserveLikeData] addDetailsLikeWithType:@"2" detailsId:model.typeId communityId:model.answerId];

    [self.subView loadContent];

}

#pragma mark -  获取服务器数据
- (void) startNetworking {

    [DetailsCommunityViewModel requestPost_getQTAnswerListNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self requestSucessWithData:info];

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.subView hideMJ];

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
                
                VideoListData *model = self.detailsData;
                
                for (ArtCommunityListData *tmpData in rootModel.data) {

                    tmpData.type   = @"视频";
                    tmpData.typeId = model.videoId;

                    DetailsCommunityViewModel *model = [DetailsCommunityViewModel getQTCommunityListData:tmpData];

                    [dataArray addObject:model];

                }

            }

            self.datasArray = [dataArray mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{

                self.subView.datasArray = self.datasArray;
                [self.subView hideMJ];
                [self.subView loadSecondSectionData];

            });

        });

    } else {

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.subView hideMJ];

        });

    }

}

- (void) requestFailedWithError:(NSError *)error; {

    [self.subView hideMJ];
    [MBProgressHUD showMessageTitle:@"连接服务器失败！"];

}

#pragma mark - TimerEvent
- (void)createTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerEvent {
    
    CarOadLog(@"self.aliPlayerView.playerViewState --- %d",self.aliPlayerView.playerViewState);
    
    if (![tmp_videoAuth isKindOfClass:[NSNull class]]) {
        
        if (tmp_videoAuth.length > 0) {
            
            if (self.aliPlayerView.playerViewState == AliyunVodPlayerStateIdle) {
                
                VideoListData *model = self.detailsData;
                [self.aliPlayerView playViewPrepareWithVid:model.videoAuth playAuth:tmp_videoAuth];
                
                [self.timer invalidate];
                self.timer = nil;
                
            } else if (self.aliPlayerView.playerViewState == AliyunVodPlayerStatePause) {
                
                [self.aliPlayerView resume];
                
                [self.timer invalidate];
                self.timer = nil;
                
            } else if (self.aliPlayerView.playerViewState == AliyunVodPlayerStatePrepared) {
                
                [self.aliPlayerView start];
                
                [self.timer invalidate];
                self.timer = nil;
                
            }
            
        }
        
    }
    
}

- (void)startPlayVideo {
    
    VideoListData *model = self.detailsData;
    
    NSDictionary *params = @{@"videoId" : model.videoAuth};
    
    [CommunityMainViewModel requestPost_getVideoPlayAuthNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        NSString *videoAuth = [info valueForKey:@"VideoAuth"];
        tmp_videoAuth = videoAuth;
        
    } error:^(NSString *errorMessage) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark - 阿里视频播放器代理
- (void)onBackViewClickWithAliyunVodPlayerView:(AliyunVodPlayerView*)playerView; {

    if (self.aliPlayerView != nil) {
        
        [self.aliPlayerView stop];
        [self.aliPlayerView releasePlayer];
        [self.aliPlayerView removeFromSuperview];
        self.aliPlayerView = nil;
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
/**
 * 功能：暂停事件
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onPause:(NSTimeInterval)currentPlayTime; {
    
    
    
}
/**
 * 功能：继续事件
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onResume:(NSTimeInterval)currentPlayTime; {
    
    
    
}
/**
 * 功能：播放完成事件 ，请区别stop（停止播放）
 */
- (void)onFinishWithAliyunVodPlayerView:(AliyunVodPlayerView*)playerView; {
    
    
    
}
/**
 * 功能：停止播放
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onStop:(NSTimeInterval)currentPlayTime; {
    
    
    
}
/**
 * 功能：拖动进度条结束事件
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onSeekDone:(NSTimeInterval)seekDoneTime; {
    
    
    
}
/**
 * 功能：是否锁屏
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView lockScreen:(BOOL)isLockScreen; {
    
    
    
}
/**
 * 功能：切换后的清晰度
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView*)playerView onVideoQualityChanged:(AliyunVodPlayerVideoQuality)quality; {
    
    
    
}
/**
 * 功能：返回调用全屏
 */
- (void)aliyunVodPlayerView:(AliyunVodPlayerView *)playerView fullScreen:(BOOL)isFullScreen; {
    
    
    
}
/**
 * 功能：循环播放开始
 */
- (void)onCircleStartWithVodPlayerView:(AliyunVodPlayerView *)playerView; {
    
    
    
}

@end
