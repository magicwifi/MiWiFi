//
//  TWPhotoCollectionViewCell.m
//  Thousand Words
//
//  Created by Eliot Arntz on 11/14/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "TWPhotoCollectionViewCell.h"
#define IMAGEVIEW_BORDER_LENGTH 5

@implementation TWPhotoCollectionViewCell



/* In case we ever create a TWPhotoCell in code make sure to call the setup method */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

/* Need to implement the initWithCoder method since this class will be created from the storyboard */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self){
        [self setup];
    }
    return self;
}

/* Create the UIImageView and add it to the cell's contentView in code. */
-(void)setup
{
    

    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    
    [self.imageView setClipsToBounds:YES];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
  
    [self.contentView addSubview:self.imageView];
    
    
    
}

-(void)setImageurl:(NSURL *)imageurl{
    
    _imageurl = imageurl;
    [self startDownloadingImage];
    
}


- (void)startDownloadingImage
{
    //self.image = nil;
  
    if (self.imageurl) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageurl];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.imageurl]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        self.imageView.image = image;
                                                                 
                                                                    });
                                                                    //[self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
