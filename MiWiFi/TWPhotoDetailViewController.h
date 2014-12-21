//
//  TWPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Eliot Arntz on 11/22/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>

/* Example of class forwarding. Allows us to create a property using the class Photo but we do not know what else is in the Photo header file. */
@class Photo;

@interface TWPhotoDetailViewController : UIViewController

/* A property of class Photo so that we can pass the selected photo object to this viewcontroller. */
@property (strong, nonatomic) Photo *photo;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;

@end
