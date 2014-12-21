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
#import "Reachability.h"
#import  <LocalAuthentication/LocalAuthentication.h>

@interface  SAMultisectorViewController()
@property(strong) Reachability * internetConnectionReach;

@end


@implementation SAMultisectorViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
	[self setupDesign];
    [self setupMultisectorControl];
    [self touchIDCheck];

}

- (IBAction)showmenu:(id)sender {

    [TSMessage showNotificationWithTitle:NSLocalizedString(@"Something failed", nil)
                                subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                    type:TSMessageNotificationTypeError];

}



- (void)setupDesign{
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)setupMultisectorControl{

    
    NSArray *times = @[@"sun",@"mon",@"tue",@"wed",@"thr",@"fri",@"sat"];
    NSArray *descriptions = @[@"state 1",@"state 2",@"state 3",@"state 4",@"very very long and very very detailed description 0f state 5",@"state 6",@"state 7"];
    TimeLineViewControl *timeline = [[TimeLineViewControl alloc] initWithTimeArray:times
                                                           andTimeDescriptionArray:descriptions
                                                                  andCurrentStatus:4
                                                                          andFrame:CGRectMake(50, 200, self.view.frame.size.width - 30, 200)];
    timeline.center = self.view.center;
    [self.view addSubview:timeline];
    
    

    
     self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    self.internetConnectionReach.reachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@" InternetConnection Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [TSMessage showNotificationWithTitle:NSLocalizedString(@"Success", nil)
                                        subtitle:NSLocalizedString(@"Some task was successfully completed!", nil)
                                            type:TSMessageNotificationTypeSuccess];
            
            
        });
    };
    
    self.internetConnectionReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"InternetConnection Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [TSMessage showNotificationWithTitle:NSLocalizedString(@"Something failed", nil)
                                        subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                            type:TSMessageNotificationTypeError];

            
        });
    };
    
    [self.internetConnectionReach startNotifier];
    
    
    

}





-(void)touchIDCheck {

    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authenticate using your finger";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL succes, NSError *error) {
                                
                                if (succes) {
                                    
                                    NSLog(@"User is authenticated successfully");
                                } else {
                                    
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                            NSLog(@"Authentication Failed");
                                            break;
                                            
                                        case LAErrorUserCancel:
                                            NSLog(@"User pressed Cancel button");
                                            break;
                                            
                                        case LAErrorUserFallback:
                                            NSLog(@"User pressed \"Enter Password\"");
                                            break;
                                            
                                        default:
                                            NSLog(@"Touch ID is not configured");
                                            break;
                                    }
                                    
                                    NSLog(@"Authentication Fails");
                                }
                            }];
    } else {
        NSLog(@"Can not evaluate Touch ID");
        
    }


}


@end
