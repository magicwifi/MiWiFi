//
//  SAMultisectorViewController.m
//  CustomControl
//
//  Created by Snipter on 12/31/13.
//  Copyright (c) 2013 SmartAppStudio. All rights reserved.
//

#import "SAMultisectorViewController.h"
#import "TimeLineViewControl.h"
#import "TSMessage.h"

#import "AFNetworking.h"
#import "LocalWifiManager.h"
#import  <LocalAuthentication/LocalAuthentication.h>

@interface  SAMultisectorViewController()
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;

@property (strong, nonatomic) LocalWifiManager *localWifiManager;
@property (weak, nonatomic) IBOutlet UILabel *clientNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *inspeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *outspeedLabel;

@property (weak, nonatomic) IBOutlet UILabel *macLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;

@property (nonatomic, strong) NSString *updateConnect;


@end


@implementation SAMultisectorViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _localWifiManager = [LocalWifiManager sharedWifiManager];
    [self.localWifiManager addObserver:self forKeyPath:@"wifiConnect" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
    
     [self.localWifiManager addObserver:self forKeyPath:@"numberClient" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
    
    [self.localWifiManager addObserver:self forKeyPath:@"out_speed" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
    
    [self.localWifiManager addObserver:self forKeyPath:@"in_speed" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
    
    [self.localWifiManager addObserver:self forKeyPath:@"ssid" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
    [self.localWifiManager addObserver:self forKeyPath:@"mac" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
    
    self.updateConnect = @"incorrect";
    
    
	[self setupDesign];
   

    
}


-(void)updateNetworkStatusOnTimer{
    /*
    if ([self.updateTimer isValid]) {
        // The timer is already running.
        [self.updateTimer invalidate];
    }
     self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                        target:self
                                                      selector:@selector(updateNetworkStatus)
                                                      userInfo:nil
                                                       repeats:YES];*/
    
    
    
}

-(void)updateNetworkStatus{

    NSLog(@"time update");
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:5];
    
    
    [manager POST:@"http://192.168.114.1/app/api/getSatus/wan" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *ar = responseObject[@"params"];
        NSDictionary *dict =  ar[0];
        NSNumber *connect = dict[@"internet_status"];
        if ([connect isEqualToNumber:@(1)]) {
            NSLog(@"connect");
            self.connectLabel.text = @"可上网";
            
            
        }else{
              NSLog(@"disconnect");
             self.connectLabel.text = @"断开";
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}


-(void)viewDidAppear:(BOOL)animated{
    
        //[self updateNetworkStatusOnTimer];
    
}



-(void)viewDidDisappear:(BOOL)animated{
    /*
    if ([self.updateTimer isValid]) {
        // The timer is already running.
        [self.updateTimer invalidate];
    }*/

}








- (void)setupDesign{
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}

- (void)setupMultisectorControl:(int)status{

    
    NSArray *times = @[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"7th"];
    NSArray *descriptions = @[@"欢迎使用AWiFi服务",@"连接AP电源",@"手机选择正确的SSID",@"AP接入网线",@"配置网络",@"成功访问互联网",@"上传广告，设置完毕"];
    TimeLineViewControl *timeline = [[TimeLineViewControl alloc] initWithTimeArray:times
                                                           andTimeDescriptionArray:descriptions
                                                                  andCurrentStatus:status
                                                                          andFrame:CGRectMake(50, 200, self.view.frame.size.width - 30, 200)];
    timeline.center = self.view.center;
    [self.view addSubview:timeline];
    
    


}

- (void)dealloc
{
    [self.localWifiManager removeObserver:self forKeyPath:@"wifiConnect"];
    [self.localWifiManager removeObserver:self forKeyPath:@"numberClient"];
    [self.localWifiManager removeObserver:self forKeyPath:@"out_speed"];
    [self.localWifiManager removeObserver:self forKeyPath:@"in_speed"];
    [self.localWifiManager removeObserver:self forKeyPath:@"ssid"];
    [self.localWifiManager removeObserver:self forKeyPath:@"mac"];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"wifiConnect"]) {
        /*
        NSString *newValue = (NSString *)change[NSKeyValueChangeNewKey];
        self.connectLabel.text =newValue;
         */
        NSString *newValue = (NSString *)change[NSKeyValueChangeNewKey];
        
        if (![self.updateConnect isEqualToString:newValue]) {
            


            if ([newValue isEqualToString:@"connect"] ) {
                [TSMessage showNotificationWithTitle:NSLocalizedString(@"网络设置成功", nil)
                                            subtitle:NSLocalizedString(@"现在可以正常访问互联网", nil)
                                                type:TSMessageNotificationTypeSuccess];
                
                [self setupMultisectorControl:6];

                
                self.updateConnect = newValue;
                
            }else if([newValue isEqualToString:@"disconnect"]){
                [TSMessage showNotificationWithTitle:NSLocalizedString(@"网络设置失败", nil)
                                            subtitle:NSLocalizedString(@"请重新配置网络，并检查网线是否接好", nil)
                                                type:TSMessageNotificationTypeError];
                
                [self setupMultisectorControl:5];
                
                self.updateConnect = newValue;
                
            }else{

                [TSMessage showNotificationWithTitle:NSLocalizedString(@"请连接到正确的SSID上", nil)
                                            subtitle:NSLocalizedString(@"请链接到SSID为AWiFi的设备上", nil)
                                                type:TSMessageNotificationTypeWarning];
                [self setupMultisectorControl:3];
                self.updateConnect = newValue;
            }
        }
        
    }else if([keyPath isEqualToString:@"numberClient"]){
        
        NSString *count = (NSString *)change[NSKeyValueChangeNewKey];
        //NSLog(@"%@",count);
        self.clientNumLabel.text =[NSString stringWithFormat:@"%@",count];

    }
    else if ([keyPath isEqualToString:@"out_speed"]) {
        NSString *newValue = (NSString *)change[NSKeyValueChangeNewKey];
        self.outspeedLabel.text =newValue;
        
    }
    else if ([keyPath isEqualToString:@"in_speed"]) {
        NSString *newValue = (NSString *)change[NSKeyValueChangeNewKey];
        self.inspeedLabel.text =newValue;
        
    }
    else if ([keyPath isEqualToString:@"ssid"]) {
        NSString *newValue = (NSString *)change[NSKeyValueChangeNewKey];
        self.ssidLabel.text =newValue;
        
    }
    else if ([keyPath isEqualToString:@"mac"]) {
        NSString *newValue = (NSString *)change[NSKeyValueChangeNewKey];
        self.macLabel.text =newValue;
        
    }
    
    
}






@end
