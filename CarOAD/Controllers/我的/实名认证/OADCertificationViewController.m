//
//  OADCertificationViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADCertificationViewController.h"

#import "CertificationMainView.h"
#import "CertificationViewModel.h"

#import "OADSureCertificationIdSuccessViewController.h"
//#import "OADIdentifierViewController.h"

@interface OADCertificationViewController ()<CertificationMainViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
{

    NSInteger  view_tag;
    NSArray   *uploadImagesArray;
    UIImage   *idCodePhotoImage;
    UIImage   *idCodeBackPhotoImage;
    UIImage   *idCodeWithHandPhotoImage;
    NSString  *IDPros;
    NSString  *IDCons;
    NSString  *IDFilePath;
    NSString  *RealName;
    NSString  *IDNumber;

}
@property (nonatomic, strong) CertificationMainView *certificationView;

@end

@implementation OADCertificationViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

- (void)setNavigationController {

    self.navTitle     = @"实名认证";
    self.leftItemText = @"返回";

    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];
    
    view_tag = 0;
    self.view.backgroundColor = [UIColor whiteColor];

    CertificationMainView *certificationView = [[CertificationMainView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    certificationView.delegate       = self;
    [self.contentView addSubview:certificationView];
    self.certificationView = certificationView;

}

- (void) publishCertificationInfo; {

    __weak OADCertificationViewController *weakSelf = self;

    if (idCodePhotoImage) {

        NSArray *imageArray = @[idCodePhotoImage];

        [OSSImageUploader asyncUploadImages:imageArray complete:^(NSArray<NSString *> *names, UploadImageState state) {

            if (state == UploadImageFailed) {

                [MBProgressHUD showMessageTitle:@"照片上传失败，请重新上传" toView:self.view afterDelay:1.5f];
                return;

            } else {

                NSString *imageString = [names componentsJoinedByString:@","];
                IDPros = imageString;
                [weakSelf requset_publishData];

            }

        }];

    } else {

        [MBProgressHUD showMessageTitle:@"请扫描身份证人像面" toView:self.view afterDelay:1.5f];
        return;

    }

    if (idCodeBackPhotoImage) {

        NSArray *imageArray = @[idCodeBackPhotoImage];

        [OSSImageUploader asyncUploadImages:imageArray complete:^(NSArray<NSString *> *names, UploadImageState state) {

            if (state == UploadImageFailed) {

                [MBProgressHUD showMessageTitle:@"照片上传失败，请重新上传" toView:self.view afterDelay:1.5f];
                return;

            } else {

                NSString *imageString = [names componentsJoinedByString:@","];
                IDCons = imageString;
                [weakSelf requset_publishData];

            }

        }];

    } else {

        [MBProgressHUD showMessageTitle:@"请上传身份证国徽面" toView:self.view afterDelay:1.5f];
        return;

    }

    if (idCodeWithHandPhotoImage) {

        NSArray *imageArray = @[idCodeWithHandPhotoImage];

        [OSSImageUploader asyncUploadImages:imageArray complete:^(NSArray<NSString *> *names, UploadImageState state) {

            if (state == UploadImageFailed) {

                [MBProgressHUD showMessageTitle:@"照片上传失败，请重新上传" toView:self.view afterDelay:1.5f];
                return;

            } else {

                NSString *imageString = [names componentsJoinedByString:@","];
                IDFilePath = imageString;
                [weakSelf requset_publishData];

            }

        }];

    } else {

        [MBProgressHUD showMessageTitle:@"请上传手持身份证照片" toView:self.view afterDelay:1.5f];
        return;

    }

}

- (void) requset_publishData {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    if (IDPros.length > 0) {

        [params setObject:IDPros forKey:@"IDPros"];

    } else {

        [MBProgressHUD showMessageTitle:@"请扫描身份证人像面" toView:self.view afterDelay:1.5f];
        return;

    }

    if (IDCons.length > 0) {

        [params setObject:IDCons forKey:@"IDCons"];

    } else {

        [MBProgressHUD showMessageTitle:@"请上传身份证国徽面" toView:self.view afterDelay:1.5f];
        return;

    }

    if (IDFilePath.length > 0) {

        [params setObject:IDFilePath forKey:@"IDFilePath"];

    } else {

        [MBProgressHUD showMessageTitle:@"请上传手持身份证照片" toView:self.view afterDelay:1.5f];
        return;

    }

    if (RealName.length > 0) {

        [params setObject:RealName forKey:@"RealName"];

    }

    if (IDNumber.length > 0) {

        [params setObject:IDNumber forKey:@"IDNumber"];

    }

    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {

        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

        [params setObject:accountInfo.user_id forKey:@"userId"];

    } else {

        return;

    }

    [MBProgressHUD showMessage:@"正在提交认证申请，请稍后……" toView:self.view];

    [CertificationViewModel requestPost_realnameAuthNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"提交成功" toView:self.view afterDelay:1.5f];
        int64_t delayInSeconds = 1.6f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

            OADSureCertificationIdSuccessViewController *viewController = [OADSureCertificationIdSuccessViewController new];
            [self.navigationController pushViewController:viewController animated:YES];

        });

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"提交失败，请重新提交" toView:self.view afterDelay:1.5f];

    }];

}

- (void) chooseIdCodePhotoWithTag:(NSInteger)tag; {

    view_tag = tag;

    if (tag == 0) {

//        __weak OADCertificationViewController *weakSelf = self;
//        OADIdentifierViewController *viewController = [[OADIdentifierViewController alloc] init];
//        viewController.idInfoBlock = ^(NSString *name, NSString *idCode, UIImage *idPhotoImage) {
//
//            RealName = name;
//            IDNumber = idCode;
//            [weakSelf.certificationView loadUserNameAndIdCodeWithName:name idCode:idCode];
//            [weakSelf.certificationView loadIdPhotoWithImage:idPhotoImage tag:0];
//            idCodePhotoImage = idPhotoImage;
//
//        };
//        [self.navigationController pushViewController:viewController animated:YES];

    } else {

        NSString *message = nil;

        if (tag == 1) {

            message = @"请拍摄或选择身份证国徽面照片";

        } else {

            message = @"请拍摄或选择手持身份证人像面照片，并确保身份证内容清晰可见";

        }
        //调用系统相册的类
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.allowsEditing = YES;
        pickerController.delegate      = self;

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

            //  设置相册呈现的样式
            pickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;//图片分组列表样式

            //  使用模态呈现相册
            [self presentViewController:pickerController animated:YES completion:^{

            }];


        }];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从系统相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

            //  设置相册呈现的样式
            pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式

            //  使用模态呈现相册
            [self presentViewController:pickerController animated:YES completion:^{

            }];

        }];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        [alertController addAction:archiveAction];

        [self presentViewController:alertController animated:YES completion:nil];

    }

}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    if (view_tag == 1) {

        idCodeBackPhotoImage = resultImage;

    } else {

        idCodeWithHandPhotoImage = resultImage;

    }

    [self.certificationView loadIdPhotoWithImage:resultImage tag:view_tag];

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
