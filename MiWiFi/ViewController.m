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
#import "UIPopoverController+FlatUI.h"

@interface ViewController ()<FUIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *image;


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
    
    
    if (!self.image) {
        [self readNSUserDefaults];
    }

 
    
    
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
    
    
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Hello" message:@"This is an alert view" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Do Something", nil];
    alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
    [@[[alertView textFieldAtIndex:0], [alertView textFieldAtIndex:1]] enumerateObjectsUsingBlock:^(FUITextField *textField, NSUInteger idx, BOOL *stop) {
        [textField setTextFieldColor:[UIColor cloudsColor]];
        [textField setBorderColor:[UIColor asbestosColor]];
        [textField setCornerRadius:4];
        [textField setFont:[UIFont flatFontOfSize:14]];
        [textField setTextColor:[UIColor midnightBlueColor]];
    }];
    [[alertView textFieldAtIndex:0] setPlaceholder:@"Text here!"];
    
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
    //[self.spinner stopAnimating];
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
    self.image = photo.image;
    self.title = photo.name;
    
}


- (IBAction)addedPhoto:(UIStoryboardSegue *)segue
{
    
    
    if ([segue.sourceViewController isKindOfClass:[AddPhotoViewController class]]) {
        AddPhotoViewController *apvc = (AddPhotoViewController *)segue.sourceViewController;
        Photo *addedPhoto = apvc.addedPhoto;
        self.image = addedPhoto.image;
        self.title = addedPhoto.name;
        
    }
    
    
    //[self readNSUserDefaults];
}

@end
