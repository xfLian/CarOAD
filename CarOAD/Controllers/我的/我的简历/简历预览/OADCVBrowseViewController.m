//
//  OADCVBrowseViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADCVBrowseViewController.h"

#import "CreateCVRootModel.h"
#import "CreateCVViewModel.h"
#import "CreateCVJobIntensionData.h"

#import "CreateCVHeaderView.h"
#import "CVBrowseUserInfoCell.h"
#import "CreateCVJobIntensionCell.h"
#import "CreateCVJobexperiencesCell.h"
#import "CreateCVSkillsCertificateCell.h"
#import "CreateCVEducationExperienceCell.h"

@interface OADCVBrowseViewController ()<CustomAdapterTypeTableViewCellDelegate, CreateCVSkillsCertificateCellDelegate>

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *classModels;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@end

@implementation OADCVBrowseViewController

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
    NSDictionary *firstSectionModel = @{@"iconImageString":@"user_info",
                                        @"title":@"基本信息",
                                        @"isShowButton":@"0",
                                        @"isShowType":@"0"};
    NSDictionary *secondSectionModel = @{@"iconImageString":@"job_intension",
                                         @"title":@"求职意向",
                                         @"isShowButton":@"0",
                                         @"isShowType":@"0"};
    NSDictionary *thirdSectionModel = @{@"iconImageString":@"work_life",
                                        @"title":@"工作经历",
                                        @"isShowButton":@"0",
                                        @"isShowType":@"0"};
    NSDictionary *fourthSectionModel = @{@"iconImageString":@"skill_certificate",
                                         @"title":@"技能证书",
                                         @"isShowButton":@"0",
                                         @"isShowType":@"0"};
    NSDictionary *fifthSectionModel = @{@"iconImageString":@"user_educational",
                                        @"title":@"教育经历",
                                        @"isShowButton":@"0",
                                        @"isShowType":@"0"};
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
            CreateCVRootModel *model = [[CreateCVRootModel alloc] initWithDictionary:info];
            
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
            
            self.tableView.tableHeaderView = [self createTableHeaderViewWithRootModel:model];
            
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
    
    self.navTitle     = @"简历预览";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BackGrayColor;
    
    [self.tableView registerClass:[CreateCVHeaderView class] forHeaderFooterViewReuseIdentifier:@"CreateCVHeaderView"];
    [CVBrowseUserInfoCell registerToTableView:self.tableView];
    [CreateCVJobIntensionCell registerToTableView:self.tableView];
    [CreateCVJobexperiencesCell registerToTableView:self.tableView];
    [CreateCVSkillsCertificateCell registerToTableView:self.tableView];
    [CreateCVEducationExperienceCell registerToTableView:self.tableView];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        
    }
    
}

