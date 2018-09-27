//
//  OADHomePageViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADHomePageViewController.h"

#import "HomePageViewModel.h"
//  招聘列表model
#import "RecruitListRootModel.h"
//  需求列表model
#import "DemandListRootModel.h"

#import "HomePageBulletinCell.h"
#import "HomePageTrendsCell.h"
#import "HomePageAdvertiseInfomationCell.h"
#import "HomePageNeedInfomationCell.h"

#import "OADBulletinInfoViewController.h"
#import "OADAdvertiseViewController.h"
#import "OADMyDeliverDetailsViewController.h"
#import "OADNeedViewController.h"
#import "OADMyOrderDetailsViewController.h"
#import "OADMessageListViewController.h"

@interface OADHomePageViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, HomePageTrendsCellDelegate, HomePageBulletinCellDelegate>
{

    NSArray *switchDataArray;
    NSArray *infomationDataArray;
    NSArray *timeNewsDataArray;
    NSArray *recruitListDataArray;
    NSArray *demandListDataArray;
    
    BOOL isGetInfomationDataFinish;
    BOOL isGetTimeNewsDataFinish;
    BOOL isGetRecruitListDataFinish;
    BOOL isGetDemandListDataFinish;
    
}
@property (nonatomic, strong) UIView            *headerView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView            *navigationBackView;
@property (nonatomic, strong) UIView            *navigationMaskView;
@property (nonatomic, strong) UIView            *badgeView;

@end

@implementation OADHomePageViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden           = NO;
    
    [self loadNewData];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavigationView];

}

- (void)setNavigationController {
    
    
}

- (void) buildSubView {
    
    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, 0, Screen_Width, self.view.height - 49 - SafeAreaBottomHeight);
    self.tableView.frame = self.contentView.bounds;
    //self.tableView.style = UITableViewStyleGrouped;
    self.tableView.tableHeaderView = [self creatLunBoTuView];
    
    [HomePageBulletinCell registerToTableView:self.tableView];
    [HomePageTrendsCell registerToTableView:self.tableView];
    [HomePageAdvertiseInfomationCell registerToTableView:self.tableView];
    [HomePageNeedInfomationCell registerToTableView:self.tableView];
    
}

- (void) createNavigationView {

    UIView *navigationBackView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, SafeAreaTopHeight)];
    navigationBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigationBackView];
    self.navigationBackView = navigationBackView;
    
    UIView *navigationMaskView         = [[UIView alloc]initWithFrame:navigationBackView.bounds];
    navigationMaskView.backgroundColor = MainColor;
    [navigationBackView addSubview:navigationMaskView];
    self.navigationMaskView = navigationMaskView;
    
    {
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"首页"
                                                  font:[UIFont fontWithName:@"STHeitiSC-Medium" size:17.f]
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
        [navigationMaskView addSubview:label];
        
        [label sizeToFit];
        label.center = CGPointMake(navigationMaskView.width / 2, navigationMaskView.height - 22);
        
        UIImage *buttonImage = [UIImage imageNamed:@"message_item_white"];
        
        CGSize imageSize = buttonImage.size;
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(navigationBackView.width - 44, SafeAreaTopHeight - 44, 44, 44)
                                                buttonType:kButtonNormal
                                                     title:nil
                                                     image:buttonImage
                                                  higImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = [UIColor clearColor];
        [navigationBackView addSubview:button];
        
        UIView *badgeView         = [[UIView alloc]initWithFrame:CGRectMake((button.width + imageSize.width) / 2 - 6, (button.height - imageSize.height) / 2 - 2, 8, 8)];
        badgeView.backgroundColor = [UIColor redColor];
        [button addSubview:badgeView];
        badgeView.layer.masksToBounds = YES;
        badgeView.layer.cornerRadius  = badgeView.width / 2;
        self.badgeView = badgeView;
        
    }

    self.navigationMaskView.hidden = YES;

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {
        
        if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
         
            OADMessageListViewController *viewController = [OADMessageListViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    } else if (sender.tag == 2001) {
        
        OADAdvertiseViewController *viewController = [OADAdvertiseViewController new];
        viewController.isHomePagePush = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (sender.tag == 2002) {
        
        OADNeedViewController *viewController = [OADNeedViewController new];
        viewController.isHomePagePush = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }

}

- (UIView *) creatLunBoTuView {

    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 187.5 *Scale_Height)];

    SDCycleScrollView * cycleScrollView    = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, 187.5 *Scale_Height)
                                                                                delegate:self
                                                                        placeholderImage:[UIImage imageNamed:@"img_home_default"]];
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.pageControlAliment     = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup            = nil;
    cycleScrollView.currentPageDotColor    = MainColor; // 自定义分页控件小圆标颜色
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.headerView addSubview:cycleScrollView];

    self.cycleScrollView = cycleScrollView;

    return _headerView;

}

