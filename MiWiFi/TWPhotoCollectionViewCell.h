//
//  TWPhotoCollectionViewCell.h
//  Thousand Words
//
//  Created by Eliot Arntz on 11/14/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWPhotoCollectionViewCell : UICollectionViewCell

/* So that we can add a UIImageView to our cells */
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSURL *imageurl;




@end
