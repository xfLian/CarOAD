
//
//  OADInterfaceDoc.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#ifndef OADInterfaceDoc_h
#define OADInterfaceDoc_h

#pragma mark - index 首页
#define CLASS_INDEX             @"index/"
#define CREATE_UPLOAD_VIDEO     @"createUploadVideo"    //  生成视频上传凭证
#define GET_VIDEO_PLAY_PATH     @"getVideoPlayPath"     //  获取视频播放凭证
#define SWITCH                  @"switch"               //  首页-图片轮换
#define INFORMATION             @"information"          //  首页-技师快报
#define TIMENEWS                @"timeNews"             //  首页-实时动态

#pragma mark - shoptech 技术
#define CLASS_SHOPTECH           @"shoptech/"
#define GET_PROVINCES_LIST       @"GetProvincesList"     //  技术需求-区域-获取省
#define GET_CITY_BY_PROCINCES_ID @"GetCityByProvincesId" //  技术需求-区域-获取市
#define GET_AREAS_BY_CITY_ID     @"GetAreasByCityId"     //  技术需求-区域-获取区县
#define GET_DEMAND_LIST          @"GetDemandList"        //  技术需求-获取需求列表（搜索）
#define GET_CAR_BRAND            @"GetCarBrand"          //  技术需求-车型-获取车品牌
#define GET_CAR_TYPE             @"GetCarType"           //  技术需求-车型-获取车型
#define GET_DEMAND_TYPE          @"GetDemandType"        //  技术需求-类型-获取需求类型
#define GET_DEMAND_BY_MAP        @"GetDemandByMap"       //  技术需求-查找附近
#define GET_DEMAND_INFO          @"GetDemandInfo"        //  技术需求-详情-获取需求详情
#define ADD_ORDER_MSG            @"AddOrderMsg"          //  需求详情-接单-提交接单留言

#pragma mark - job 人才中心
#define CLASS_JOB         @"job/"
#define GET_DUTY_ITEM     @"GetDutyItem"    //  人才中心-要求
#define GET_RECRUIT_LIST  @"getRecruitList" //  招聘中心-招聘列表（搜索）
#define GET_POST_INFO     @"getPostInfo"    //  人才中心-职位详情
#define GET_CV_LIST       @"getCVList"      //  我的简历列表
#define SEND_CV           @"sendCV"         //  人才中心-招聘详情-投递简历