- (void) loadNewData {
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    //  获取首页轮播图片
    {
        
        [HomePageViewModel requestPost_getHomePageSwitchImagesNetWorkingDataWithParams:nil success:^(id info, NSInteger count) {
            
            NSMutableArray *sliderArray = [NSMutableArray new];
            NSArray        *data        = info[@"data"];
            switchDataArray = [data copy];

            for (NSDictionary *model in data) {

                NSString *imageUrl = model[@"imgUrl"];
                
                if (imageUrl.length > 0) {
                    
                    [sliderArray addObject:imageUrl];

                }

            }
            dispatch_async(dispatch_get_main_queue(), ^{

                self.cycleScrollView.imageURLStringsGroup = [sliderArray copy];

            });

        } error:^(NSString *errorMessage) {
            
            
        } failure:^(NSError *error) {

        }];

    }

    //  获取技士快报
    {
        
        [HomePageViewModel requestPost_getHomePageInformationNetWorkingDataWithParams:nil success:^(id info, NSInteger count) {
                        
            NSArray *data       = info[@"data"];
            infomationDataArray = [data copy];
            
            dispatch_async(dispatch_get_main_queue(), ^{

                isGetInfomationDataFinish = YES;
                [self loadTableViewData];
                
            });
            
        } error:^(NSString *errorMessage) {
            
            isGetInfomationDataFinish = YES;
            [self loadTableViewData];
            
        } failure:^(NSError *error) {
            
            isGetInfomationDataFinish = YES;
            [self loadTableViewData];
            
        }];
        
    }
    
    //  获取实时动态
    {

        [HomePageViewModel requestPost_getHomePageTimeNewsNetWorkingDataWithParams:nil success:^(id info, NSInteger count) {
            
            NSArray *data     = info[@"data"];
            timeNewsDataArray = [data copy];
            
            dispatch_async(dispatch_get_main_queue(), ^{

                isGetTimeNewsDataFinish = YES;
                [self loadTableViewData];
                
            });
            
        } error:^(NSString *errorMessage) {

            isGetTimeNewsDataFinish = YES;
            [self loadTableViewData];

        } failure:^(NSError *error) {

            isGetTimeNewsDataFinish = YES;
            [self loadTableViewData];
            
        }];
        
    }
    
    //  获取招聘列表
    {
        
        NSDictionary *params = @{@"skillPost":@"",
                                 @"provinceId":@"0",
                                 @"cityId":@"0",
                                 @"areaId":@"0",
                                 @"salaryRangeId":@"1",
                                 @"workExpId":@"1",
                                 @"workTypeId":@"1",
                                 @"workNatureId":@"1",
                                 @"sortDate":@"0",
                                 @"pageStep":@"3",
                                 @"pageNo":@"1"};
        
        [HomePageViewModel requestPost_getHomePageRecruitListNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
            RecruitListRootModel *rootModel = [[RecruitListRootModel alloc] initWithDictionary:info];
            recruitListDataArray            = [rootModel.data copy];
            
            dispatch_async(dispatch_get_main_queue(), ^{

                isGetRecruitListDataFinish = YES;
                [self loadTableViewData];
                
            });
            
        } error:^(NSString *errorMessage) {
            
            isGetRecruitListDataFinish = YES;
            [self loadTableViewData];
            
        } failure:^(NSError *error) {
            
            isGetRecruitListDataFinish = YES;
            [self loadTableViewData];
            
        }];
        
    }

    //  获取需求列表
    {

        NSDictionary *params = @{@"demandTitle"  : @"",
                                 @"provinceId"   : @"0",
                                 @"cityId"       : @"0",
                                 @"areaId"       : @"0",
                                 @"brandId"      : @"0",
                                 @"carTypeId"    : @"0",
                                 @"demandTypeId" : @"0",
                                 @"sortDate"     : @"0",
                                 @"pageStep"     : @"3",
                                 @"pageNo"       : @"1"};

        [HomePageViewModel requestPost_getHomePageDemandListNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
            DemandListRootModel *rootModel = [[DemandListRootModel alloc] initWithDictionary:info];
            demandListDataArray            = [rootModel.data copy];
            
            dispatch_async(dispatch_get_main_queue(), ^{

                isGetDemandListDataFinish = YES;
                [self loadTableViewData];
                
            });
            
        } error:^(NSString *errorMessage) {

            isGetDemandListDataFinish = YES;
            [self loadTableViewData];

        } failure:^(NSError *error) {

            isGetDemandListDataFinish = YES;
            [self loadTableViewData];

        }];

    }

}

