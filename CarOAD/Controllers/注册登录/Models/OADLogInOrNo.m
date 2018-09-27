//
//  OADLogInOrNo.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/8.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADLogInOrNo.h"

#import "OADLogInViewController.h"

@implementation OADLogInOrNo

+ (BOOL) logInIsSuccessOrNoDelegate:(id)delegate; {

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

    if (accountInfo.user_id) {

        return YES;

    } else {

        OADLogInViewController *logIn = [[OADLogInViewController alloc] init];
        logIn.modalTransitionStyle    = 0;
        [delegate presentViewController:logIn animated:YES completion:^{

        }];

        return NO;

    }

}

@end
