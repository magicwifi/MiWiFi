//
//  TWPhotosCollectionViewController.m
//  Thousand Words
//
//  Created by Eliot Arntz on 11/14/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "TWPhotosCollectionViewController.h"
#import "TWPhotoCollectionViewCell.h"
#import "Photo.h"
#import "TWCoreDataHelper.h"
#import "ImageViewController.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"

@interface TWPhotosCollectionViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *photos; // Of UIImages
//@property (strong, nonatomic) NSURL *imageurl;


@end

@implementation TWPhotosCollectionViewController

/* Lazy Instantiation */
- (NSMutableArray *)photos
{
    if (!_photos){
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/* Access the photos from Core Data in the viewWillAppear method since this method is called everytime this viewcontroller appears on the screen instead of only the first time (viewDidLoad only is called only when it is created) */
-(void)viewWillAppear:(BOOL)animated
{
    /* Call to the super classes implementation of viewWillAppear */
    [super viewWillAppear:YES];
    
    /* The Photos are stored in Core Data as an NSSet. */
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    
    NSError *error = nil;
    
    NSArray *sortedPhotos= [[TWCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.photos = [sortedPhotos mutableCopy];
    
    /* Now that the photos are arranged we reload our CollectionView. */
    [self.collectionView reloadData];
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldFlatFontOfSize:18],
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UICollectionViewDataSource

/* Display the photos stored in the photo's array */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    
    TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    /* Access the correct photo from the photo's array */
    Photo *photo = self.photos[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageurl = [NSURL URLWithString:photo.imageurl ];
    //cell.imageView.image = photo.image;
    
 
    
    
    return cell;
}

/* Number of items in the collection view should be equal to the number of photos in the photos array */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}



- (IBAction)cameraPress:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    /*
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }*/
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    }
    
    [self presentViewController:picker animated:YES completion:nil];

    
}




- (NSURL *)uniqueDocumentURL
{
    NSArray *documentDirectories = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSString *unique = [NSString stringWithFormat:@"%.0f", floor([NSDate timeIntervalSinceReferenceDate])];
 
    return [[documentDirectories firstObject] URLByAppendingPathComponent:unique];
  
}
/*
-(NSURL *)imageurl{
    
    if (!_imageurl && self.image) {
        NSURL *url = [self uniqueDocumentURL];
        if (url) {
            NSData *imageData = UIImageJPEGRepresentation(self.image, 1.0);
            if ([imageData writeToURL:url atomically:YES]) {
                _imageurl = url;
                NSLog(@"imageurl %@",_imageurl);
            }
        }
    }
    
    NSLog(@"imageurl NO");
    return _imageurl;

}
*/




- (Photo *)photoFromImage:(UIImage *)image
{
    /* Create a photo object using the method insertNewObjectForEntityForName for the entity name Photo */
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[TWCoreDataHelper managedObjectContext]];
    /* Set the photo's attributes */
    //photo.image = image;
   
    NSURL *url = [self uniqueDocumentURL];
    if (url) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        if ([imageData writeToURL:url atomically:YES]) {
            photo.imageurl = [url absoluteString];
            
        }
    }
    
    //NSLog(@"%@",[self.imageurl absoluteString]);

    photo.date = [NSDate date];
    //photo.albumBook = self.album;
    photo.name = @"Portal";
    NSError *error = nil;
    /* Save the photo, the if statement evaluates to true if there is an error */
    if (![[photo managedObjectContext] save:&error]){
        //Error in saving
        NSLog(@"%@", error);
    }
    return photo;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    
 

    
    
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
  
    //self.image = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/* If the user presses cancel dismiss the ImagePickerController */
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /* Confirm that the correct segue is being triggered */
    if ([segue.identifier isEqualToString:@"Detail Segue"])
    {
        /* Confirm that the correct View Controller is being transitioned to */
        if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
            
            ImageViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
            /* Access the photo that was tapped and set the property of the target ViewController */
            Photo *selectedPhoto = self.photos[indexPath.row];
            targetViewController.imageurl = [NSURL URLWithString:selectedPhoto.imageurl ];
            targetViewController.title = selectedPhoto.name;
            
        }
    }
}



@end