- (void) loadTableViewData {

    if (isGetInfomationDataFinish == YES && isGetTimeNewsDataFinish == YES && isGetRecruitListDataFinish == YES && isGetDemandListDataFinish == YES) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isGetInfomationDataFinish = NO;
        isGetTimeNewsDataFinish = NO;
        isGetRecruitListDataFinish = NO;
        isGetDemandListDataFinish = NO;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    }

}

#pragma mark - scrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat yOffset = self.tableView.contentOffset.y;

    //  判断是否让按钮显示
    if (yOffset >= 64) {

        self.navigationMaskView.hidden = NO;

    }else {

        self.navigationMaskView.hidden = YES;

    }
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void) cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    NSDictionary *model = switchDataArray[index];
    
    NSString *html = model[@"htmlUrl"];
    
    if (html.length > 0) {
        
        OADBulletinInfoViewController *viewController = [OADBulletinInfoViewController new];
        viewController.infoUrlString = html;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - HomePageBulletinCellDelegate
- (void) clickChankBulletinDetailsWithData:(id)data; {
    
    NSDictionary *model = data;
    
    NSString *html = model[@"informationURL"];
    
    if (html.length > 0) {
        
        OADBulletinInfoViewController *viewController = [OADBulletinInfoViewController new];
        viewController.infoUrlString = html;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {

        return nil;

    } else if (section == 1) {

        return [self createSectionHeaderViewWithLineColor:MainColor title:@"实时动态" isShowButton:NO tag:2000];

    } else if (section == 2) {

        return [self createSectionHeaderViewWithLineColor:[UIColor redColor] title:@"招聘信息" isShowButton:YES tag:2001];

    } else {

        return [self createSectionHeaderViewWithLineColor:[UIColor orangeColor] title:@"需求信息" isShowButton:YES tag:2002];

    }

}

- (UIView *) createSectionHeaderViewWithLineColor:(UIColor *)color title:(NSString *)title isShowButton:(BOOL)isShowButton tag:(NSInteger)tag {

    UIView *backView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40 *Scale_Height)];
    backView.backgroundColor = [UIColor whiteColor];

    UIView *v_lineView         = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, (backView.height - 16 *Scale_Height) / 2, 2.5f, 17 *Scale_Height)];
    v_lineView.backgroundColor = color;
    [backView addSubview:v_lineView];

    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(v_lineView.x + v_lineView.width + 10 *Scale_Width, (backView.height - 20 *Scale_Height) / 2, 200 *Scale_Width, 20 *Scale_Height)
                                            labelType:kLabelNormal
                                                 text:title
                                                 font:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.f *Scale_Width]
                                            textColor:TextBlackColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:100];
    [backView addSubview:titleLabel];

    UIView *h_lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height - 0.7f, backView.width, 0.7f)];
    h_lineView.backgroundColor = LineColor;
    [backView addSubview:h_lineView];

    if (isShowButton == YES) {

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width - 32 *Scale_Height, 17.5 *Scale_Height, 18 *Scale_Height, 5 *Scale_Height)];
        imageView.contentMode  = UIViewContentModeScaleAspectFit;
        imageView.image        = [UIImage imageNamed:@"more_button"];
        [backView addSubview:imageView];

        UIButton *button = [UIButton createButtonWithFrame:backView.bounds
                                                     title:nil
                                           backgroundImage:nil
                                                       tag:tag
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [backView addSubview:button];

    }

    return backView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {

        return 0.01;

    } else {

        return 40 *Scale_Height;

    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 3) {

        return 0.01;

    } else {

        return 10 *Scale_Height;
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return nil;

}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        if (infomationDataArray.count > 0) {
            
            return 1;
            
        } else {
            
            return 0;
            
        }
        
    } else if (section == 1) {
        
        if (timeNewsDataArray.count > 0) {
            
            return 1;
            
        } else {
            
            return 0;
            
        }
        
    } else if (section == 2) {
        
        if (recruitListDataArray.count > 0) {
            
            return recruitListDataArray.count;
            
        } else {
            
            return 0;
            
        }
        
    } else {
        
        if (demandListDataArray.count > 0) {
            
            return demandListDataArray.count;
            
        } else {
            
            return 0;
            
        }

    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        return 40 *Scale_Height;

    } else if (indexPath.section == 1) {

        return 90;

    } else if (indexPath.section == 2) {

        return 100 *Scale_Height;

    } else {

        return (Screen_Width - 44 *Scale_Width) / 9 *2 + 20 *Scale_Height;

    }

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HomePageBulletinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageBulletinCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if (infomationDataArray.count > 0) {
            
            cell.data = infomationDataArray;
            [cell loadContent];
            
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        HomePageTrendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTrendsCell" forIndexPath:indexPath];
        cell.selectionStyle      = UITableViewCellSelectionStyleNone;
        cell.delegate            = self;
        
        if (timeNewsDataArray.count > 0) {
            
            cell.data = timeNewsDataArray;
            [cell loadContent];
            
        }
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
        HomePageAdvertiseInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageAdvertiseInfomationCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (recruitListDataArray.count > 0) {
            
            cell.data = recruitListDataArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    } else {
        
        HomePageNeedInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageNeedInfomationCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (demandListDataArray.count > 0) {
            
            cell.data = demandListDataArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    }
    
}

//  cell的点击方法
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        if (indexPath.section == 0) {
            
            
            
        } else if (indexPath.section == 2) {
            
            RecruitListData *model = recruitListDataArray[indexPath.row];
            OADMyDeliverDetailsViewController *viewController = [OADMyDeliverDetailsViewController new];
            viewController.recruiId = model.recruitId;
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else if (indexPath.section == 3) {
            
            DemandListData *model = demandListDataArray[indexPath.row];
            OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
            viewController.demandId                         = model.demandId;
            viewController.isNeedListPush                   = YES;
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    }
    
}

#pragma mark - HomePageTrendsCellDelegate
- (void) clickChankDetailsWithData:(id)data; {
    
    NSDictionary *model    = data;
    NSString     *timeType = model[@"timeNewsType"];
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        if ([timeType integerValue] == 2) {
            
            OADMyDeliverDetailsViewController *viewController = [OADMyDeliverDetailsViewController new];
            viewController.recruiId                           = model[@"timeNewsId"];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else {
            
            OADMyOrderDetailsViewController *viewController = [OADMyOrderDetailsViewController new];
            viewController.demandId                         = model[@"timeNewsId"];
            viewController.isNeedListPush                   = YES;
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    }
    
}

@end
