//
//  OADCreateCVViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/14.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADCreateCVViewController.h"

#import "CreateCVRootModel.h"
#import "CreateCVViewModel.h"
#import "CreateCVJobIntensionData.h"

#import "CreateCVHeaderView.h"
#import "CreateCVUserInfoCell.h"
#import "CreateCVJobIntensionCell.h"
#import "CreateCVJobexperiencesCell.h"
#import "CreateCVSkillsCertificateCell.h"
#import "CreateCVEducationExperienceCell.h"

#import "OADCVBrowseViewController.h"
#import "OADUserInfomationViewController.h"
#import "OADAddJobIntensionViewController.h"
#import "OADJobExperiencesListViewController.h"
#import "OADSkillsCertificateListViewController.h"
#import "OADEducationExperienceListViewController.h"

@interface OADCreateCVViewController ()<CustomAdapterTypeTableViewCellDelegate, CustomHeaderFooterViewDelegate, CreateCVSkillsCertificateCellDelegate>

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *classModels;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@end

@implementation OADCreateCVViewController

- (QTCheckImageScrollView *)checkImageScrollView {
    
    if (!_checkImageScrollView) {
        
        _checkImageScrollView = [QTCheckImageScrollView new];
        
    }
    
    return _checkImageScrollView;
    
}

- (NSMutableDictionary *)params {

    if (!_params) {

        _params = [[NSMutableDictionary alloc] init];
    }

    return _params;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialization];

}

- (void) initialization {
    
    self.classModels = [NSMutableArray array];
    NSDictionary *firstSectionModel = @{@"iconImageString":@"user_info",@"title":@"基本信息",@"isShowButton":@"1",@"isShowType":@"1"};
    NSDictionary *secondSectionModel = @{@"iconImageString":@"job_intension",@"title":@"求职意向",@"isShowButton":@"1",@"isShowType":@"1"};
    NSDictionary *thirdSectionModel = @{@"iconImageString":@"work_life",@"title":@"工作经验",@"isShowButton":@"1",@"isShowType":@"1"};
    NSDictionary *fourthSectionModel = @{@"iconImageString":@"skill_certificate",@"title":@"技能证书",@"isShowButton":@"1",@"isShowType":@"0"};
    NSDictionary *fifthSectionModel = @{@"iconImageString":@"user_educational",@"title":@"教育经历",@"isShowButton":@"1",@"isShowType":@"0"};
    [self.classModels addObject:firstSectionModel];
    [self.classModels addObject:secondSectionModel];
    [self.classModels addObject:thirdSectionModel];
    [self.classModels addObject:fourthSectionModel];
    [self.classModels addObject:fifthSectionModel];
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    NSDictionary *params = @{@"userId" : accountInfo.user_id,
                             @"CVId"   : self.cvId};

    [MBProgressHUD showMessage:nil toView:self.view];
    
    [CreateCVViewModel requestPost_getCVNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        int64_t delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            self.datasArray = [NSMutableArray array];
            [self.tableView reloadData];
            
            NSMutableArray *tmpDatasArray = [NSMutableArray array];
            //  获取用户数据
            CreateCVRootModel    *model = [[CreateCVRootModel alloc] initWithDictionary:info];
            CreateCVUserInfoData *data  = model.data[0];
            
            self.navigationItem.title = [NSString stringWithFormat:@"简历完整：%@",data.integrity];
            
            [self loadUserInfoCellDataWithRootModel:model];
            [self loadJobIntensionCellDataWithRootModel:model];
            [self loadJobExperiencesCellDataWithRootModel:model];
            [self loadSkillsCertificateCellDataWithRootModel:model];
            [self loadEducationExpericenceCellDataWithRootModel:model];
            
            [self.tableView beginUpdates];
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < self.datasArray.count; i++) {
                
                NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:i];
                [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                
                NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[i];
                NSMutableArray <TableViewCellDataAdapter *> *tmpAdapterArray = [NSMutableArray array];
                
                for (int j = 0; j < adapters.count; j++) {
                    
                    TableViewCellDataAdapter *adapter = adapters[j];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    adapter.indexPath = indexPath;
                    [indexPaths addObject:indexPath];
                    [tmpAdapterArray addObject:adapter];
                    
                }
                
                [tmpDatasArray addObject:tmpAdapterArray];
            
            }
            
            self.datasArray = [tmpDatasArray mutableCopy];
            
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            
        });
        
    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];
    
}