#pragma mark - user 我的
#define CLASS_USER              @"user/"
#define USER_LOGIN              @"userLogin"            //  0.用户登录
#define GET_VERIFICATION_CODE   @"getVerificationCode"  //  1.获取验证码
#define USER_SIGN_IN            @"userSignIn"           //  2.用户注册
#define MODIFY_NEW_PWD          @"modifyNewPwd"         //  3.忘记密码-设置新密码
#define CHANGE_PWD              @"changePwd"            //  4.修改密码
#define LICSENCE_HTML           @"licsence.html"        //  5.凯路登用户协议
#define CHECK_ADMIN             @"checkAdmin"           //  6.获取App版本信息
#define MY_INFO                 @"myInfo"               //  7.我的-我的资料
#define ADD_RESUME              @"addResume"            //  8.我的简历-创建简历(简历列表已有数据的情况下)
#define ADD_CV_BASIC            @"addCVBasic"           //  9.我的简历-创建简历-基本信息(简历列表无数据的情况下)
#define ADD_INTENTION           @"addIntention"         //  10.我的简历-创建简历-求职意向（添加/修改）
#define ADD_WORK_EXP            @"addWorkExp"           //  11.我的简历-创建简历-工作经验（添加/修改）
#define ADD_SKILL_CERT          @"addSkillCert"         //  12.我的简历-创建简历-技能证书（添加/修改）
#define ADD_EDU_EXP             @"addEduExp"            //  13.我的简历-创建简历-教育经历(添加/修改)
#define GET_WORK_EXP            @"getWorkExp"           //  14.我的简历-获取工作经验
#define GET_SKILL_CERT          @"getSkillCert"         //  15.我的简历-获取技能证书
#define GET_EDU_EXP             @"getEduExp"            //  16.我的简历-获取教育经历
#define GET_CV                  @"getCV"                //  17.我的简历-简历预览
#define REFRESH_CV              @"refreshCV"            //  18.我的简历-刷新简历
#define DEL_CV                  @"delCV"                //  19.我的简历-删除简历
#define SET_CV_DEFAUL           @"setCVDefaul"          //  20.我的简历-设置简历默认
#define SET_CV_OPEN             @"setCVOpen"            //  21.我的简历-设置简历公开
#define GET_EXCEPT_SHOP         @"getExceptShop"        //  22.我的简历-屏蔽商铺列表
#define ADD_EXCEPT_SHOP         @"addExceptShop"        //  23.我的简历-添加屏蔽商铺
#define CANCEL_EXCEPT_SHOP      @"cancelExceptShop"     //  24.我的简历-取消屏蔽商铺
#define GET_USER_INFO           @"getUserInfo"          //  25.我的简历-获取用户基本信息
#define MOBILE_AUTH             @"mobileAuth"           //  26.我的-基本信息-手机号认证
#define DELETE_WORK_EXP         @"deleteWorkExp"        //  27.我的简历-工作经验-删除工作经验
#define DELETE_SKILL_CERT       @"deleteSkillCert"      //  28.我的简历-技能证书-删除技能证书
#define DELETE_EDU_EXP          @"deleteEduExp"         //  29.我的简历-技能证书-删除教育经历
#define GET_SKILL_LIST          @"getSkillList"         //  30.我的技能-获取技能列表
#define GET_SKILL_INFO          @"GetSkillInfo"         //  31.我的技能-技能详情
#define GET_USER_COMMENT_LIST   @"GetCommentList"       //  32.我的技能-技能详情-评价列表
#define MODIFY_SKILL_ORDER      @"modifySkillOrder"     //  33.我的技能-处理接单
#define MODIFY_SKILL_STATE      @"modifySkillState"     //  34.我的技能-修改技能状态（暂停/回复）
#define DEL_SKILL               @"DelSkill"             //  35.我的技能-删除技能
#define ADD_SKILL               @"addSkill"             //  36.我的技能-添加/修改技能
#define GET_GATEGORY            @"GetCategory"          //  37.我的技能-添加技能-服务类型
#define GET_CATENA              @"GetCatena"            //  38.我的技能-添加技能-服务类型-服务系
#define GET_GATEGORY_INFO       @"GetCategoryInfo"      //  39.我的技能-添加技能-服务类型-服务系-
#define GET_SKILL_ORDER_LIST    @"getSkillOrderList"    //  40.我的技能-技能订单列表
#define GET_DEMAND_ORDER_LIST   @"GetDemandOrderList"   //  41.我的接单-接单列表（需求接单）
#define CANCEL_DEMAND_ORDER     @"CancelDemandOrder"    //  42.我的接单-取消接单
#define GET_ALL_COMMENT_LIST    @"GetAllCommentList"    //  43.我的服务评价-评价列表
#define REALNAME_AUTH           @"realnameAuth"         //  44.我的-实名认证
#define GET_NOTICE_LIST         @"getNoticeList"        //  45.我的-消息通知
#define GET_NOTICE_INFO         @"getNoticeInfo"        //  46.我的-消息通知详情
#define ADD_ADVICE              @"addAdvice"            //  47.我的-设置-意见反馈
#define GET_SEND_CV             @"getSendCV"            //  48.我的-我的投递-投递列表

#pragma mark - Community 社区
#define CLASS_COMMUNITY         @"community/"
#define GET_TAG_LIST            @"getTagList"                   //  社区-标签列表
#define GET_QA_LIST             @"getQAList"                    //  获取问答列表
#define GET_ANSWER_LIST         @"getAnswerList"                //  回答列表
#define GET_ANSWER_REPLY_LIST   @"getAnswerReplyList"           //  回复列表
#define ADD_QA                  @"addQA"                        //  发布问答
#define ADD_ANSWER              @"addAnswer"                    //  回答问答
#define COMMENT_ANSWER          @"commentAnswer"                //  评论回答
#define REPLY_COMMENT           @"replyComment"                 //  回复评论
#define GET_ARTICLE_LIST        @"getArticleList"               //  文章列表
#define GET_ARTICLE_INFO        @"getArtInfo"                   //  文章详情
#define GET_COMMENT_LIST        @"getCommentList"               //  评论列表
#define ADD_ARTICLE             @"addArticle"                   //  发布文章
#define ADD_COMMENT             @"addComment"                   //  评论文章
#define ADD_REPLY_COMMENT       @"addReplyComment"              //  文章评论回复
#define GET_COMMENT_REPLY_LIST  @"getReplyCommentByCommnetId"   //  文章评论回复列表
#define GET_VIDEO_LIST          @"getVideoList"                 //  视频列表
#define ADD_VIDEO               @"addVideo"                     //  发布视频
#define GET_MY_SELF_QA_LIST      @"getMySelfQAList"             //  我的发布-问答
#define GET_MY_SELF_VIDEO_LIST   @"getMySelfVideoList"          //  我的发布-视频
#define GET_MY_SELF_ARTICLE_LIST @"getMySelfArticleList"        //  我的发布-文章

#endif /* OADInterfaceDoc_h */
