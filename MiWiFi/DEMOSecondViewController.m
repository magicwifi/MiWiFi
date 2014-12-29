//
//  DEMOSecondViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "AFNetworking.h"


#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "FUISegmentedControl.h"
#import "TSMessage.h"


@interface DEMOSecondViewController ()



@property (weak, nonatomic) IBOutlet FUISegmentedControl *segmentedControll;
@property (weak, nonatomic) IBOutlet FUIButton *dhcpButton;

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet FUIButton *pppoeButton;


@property (weak, nonatomic) IBOutlet UITextField *publicField;
@property (weak, nonatomic) IBOutlet UITextField *gatewayField;
@property (weak, nonatomic) IBOutlet UITextField *maskField;

@property (weak, nonatomic) IBOutlet UITextField *dnsField;
@property (weak, nonatomic) IBOutlet UILabel *publicLabel;
@property (weak, nonatomic) IBOutlet UILabel *gatewayLabel;
@property (weak, nonatomic) IBOutlet UILabel *maskLabel;
@property (weak, nonatomic) IBOutlet UILabel *dnsLabel;
@property (weak, nonatomic) IBOutlet FUIButton *staticIP;



@end

@implementation DEMOSecondViewController

-(void)viewDidAppear:(BOOL)animated{

    
    self.segmentedControll.selectedFont = [UIFont boldFlatFontOfSize:16];
    self.segmentedControll.selectedFontColor = [UIColor cloudsColor];
    self.segmentedControll.deselectedFont = [UIFont flatFontOfSize:16];
    self.segmentedControll.deselectedFontColor = [UIColor cloudsColor];
    self.segmentedControll.selectedColor = [UIColor pumpkinColor];
    self.segmentedControll.deselectedColor = [UIColor tangerineColor];
    self.segmentedControll.disabledColor = [UIColor silverColor];
    self.segmentedControll.dividerColor = [UIColor silverColor];
    self.segmentedControll.cornerRadius = 5.0;
    
    self.dhcpButton.buttonColor = [UIColor turquoiseColor];
    self.dhcpButton.shadowColor = [UIColor greenSeaColor];
    self.dhcpButton.shadowHeight = 3.0f;
    self.dhcpButton.cornerRadius = 6.0f;
    self.dhcpButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.dhcpButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.dhcpButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    self.pppoeButton.buttonColor = [UIColor turquoiseColor];
    self.pppoeButton.shadowColor = [UIColor greenSeaColor];
    self.pppoeButton.shadowHeight = 3.0f;
    self.pppoeButton.cornerRadius = 6.0f;
    self.pppoeButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.pppoeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.pppoeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.passLabel.font = [UIFont flatFontOfSize:20];
    self.passLabel.textColor = [UIColor turquoiseColor];
    self.userLabel.font = [UIFont flatFontOfSize:20];
    self.userLabel.textColor = [UIColor turquoiseColor];
    
    self.publicLabel.font = [UIFont flatFontOfSize:20];
    self.publicLabel.textColor = [UIColor turquoiseColor];
    self.gatewayLabel.font = [UIFont flatFontOfSize:20];
    self.gatewayLabel.textColor = [UIColor turquoiseColor];
    self.dnsLabel.font = [UIFont flatFontOfSize:20];
    self.dnsLabel.textColor = [UIColor turquoiseColor];
    self.maskLabel.font = [UIFont flatFontOfSize:20];
    self.maskLabel.textColor = [UIColor turquoiseColor];

    
    self.staticIP.buttonColor = [UIColor turquoiseColor];
    self.staticIP.shadowColor = [UIColor greenSeaColor];
    self.staticIP.shadowHeight = 3.0f;
    self.staticIP.cornerRadius = 6.0f;
    self.staticIP.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.staticIP setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.staticIP setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];


}








