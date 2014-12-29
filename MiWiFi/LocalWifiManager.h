//
//  LocalWifiManager.h
//  MiWiFi
//
//  Created by Huang Zhe on 14-12-26.
//  Copyright (c) 2014年 Huang Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalWifiManager : NSObject

@property (strong, nonatomic) NSString *wifiConnect;
@property (nonatomic) NSUInteger numberClient;

@property (strong, nonatomic) NSString *out_speed;
@property (strong, nonatomic) NSString *in_speed;
@property (strong, nonatomic) NSString *mac;
@property (strong, nonatomic) NSString *ssid;


+ (LocalWifiManager *)sharedWifiManager;

@end
