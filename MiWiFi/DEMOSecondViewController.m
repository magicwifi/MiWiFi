//
//  DEMOSecondViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "AFNetworking.h"


@interface DEMOSecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dhcp;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet PBFlatTextfield *usernameField;
@property (weak, nonatomic) IBOutlet PBFlatTextfield *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *pppoe;


@end

@implementation DEMOSecondViewController

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)toggleChange:(id)sender {


    if ([sender selectedSegmentIndex] ==0) {
        
        self.dhcp.hidden = NO;
        self.pppoe.hidden = YES;
        
        self.usernameLabel.hidden = YES;
        self.passwordLabel.hidden = YES;
        self.usernameField.hidden = YES;
        self.passwordField.hidden = YES;
        
        
    }else{
        
        self.dhcp.hidden = YES;
        self.pppoe.hidden = NO;
        
        self.usernameLabel.hidden = NO;
        self.passwordLabel.hidden = NO;
        self.usernameField.hidden = NO;
        self.passwordField.hidden = NO;
  
    
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)dhcpPress:(id)sender {
    
    [self dhcpPost];
    
}


-(void)dhcpPost{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"conn_type":@"dhcp",@"ip_addr":@"",@"ip_netmask":@"",@"ip_gateway":@"",@"ppp_user":@"",@"ppp_pwd":@"",@"main_dns":@"",@"bak_dns":@""};
  
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://192.168.114.1/app/api/set/wan" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //NSLog(@"JSON: %d", (int)[responseObject integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (IBAction)pppoePress:(id)sender {
    [self pppoePost];
}

-(void)pppoePost{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"conn_type":@"static_ip",@"ip_addr":@"124.127.116.204",@"ip_netmask":@"255.255.255.192",@"ip_gateway":@"124.127.116.193",@"ppp_user":@"",@"ppp_pwd":@"",@"main_dns":@"219.142.69.22",@"bak_dns":@"8.8.8.8"};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://192.168.114.1/app/api/set/wan" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"JSON: %d", (int)[responseObject integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}





@end
