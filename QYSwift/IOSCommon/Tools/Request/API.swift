//
//  API.swift
//  HHXCSwift
//
//  Created by 张健 on 16/6/21.
//  Copyright © 2016年 张健. All rights reserved.
//

import Foundation
import UIKit



let zjBaseURL   : String = "http://open.qyer.com/lastminute/home/major"


//穷游最世界首页
let zjIndex                 = "http://open.qyer.com/lastminute/home/major?&client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&lat=23.2883183152015&lon=113.78183245695&page=1&page_size=20&ra_referer=app_start_image&size=375x667&track_app_channel=App%2520Store&track_app_version=2.0.0&track_device_info=iPhone7%2C2&track_deviceid=9F985BB6-C9B7-4464-985B-F206AD153AF4&track_os=ios%25209.3.4&track_user_id="

//穷游最世界首页猜你喜欢
let zjIndexLike             = "http://open.qyer.com/lastminute/app_selected_product?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&lat=23.2883183152015&lon=113.78183245695&page_size=10&ra_referer=app_home&size=375x667&track_app_channel=App%2520Store&track_app_version=2.0.0&track_device_info=iPhone7%2C2&track_deviceid=9F985BB6-C9B7-4464-985B-F206AD153AF4&track_os=ios%25209.3.4&track_user_id=&page="


//穷游最世界首页热门搜索
let zjIndexHotSearch       = "http://open.qyer.com/lastminute/app_hot_searched_words?oauth_token=769105ec3442687e55c59d7186605f8f&client_secret=44c86dbde623340b5e0a&client_id=qyer_discount_ios&track_app_version=2.0.0&ra_referer=choiceness&lat=40.0461835833331&track_os=ios%25209.3.1&app_installtime=1472460959&lon=116.345868394196&track_app_channel=App%2520Store&track_deviceid=5FED1AF6-AC64-48E7-B0F0-F1BB312637EE&track_device_info=iPhone%25205(ChinaMobile,ChinaTelecom,ChinaUnicom)&track_user_id=&size=320x568"

//穷游最世界目的地
let zjDestination           = "http://open.qyer.com/lastminute/conf/destination?client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&lat=40.04637001852355&lon=116.3458901279912&oauth_token=769105ec3442687e55c59d7186605f8f&page=1&page_size=20&ra_referer=choiceness&size=320x568&track_app_channel=App%2520Store&track_app_version=2.0.0&track_device_info=iPhone%25205%28ChinaMobile%2CChinaTelecom%2CChinaUnicom%29&track_deviceid=5FED1AF6-AC64-48E7-B0F0-F1BB312637EE&track_os=ios%25209.3.1&track_user_id=8352142"

//穷游最世界获取所有城市
let zjGetCitys              = "http://open.qyer.com/lastminute/destnation/targetlist?&client_id=qyer_discount_ios&client_secret=44c86dbde623340b5e0a&lat=40.04612134697024&lon=116.3458396982475&oauth_token=769105ec3442687e55c59d7186605f8f&page=1&page_size=20&ra_referer=choiceness&size=320x568&track_app_channel=App%2520Store&track_app_version=2.0.0&track_device_info=iPhone%25205%28ChinaMobile%2CChinaTelecom%2CChinaUnicom%29&track_deviceid=5FED1AF6-AC64-48E7-B0F0-F1BB312637EE&track_os=ios%25209.3.1&track_user_id="
//Banners
let zs_banners              = "zs/banners"


//获取验证码
let zjHHXCCode              = "sendverifycode"

//预约教练
let zjHHXCReserveTeachers   = "reserve/teachers"

//获取Banner
let zjHHXCBanners           = "banners"

//替换SID
let zjHHXCChangeSID         = "flushsid"

//我的预约
let zjHHXCReserveList       = "user/reserve/list"

//预约详情
let zjHHXCReserveDetail     = "user/reserve/detail"

//取消预约
let zjHHXCReserveCancel     = "user/reserve/cancel"

//确认取消预约
let zjHHXCReserveRequest    = "user/reserve/cancel/confirm"

//我的学车进度
let zjHHXCUserSchedule      = "user/schedule"

//收藏教练列表
let zjHHXCCollectList       = "collect/list"

//教练详情
let zjHHXCTeacherDetail     = "teacher/detail"

//获取教练详情评价接口
let zjHHXCJudgement         = "judgement/get"

//获取套餐列表
let zjHHXCPackageList       = "package/list"

//获取套餐详情
let zjHHXCPackageDetail     = "class/detail"

//保存用户信息
let zjHHXCSaveUserInfo      = "user/info/save"