- (void)setNavigationController {

    self.navTitle     = @"简历完整：0%";
    self.leftItemText = @"返回";
    self.rightItemText = @"预览";
    [super setNavigationController];

}

- (void)clickRightItem {
    
    OADCVBrowseViewController *viewController = [OADCVBrowseViewController new];
    viewController.cvId                       = self.cvId;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)buildSubView {

    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BackGrayColor;

    [self.tableView registerClass:[CreateCVHeaderView class] forHeaderFooterViewReuseIdentifier:@"CreateCVHeaderView"];
    [CreateCVUserInfoCell registerToTableView:self.tableView];
    [CreateCVJobIntensionCell registerToTableView:self.tableView];
    [CreateCVJobexperiencesCell registerToTableView:self.tableView];
    [CreateCVSkillsCertificateCell registerToTableView:self.tableView];
    [CreateCVEducationExperienceCell registerToTableView:self.tableView];

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {


    }

}

#pragma mark - 更新dataSours
- (void) loadUserInfoCellDataWithRootModel:(id)rootModel {

    CreateCVRootModel *model = rootModel;

    if (model.data.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (CreateCVUserInfoData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        CreateCVUserInfoData *data = datasArray[0];

        self.adapters = [NSMutableArray array];
        [CreateCVUserInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVUserInfoCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:0];

        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    } else {

        self.adapters = [NSMutableArray array];
        CreateCVUserInfoData *data = [[CreateCVUserInfoData alloc] init];
        [CreateCVUserInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVUserInfoCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:0];
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    }

}

- (void) loadJobIntensionCellDataWithRootModel:(id)rootModel {

    CreateCVRootModel    *model = rootModel;
    CreateCVUserInfoData *data  = model.data[0];

    if (data.hopeSalary.length > 0) {

        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (CreateCVUserInfoData *data in model.data) {
            
            [datasArray addObject:data];
            
        }
        self.adapters = [NSMutableArray array];
        CreateCVUserInfoData *data = datasArray[0];
        [CreateCVJobIntensionCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVJobIntensionCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.normalStringHeight
                                                                                                                cellType:kCreateCVJobIntensionCellNormalType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    } else {

        self.adapters = [NSMutableArray array];
        CreateCVUserInfoData *data = [[CreateCVUserInfoData alloc] init];
        [CreateCVJobIntensionCell cellHeightWithData:data];
        TableViewCellDataAdapter *jobIntensionAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVJobIntensionCell"
                                                                                                                    data:data
                                                                                                              cellHeight:data.noDataStringHeight
                                                                                                                cellType:kCreateCVJobIntensionCellNoDataType];
        [self.adapters addObject:jobIntensionAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    }

}

- (void) loadJobExperiencesCellDataWithRootModel:(id)rootModel {

    CreateCVRootModel *model = rootModel;
    
    if (model.workExp.count > 0) {
        
        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (CreateCVJobexperiencesData *workExp in model.workExp) {
            
            [datasArray addObject:workExp];
            
        }

        self.adapters = [NSMutableArray array];
        for (int i = 0; i < datasArray.count; i++) {

            CreateCVJobexperiencesData *workExp = datasArray[i];
            [CreateCVJobexperiencesCell cellHeightWithData:workExp];
            TableViewCellDataAdapter *jobExperiencesAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVJobexperiencesCell"
                                                                                                                          data:workExp
                                                                                                                    cellHeight:workExp.normalStringHeight
                                                                                                                      cellType:kCreateCVJobexperiencesCellNormalType];

            if (i == datasArray.count - 1) {

                jobExperiencesAdapter.isHideBottomView = YES;

            } else {

                jobExperiencesAdapter.isHideBottomView = NO;

            }

            [self.adapters addObject:jobExperiencesAdapter];

        }
        [self.datasArray addObject:[self.adapters mutableCopy]];

    } else {

        self.adapters = [NSMutableArray array];
        CreateCVJobexperiencesData *workExp = [[CreateCVJobexperiencesData alloc] init];
        [CreateCVJobexperiencesCell cellHeightWithData:workExp];
        TableViewCellDataAdapter *jobExperiencesAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVJobexperiencesCell"
                                                                                                                      data:workExp
                                                                                                                cellHeight:workExp.noDataStringHeight
                                                                                                                  cellType:kCreateCVJobexperiencesCellNoDataType];
        [self.adapters addObject:jobExperiencesAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    }

}

- (void) loadSkillsCertificateCellDataWithRootModel:(id)rootModel {

    CreateCVRootModel *model = rootModel;

    if (model.skillCert.count > 0) {

        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (CreateCVSkillsCertificateData *skillsCertificate in model.skillCert) {
            
            [datasArray addObject:skillsCertificate];
            
        }
        
        self.adapters = [NSMutableArray array];
        for (int i = 0; i < datasArray.count; i++) {

            CreateCVSkillsCertificateData *skillsCertificate = datasArray[i];
            [CreateCVSkillsCertificateCell cellHeightWithData:skillsCertificate];
            TableViewCellDataAdapter *skillsCertificateAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVSkillsCertificateCell"
                                                                                                                             data:skillsCertificate
                                                                                                                       cellHeight:skillsCertificate.normalStringHeight
                                                                                                                         cellType:kCreateCVSkillsCertificateCellNormalType];
            [self.adapters addObject:skillsCertificateAdapter];

        }
        [self.datasArray addObject:[self.adapters mutableCopy]];

    } else {

        self.adapters = [NSMutableArray array];
        CreateCVSkillsCertificateData *skillsCertificate = [[CreateCVSkillsCertificateData alloc] init];
        [CreateCVSkillsCertificateCell cellHeightWithData:skillsCertificate];
        TableViewCellDataAdapter *skillsCertificateAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVSkillsCertificateCell"
                                                                                                                         data:skillsCertificate
                                                                                                                   cellHeight:skillsCertificate.noDataStringHeight
                                                                                                                     cellType:kCreateCVSkillsCertificateCellNoDataType];
        [self.adapters addObject:skillsCertificateAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    }

}