- (IBAction)toggleChange:(id)sender {


    if ([sender selectedSegmentIndex] ==0) {
        
        self.dhcpButton.hidden = NO;
        
        self.userField.hidden = YES;
        self.passField.hidden = YES;
        self.userLabel.hidden = YES;
        self.passLabel.hidden = YES;
        self.pppoeButton.hidden = YES;
        
        
        self.publicField.hidden = YES;
        self.gatewayField.hidden = YES;
        self.dnsField.hidden = YES;
        self.maskField.hidden = YES;
        self.publicLabel.hidden = YES;
        self.gatewayLabel.hidden = YES;
        self.dnsLabel.hidden = YES;
        self.maskLabel.hidden = YES;
        self.staticIP.hidden = YES;
        
        
        
        

    }else if([sender selectedSegmentIndex] ==1) {
        self.dhcpButton.hidden = YES;
        
        self.userField.hidden = NO;
        self.passField.hidden = NO;
        self.userLabel.hidden = NO;
        self.passLabel.hidden = NO;
        self.pppoeButton.hidden = NO;
        
        self.publicField.hidden = YES;
        self.gatewayField.hidden = YES;
        self.dnsField.hidden = YES;
        self.maskField.hidden = YES;
        self.publicLabel.hidden = YES;
        self.gatewayLabel.hidden = YES;
        self.dnsLabel.hidden = YES;
        self.maskLabel.hidden = YES;
        self.staticIP.hidden = YES;
        
        
        
        
    }else{
        
        
        self.dhcpButton.hidden = YES;
        
        self.userField.hidden = YES;
        self.passField.hidden = YES;
        self.userLabel.hidden = YES;
        self.passLabel.hidden = YES;
        self.pppoeButton.hidden = YES;
        
        
        self.publicField.hidden = NO;
        self.gatewayField.hidden = NO;
        self.dnsField.hidden = NO;
        self.maskField.hidden = NO;
        self.publicLabel.hidden = NO;
        self.gatewayLabel.hidden = NO;
        self.dnsLabel.hidden = NO;
        self.maskLabel.hidden = NO;
        self.staticIP.hidden = NO;
    
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)dhcpPress:(id)sender {
    
    [self dhcpPost];
    
}


- (IBAction)pppoePress:(id)sender {

    [self pppoePost];
}

- (IBAction)staticPress:(id)sender {

    [self staticPost];
}


-(void)dhcpPost{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"conn_type":@"dhcp",@"ip_addr":@"",@"ip_netmask":@"",@"ip_gateway":@"",@"ppp_user":@"",@"ppp_pwd":@"",@"main_dns":@"",@"bak_dns":@""};
  
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:5];
    [manager POST:@"http://192.168.114.1/app/api/set/wan" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"DHCP设置完毕", nil)
                                    subtitle:NSLocalizedString(@"请检查是否能够访问互联网", nil)
                                        type:TSMessageNotificationTypeWarning];
        
        
        
        //NSLog(@"JSON: %d", (int)[responseObject integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"请连接到正确的ssid上", nil)
                                    subtitle:NSLocalizedString(@"请链接到ssid为AWiFi的设备上", nil)
                                        type:TSMessageNotificationTypeError];
    }];
    
    

    
    
}
-(void)pppoePost{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *username = self.userField.text;
    NSString *password = self.passField.text;
    
    
    
    NSDictionary *parameters = @{@"conn_type":@"pppoe",@"ip_addr":@"",@"ip_netmask":@"",@"ip_gateway":@"",@"ppp_user":username,@"ppp_pwd":password,@"main_dns":@"",@"bak_dns":@""};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:5];
    [manager POST:@"http://192.168.114.1/app/api/set/wan" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"PPPOE设置完毕", nil)
                                    subtitle:NSLocalizedString(@"请检查是否能够访问互联网", nil)
                                        type:TSMessageNotificationTypeWarning];
        
        
        
        //NSLog(@"JSON: %d", (int)[responseObject integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"请连接到正确的ssid上", nil)
                                    subtitle:NSLocalizedString(@"请链接到ssid为AWiFi的设备上", nil)
                                        type:TSMessageNotificationTypeError];
    }];

    
}

-(void)staticPost{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *public = self.publicField.text;
    NSString *gateway = self.gatewayField.text;
    NSString *dns = self.dnsField.text;
    NSString *mask = self.maskField.text;
    
    
    NSDictionary *parameters = @{@"conn_type":@"static_ip",@"ip_addr":public,@"ip_netmask":mask,@"ip_gateway":gateway,@"ppp_user":@"",@"ppp_pwd":@"",@"main_dns":dns,@"bak_dns":@""};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:5];
    [manager POST:@"http://192.168.114.1/app/api/set/wan" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"静态IP设置完毕", nil)
                                    subtitle:NSLocalizedString(@"请检查是否能够访问互联网", nil)
                                        type:TSMessageNotificationTypeWarning];
             
        
        //NSLog(@"JSON: %d", (int)[responseObject integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"请连接到正确的ssid上", nil)
                                    subtitle:NSLocalizedString(@"请链接到ssid为AWiFi的设备上", nil)
                                        type:TSMessageNotificationTypeError];
        
    }];
    
    
}







@end
