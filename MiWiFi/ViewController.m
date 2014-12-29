//
//  ViewController.m
//  CameraShow
//
//  Created by Huang Zhe on 14-12-4.
//  Copyright (c) 2014年 Huang Zhe. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "TWCoreDataHelper.h"
#import "UIColor+FlatUI.h"

#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "FUIAlertView.h"
#import "AFNetworking.h"

#import "UINavigationBar+FlatUI.h"

@interface ViewController ()<FUIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *image;

@property (strong, nonatomic) NSURL *imageurl;

@property (weak, nonatomic) IBOutlet FUIButton *alertViewButton;


@end

@implementation ViewController



-(void)viewDidAppear:(BOOL)animated{
    
    self.alertViewButton.buttonColor = [UIColor turquoiseColor];
    self.alertViewButton.shadowColor = [UIColor greenSeaColor];
    self.alertViewButton.shadowHeight = 3.0f;
    self.alertViewButton.cornerRadius = 6.0f;
    self.alertViewButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.alertViewButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    
    [self readNSUserDefaults];
    

 
    
    
    NSLog(@"viewDidAppear");
    


}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    

    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)alertButtonPress:(id)sender {
    
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"广告设定" message:@"" delegate:nil cancelButtonTitle:@"取消上传" otherButtonTitles:@"广告上传", nil];
    alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
    [@[[alertView textFieldAtIndex:0], [alertView textFieldAtIndex:1]] enumerateObjectsUsingBlock:^(FUITextField *textField, NSUInteger idx, BOOL *stop) {
        [textField setTextFieldColor:[UIColor cloudsColor]];
        [textField setBorderColor:[UIColor asbestosColor]];
        [textField setCornerRadius:4];
        [textField setFont:[UIFont flatFontOfSize:14]];
        [textField setTextColor:[UIColor midnightBlueColor]];
    }];
    [[alertView textFieldAtIndex:0] setPlaceholder:self.title];
    
    alertView.onCancelAction=^{
        
        NSLog(@"onCancel");
        
    };
    
    alertView.onDismissAction = ^{
        
        NSLog(@"onDissmiss");
        
    };
    
    alertView.onOkAction = ^{
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //NSDictionary *parameters = @{@"foo": @"bar"};
        //NSURL *filePath = [NSURL fileURLWithPath:[self.imageurl absoluteString]];
        //NSLog(@"%@",[self.imageurl absoluteString]);
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [
         
         manager POST:@"http://124.127.116.181/posters" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
             [formData appendPartWithFileURL:self.imageurl name:@"poster[avatar]" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"Success: %@", responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
        
        
        NSLog(@"onOK");
        
        
    };
    
    
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];

}



- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];

}


- (UIImage *)image
{
    return self.imageView.image;
}


-(void)readNSUserDefaults
{
    //NSManagedObjectContext *context = [TWCoreDataHelper managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    [fetchRequest setFetchLimit:1];
    
    
    NSError *error = nil;
    
    NSArray *fetchedPhotos= [[TWCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    Photo * photo = [fetchedPhotos firstObject];
    self.imageurl = [NSURL URLWithString:photo.imageurl]  ;
    self.title = photo.name;
    
}


-(void)setImageurl:(NSURL *)imageurl{
    
    _imageurl = imageurl;
    [self startDownloadingImage];

}


- (void)startDownloadingImage
{
    self.image = nil;
    if (self.imageurl) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageurl];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.imageurl]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        self.image = image;
                                                                        [self.spinner stopAnimating];
                                                                    });
                                                                    //[self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    self.image =nil;

}


- (IBAction)addedPhoto:(UIStoryboardSegue *)segue
{
    
    
    if ([segue.sourceViewController isKindOfClass:[AddPhotoViewController class]]) {
        AddPhotoViewController *apvc = (AddPhotoViewController *)segue.sourceViewController;
        Photo *addedPhoto = apvc.addedPhoto;
        //self.image = addedPhoto.image;
        self.title = addedPhoto.name;
        
    }
    
    
    //[self readNSUserDefaults];
}

@end