- (void) loadEducationExpericenceCellDataWithRootModel:(id)rootModel {

    CreateCVRootModel *model = rootModel;

    if (model.eduExp.count > 0) {

        NSMutableArray *datasArray = [[NSMutableArray alloc] init];
        for (CreateCVEducationExperienceData *educationExperience in model.eduExp) {
            
            [datasArray addObject:educationExperience];
            
        }
        
        self.adapters = [NSMutableArray array];
        for (int i = 0; i < datasArray.count; i++) {

            CreateCVEducationExperienceData *educationExperience = datasArray[i];
            [CreateCVEducationExperienceCell cellHeightWithData:educationExperience];
            TableViewCellDataAdapter *educationExperienceAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVEducationExperienceCell"
                                                                                                                               data:educationExperience
                                                                                                                         cellHeight:educationExperience.normalStringHeight
                                                                                                                           cellType:kCreateCVEducationExperienceCellNormalType];
            [self.adapters addObject:educationExperienceAdapter];
        }
        [self.datasArray addObject:[self.adapters mutableCopy]];

    } else {

        self.adapters = [NSMutableArray array];
        CreateCVEducationExperienceData *educationExperience = [[CreateCVEducationExperienceData alloc] init];
        [CreateCVEducationExperienceCell cellHeightWithData:educationExperience];
        TableViewCellDataAdapter *educationExperienceAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CreateCVEducationExperienceCell"
                                                                                                                           data:educationExperience
                                                                                                                     cellHeight:educationExperience.noDataStringHeight
                                                                                                                       cellType:kCreateCVEducationExperienceCellNoDataType];
        [self.adapters addObject:educationExperienceAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];

    }

}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CreateCVHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CreateCVHeaderView"];
    titleView.delegate         = self;
    titleView.data             = _classModels[section];
    titleView.section          = section;
    [titleView loadContent];
    
    return titleView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50 *Scale_Height;

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 4) {

        return 10 *Scale_Height;

    } else {

        return 0.01;

    }

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return nil;

}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return self.datasArray.count;

}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[section];

    return adapters.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];

    return adapters[indexPath.row].cellHeight;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];
    TableViewCellDataAdapter *adapter = adapters[indexPath.row];
    
    if (indexPath.section == 3) {
        
        
        CreateCVSkillsCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
        cell.dataAdapter                     = adapter;
        cell.data                            = adapter.data;
        cell.tableView                       = tableView;
        cell.indexPath                       = indexPath;
        cell.delegate                        = self;
        cell.subCellDelegate                 = self;
        [cell loadContent];
        
        return cell;
        
    } else {
        
        CustomAdapterTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
        cell.dataAdapter                     = adapter;
        cell.data                            = adapter.data;
        cell.tableView                       = tableView;
        cell.indexPath                       = indexPath;
        cell.delegate                        = self;
        
        [cell loadContent];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[indexPath.section];
    TableViewCellDataAdapter *adapter = adapters[indexPath.row];
    
    if (indexPath.section == 0) {
        
        __weak OADCreateCVViewController *weakSelf = self;
        OADUserInfomationViewController *viewController = [OADUserInfomationViewController new];
        viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
            if (isNeedLoadCVData) {
                
                [weakSelf initialization];
                
            }
            
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (indexPath.section == 1) {

        [self pushJobIntensionVCWithData:adapter.data];
        
    } else if (indexPath.section == 2) {
        
        if (adapter.cellType == kCreateCVJobexperiencesCellNoDataType) {
            
            CarOadLog(@"点击工作经历");
            
        } else {
            
            CustomAdapterTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell selectedEvent];
            
        }
        
    } else if (indexPath.section == 3) {
        
        if (adapter.cellType == kCreateCVSkillsCertificateCellNoDataType) {
            
            CarOadLog(@"点击技能证书");
            
        }
        
    } else if (indexPath.section == 4) {
        
        if (adapter.cellType == kCreateCVEducationExperienceCellNoDataType) {
            
            CarOadLog(@"点击教育经历");
            
        }
        
    }
    
}

