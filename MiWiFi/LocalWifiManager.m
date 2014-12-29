//
//  LocalWifiManager.m
//  MiWiFi
//
//  Created by Huang Zhe on 14-12-26.
//  Copyright (c) 2014年 Huang Zhe. All rights reserved.
//

#import "LocalWifiManager.h"
#import "AFNetworking.h"

@implementation LocalWifiManager

+ (LocalWifiManager *)sharedWifiManager
{
    static dispatch_once_t onceToken;
    static LocalWifiManager *sharedWifiManager = nil;
    dispatch_once(&onceToken, ^{
        sharedWifiManager = [[super alloc] initUniqueInstance];
    });
    
    return sharedWifiManager;
}


- (LocalWifiManager *)initUniqueInstance
{
    self = [super init];
    
    if (self) {
        
        _wifiConnect = @"incorrect";
        _numberClient = 0;
        _in_speed = @"0B/s";
        _out_speed = @"0B/s";
        _mac = @"未知";
        _ssid = @"未连接到正确设备";
        [self updateLocationStatusOnTimer];
        
    }
    
    return self;
}


-(void)updateLocationStatusOnTimer {

    
    [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(updateNetworkStatus)
                                   userInfo:nil
                                    repeats:YES];
    
    
    
}

-(void)updateNetworkStatus{
    
    NSLog(@"time update");
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:5];
    
    //连接状态查看
    [manager POST:@"http://192.168.114.1/app/api/getSatus/wan" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*
        NSArray *ar = responseObject[@"params"];
        NSDictionary *dict =  ar[0];
        NSNumber *connect = dict[@"internet_status"];
         */
        
        NSNumber *connect = responseObject[@"params"][0][@"internet_status"];
        if ([connect isEqualToNumber:@(1)]) {
            self.wifiConnect=@"connect";
            [manager POST:@"http://192.168.114.1/app/api/getMeters/wan" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                self.out_speed = responseObject[@"params"][0][@"out_speed"];
                self.in_speed = responseObject[@"params"][0][@"in_speed"];
                
                //NSLog(@"%tu",self.numberClient);
                //NSLog(@"%@",responseObject);
                
            }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                
                self.in_speed = @"0B/s";
                self.out_speed = @"0B/s";
                

            }];
            

        }else{
            NSLog(@"disconnect");
            //self.connectLabel.text = @"断开";
            self.wifiConnect = @"disconnect";
            self.in_speed = @"0B/s";
            self.out_speed = @"0B/s";
        }
        
        
        //连接人数 ssid
        [manager POST:@"http://192.168.114.1/app/api/getMeters/wlan" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.numberClient = [responseObject[@"params"][0][@"stations"][0][@"sta_macs"] count];
            self.mac =responseObject[@"params"][0][@"macs"][0];
            self.ssid =responseObject[@"params"][0][@"ssids"][0];
            
            //NSLog(@"%tu",self.numberClient);
            //NSLog(@"%@",responseObject);
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            self.numberClient = 0;
            self.mac = @"未知";
            self.ssid = @"未连接到正确设备";
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.wifiConnect = @"incorrect";
        self.numberClient = 0;
        
        self.in_speed = @"0B/s";
        self.out_speed = @"0B/s";
        
        self.mac = @"未知";
        self.ssid = @"未连接到正确设备";
   
    }];
    
    
    

    
    
    
    
}




@end