- (UIView *) createTableHeaderViewWithRootModel:(id)rootModel {
    
    CreateCVRootModel    *model = rootModel;
    CreateCVUserInfoData *data  = model.data[0];
    
    CGFloat totalStringHeight = [data.adeptSkill heightWithStringFont:UIFont_15 fixedWidth:Width - 30 *Scale_Width];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 110 *Scale_Height + totalStringHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, 70 *Scale_Height, 70 *Scale_Height)];
    iconImageView.image           = [UIImage imageNamed:@"contact_off_gray"];
    iconImageView.contentMode     = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds   = YES;
    iconImageView.backgroundColor = [UIColor clearColor];
    iconImageView.layer.masksToBounds = YES;
    iconImageView.layer.cornerRadius  = iconImageView.width / 2;
    iconImageView.tag                 = 200;
    [backView addSubview:iconImageView];
    
    [QTDownloadWebImage downloadImageForImageView:iconImageView
                                         imageUrl:[NSURL URLWithString:data.userImg]
                                 placeholderImage:@"contact_off_gray"
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             
                                         }
                                          success:^(UIImage *finishImage) {
                                              
                                          }];
    
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(iconImageView.x + iconImageView.width + 10 *Scale_Width, iconImageView.y + 10 *Scale_Height, backView.width - (iconImageView.x + iconImageView.width + 25 *Scale_Width), 20 *Scale_Height)
                                         labelType:kLabelNormal
                                              text:data.userName
                                              font:UIFont_15
                                         textColor:TextBlackColor
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    [backView addSubview:nameLabel];
    
    UILabel *sexLabel = [UILabel createLabelWithFrame:CGRectZero
                                        labelType:kLabelNormal
                                             text:@""
                                             font:UIFont_14
                                        textColor:TextGrayColor
                                    textAlignment:NSTextAlignmentLeft
                                              tag:101];
    [backView addSubview:sexLabel];
    
    if ([data.userSex isEqualToString:@"M"]) {
        
        sexLabel.text = @"男";
        
    } else {
        
        sexLabel.text = @"女";
        
    }
    
    [sexLabel sizeToFit];
    sexLabel.frame = CGRectMake(nameLabel.x, nameLabel.y + nameLabel.height + 10 *Scale_Height, sexLabel.width, 20 *Scale_Height);
    
    UIView *first_h_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(sexLabel.x + sexLabel.width + 10 *Scale_Width, sexLabel.y + 3 *Scale_Height, 1.f, 14 *Scale_Height)];
    first_h_lineView.backgroundColor = LineColor;
    [backView addSubview:first_h_lineView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *birthDate = [dateFormatter dateFromString:data.birthDate];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *year    = [dateFormatter stringFromDate:birthDate];
    NSString *nowYear = [dateFormatter stringFromDate:[NSDate date]];
    NSInteger age = [nowYear integerValue] - [year integerValue];
    
    UILabel *ageLabel = [UILabel createLabelWithFrame:CGRectZero
                                        labelType:kLabelNormal
                                             text:[NSString stringWithFormat:@"%ld岁",age]
                                             font:UIFont_14
                                        textColor:TextGrayColor
                                    textAlignment:NSTextAlignmentLeft
                                              tag:102];
    [backView addSubview:ageLabel];
    [ageLabel sizeToFit];
    ageLabel.frame = CGRectMake(first_h_lineView.x + first_h_lineView.width + 10 *Scale_Width, sexLabel.y, ageLabel.width, 20 *Scale_Height);
    
    UIView *v_lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, iconImageView.y + iconImageView.height + 10 *Scale_Height, backView.width, 0.5f)];
    v_lineView.backgroundColor = LineColor;
    [backView addSubview:v_lineView];
    
    UILabel *contentLabel = [UILabel createLabelWithFrame:CGRectMake(iconImageView.x, v_lineView.y + 10 *Scale_Height, backView.width - 30 *Scale_Width, totalStringHeight)
                                            labelType:kLabelNormal
                                                 text:data.adeptSkill
                                                 font:UIFont_15
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentLeft
                                                  tag:101];
    contentLabel.numberOfLines = 0;
    [backView addSubview:contentLabel];
    
    return backView;
    
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
        [CVBrowseUserInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CVBrowseUserInfoCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kCVBrowseUserInfoCellNormalType];
        
        [self.adapters addObject:userInfoAdapter];
        [self.datasArray addObject:[self.adapters mutableCopy]];
        
    } else {
        
        self.adapters = [NSMutableArray array];
        CreateCVUserInfoData *data = [[CreateCVUserInfoData alloc] init];
        [CVBrowseUserInfoCell cellHeightWithData:data];
        TableViewCellDataAdapter *userInfoAdapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"CVBrowseUserInfoCell"
                                                                                                                data:data
                                                                                                          cellHeight:data.normalStringHeight
                                                                                                            cellType:kCVBrowseUserInfoCellNoDataType];
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
    titleView.data                = _classModels[section];
    titleView.section             = section;
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
    
    if (indexPath.section == 2) {
        
        if (adapter.cellType != kCreateCVJobexperiencesCellNoDataType) {
            
            CustomAdapterTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell selectedEvent];
            
        }
        
    }
    
}

#pragma mark - CustomAdapterTypeTableViewCellDelegate
- (void)customCell:(CustomAdapterTypeTableViewCell *)cell event:(id)event {
    
    
    
}

#pragma mark - CreateCVSkillsCertificateCellDelegate
- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag; {
    
    self.checkImageScrollView.imagesArray = [array copy];
    [self.checkImageScrollView showwithTag:tag - 1000];
    
}

@end