- (void) pushJobIntensionVCWithData:(id)userInfoData {
    
    __weak OADCreateCVViewController *weakSelf = self;
    OADAddJobIntensionViewController *viewController = [OADAddJobIntensionViewController new];
    CreateCVUserInfoData *data = userInfoData;

    CreateCVJobIntensionData *model = [CreateCVJobIntensionData new];
    model.skillPost                 = data.skillPost;
    model.hopeSalaryName            = data.hopeSalaryName;
    model.workTypeName              = data.workTypeName;
    model.workNatureName            = data.workNatureName;
    model.workAddress               = data.workAddress;
    model.workType                  = data.workType;
    model.hopeSalary                = data.hopeSalary;
    model.workNature                = data.workNature;
    model.provinceId                = data.provinceId;
    model.cityId                    = data.cityId;
    model.areaId                    = data.areaId;
    model.intentionId               = data.intentionId;
    model.CVId                      = self.cvId;
    
    viewController.data = model;
    viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
        if (isNeedLoadCVData) {
            
            [weakSelf initialization];
            
        }
    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {



}

- (void)customHeaderFooterView:(CustomHeaderFooterView *)customHeaderFooterView event:(id)event; {
    
    __weak OADCreateCVViewController *weakSelf = self;
    
    CreateCVHeaderView *headerView = (CreateCVHeaderView *)customHeaderFooterView;
    if (headerView.section == 0) {
        
        OADUserInfomationViewController *viewController = [OADUserInfomationViewController new];
        viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
            if (isNeedLoadCVData) {
                
                [weakSelf initialization];
                
            }
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (headerView.section == 1) {
        
        NSArray <TableViewCellDataAdapter *> *adapters = self.datasArray[headerView.section];
        TableViewCellDataAdapter *adapter = adapters[0];
        [self pushJobIntensionVCWithData:adapter.data];
        
    } else if (headerView.section == 2) {
        
        OADJobExperiencesListViewController *viewController = [OADJobExperiencesListViewController new];
        viewController.cvId                                 = self.cvId;
        viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
            if (isNeedLoadCVData) {
                
                [weakSelf initialization];
                
            }
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (headerView.section == 3) {
        
        OADSkillsCertificateListViewController *viewController = [OADSkillsCertificateListViewController new];
        viewController.cvId                                    = self.cvId;
        viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
            if (isNeedLoadCVData) {
                
                [weakSelf initialization];
                
            }
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (headerView.section == 4) {
        
        OADEducationExperienceListViewController *viewController = [OADEducationExperienceListViewController new];
        viewController.cvId                                    = self.cvId;
        viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
            if (isNeedLoadCVData) {
                
                [weakSelf initialization];
                
            }
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - CreateCVSkillsCertificateCellDelegate
- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag; {
    
    self.checkImageScrollView.imagesArray = [array copy];
    [self.checkImageScrollView showwithTag:tag - 1000];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
