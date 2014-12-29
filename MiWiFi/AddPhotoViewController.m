//
//  AddPhotoViewController.m
//  Photomania
//
//  Created by Huang Zhe on 14-9-21.
//  Copyright (c) 2014年 Huang Zhe. All rights reserved.
//

#import "AddPhotoViewController.h"
#import "FUITextField.h"
#import "ViewController.h"
#import  "Photo.h"
#import  "TWCoreDataHelper.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"

#import "UIBarButtonItem+FlatUI.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddPhotoViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet UILabel *longLabel;

@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *longText;
@property (weak, nonatomic) IBOutlet UILabel *latText;


@property (strong, nonatomic) NSURL *imageurl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong) UIImage *image;
@property (strong,readwrite) Photo *addedPhoto;
@property (weak, nonatomic) IBOutlet FUIButton *takePhotoButton;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSInteger locationErrorCode;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AddPhotoViewController

#define ALERT_ADD_TITLE NSLocalizedStringFromTable(@"ALERT_ADD_TITLE",@"AddPhotoViewController", @"Title of Filter Image action sheet.")


-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

-(void)setImage:(UIImage *)image{
    
    self.imageView.image = image;
    
    [[NSFileManager defaultManager] removeItemAtURL:_imageurl error:NULL];
    self.imageurl = nil;
    
}

-(void)cancel{
    self.image =nil;
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *uipc = [[UIImagePickerController alloc]init];
    uipc.delegate =self;
    //uipc.mediaTypes = @[(NSString *)kUTTypeImage];
    uipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    //uipc.allowsEditing = YES;
    [self presentViewController:uipc animated:YES completion:NULL];
    
}


-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.titleLabel.font = [UIFont flatFontOfSize:20];
    self.titleLabel.textColor = [UIColor turquoiseColor];
    
    self.longLabel.font = [UIFont flatFontOfSize:20];
    self.longLabel.textColor = [UIColor turquoiseColor];
    self.latText.font = [UIFont flatFontOfSize:20];
    self.latText.textColor = [UIColor turquoiseColor];
    
    self.longText.font = [UIFont flatFontOfSize:20];
    self.longText.textColor = [UIColor turquoiseColor];
    self.latLabel.font = [UIFont flatFontOfSize:20];
    self.latLabel.textColor = [UIColor turquoiseColor];
    
    //self.image = [UIImage imageNamed:@"flower.jpg"];
    
    
    
    self.takePhotoButton.buttonColor = [UIColor turquoiseColor];
    self.takePhotoButton.shadowColor = [UIColor greenSeaColor];
    self.takePhotoButton.shadowHeight = 3.0f;
    self.takePhotoButton.cornerRadius = 6.0f;
    self.takePhotoButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.takePhotoButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.takePhotoButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    

 
    
    NSDictionary *attrs = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UIBarItem appearance] setTitleTextAttributes:attrs
                                          forState:UIControlStateNormal];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationBar class], nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cancel)];
    [self.navigationItem.rightBarButtonItem removeTitleShadow];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(done)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    [self.navigationItem.leftBarButtonItem removeTitleShadow];
    
    [self.navigationItem.leftBarButtonItem configureFlatButtonWithColor:[UIColor alizarinColor]
                                                       highlightedColor:[UIColor pomegranateColor]
                                                           cornerRadius:3];
     
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
                                                                        NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];


}


- (NSURL *)uniqueDocumentURL
{
    NSArray *documentDirectories = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSString *unique = [NSString stringWithFormat:@"%.0f", floor([NSDate timeIntervalSinceReferenceDate])];
    return [[documentDirectories firstObject] URLByAppendingPathComponent:unique];
}


-(NSURL *)imageurl{
    if (!_imageurl && self.image) {
        NSURL *url = [self uniqueDocumentURL];
        if (url) {
            NSData *imageData = UIImageJPEGRepresentation(self.image, 0.1);
            if ([imageData writeToURL:url atomically:YES]) {
                _imageurl = url;
            }
        }
    }
    return _imageurl;

}


-(UIImage *)image{

    return self.imageView.image;

}

#define UNWINED_SEGUE_IDENTIFIER @"Do Add Photo"


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:UNWINED_SEGUE_IDENTIFIER]){
    //Photo *photo = [self returnPhoto];
    
    Photo *photo = [self photoFromImage:self.image];
        
     self.addedPhoto = photo;
    }
}



-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if ([identifier isEqualToString:UNWINED_SEGUE_IDENTIFIER]) {
        if (!self.image) {
            [self alert:@"NO Photo Taken"];
            return NO;
        }else if(![self.titleTextField.text length]){
            [self alert:ALERT_ADD_TITLE];
            return NO;
        }
        else{
        
            return YES;
        }
    }else{
    
        return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    
    }
    
    
}

-(void)done{
    
    if (!self.image) {
        [self alert:@"NO Photo Taken"];
    }else if(![self.titleTextField.text length]){
        [self alert:ALERT_ADD_TITLE];

    }
    else{
        
        [self photoFromImage:self.image];
        self.imageurl = nil;
        //self.addedPhoto = photo;
        [self.navigationController popViewControllerAnimated:YES];
    }

    

}




-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    self.image = image;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    

}

+ (BOOL)canAddPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([availableMediaTypes containsObject:(NSString *)kUTTypeImage]) {
            if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted) {
                 NSLog(@"cantakephoto success");
                return YES;
                
            }
        }
    }
     NSLog(@"cantakephoto fail");
    return NO;
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
  
    
    if (![[self class] canAddPhoto]) {
        [self fatalAlert:@"Sorry you don't have camera device!"];
        
    }else{
    
     if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization begin");
        [self requestAlwaysAuthorization];
    }
        
        [self.locationManager startUpdatingLocation];
    
        NSLog(@" init begin");
        [self.locationManager addObserver:self forKeyPath:@"location" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial )  context:NULL];
        
        //self.longText.text =[ @(self.location.coordinate.longitude) stringValue];
        //self.latText.text = [ @(self.location.coordinate.latitude) stringValue];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (object == self.locationManager) {
        
       if ([keyPath isEqualToString:@"location"]) {
            CLLocation *newLocation = (CLLocation *)[change objectForKey:NSKeyValueChangeNewKey];
            
            if (![newLocation isEqual:[NSNull null]]) {
                self.latText.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
                self.longText.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
            } else {
                self.latText.text = @"Unknown";
                self.longText.text = @"Unknown";
            }
        }
        
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)dealloc{
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
    [self.locationManager removeObserver:self forKeyPath:@"location"];
    
}



-(void)alert:(NSString *)msg{

    [[[UIAlertView alloc] initWithTitle:@"Add Photo" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

}

-(void)fatalAlert:(NSString *)msg{
    
     [[[UIAlertView alloc] initWithTitle:@"Add Photo" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self cancel];
}


- (Photo *)photoFromImage:(UIImage *)image
{
    /* Create a photo object using the method insertNewObjectForEntityForName for the entity name Photo */
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[TWCoreDataHelper managedObjectContext]];
    /* Set the photo's attributes */
 
    
    photo.imageurl = [self.imageurl absoluteString];
    
    photo.name = self.titleTextField.text;
    photo.date = [NSDate date];
    //photo.albumBook = self.album;
    
    NSError *error = nil;
    /* Save the photo, the if statement evaluates to true if there is an error */
    if (![[photo managedObjectContext] save:&error]){
        //Error in saving
        NSLog(@"%@", error);
    }
    return photo;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager = locationManager;
        NSLog(@"locationManager init success");
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.locationErrorCode = error.code;
}


- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
           NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse success");
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"kCLAuthorizationStatusNotDetermined success");

        [self.locationManager requestAlwaysAuthorization];
    }else{
        NSLog(@"requestAlwaysAuthorization success");
    
    }
    
    
    
}


@end
