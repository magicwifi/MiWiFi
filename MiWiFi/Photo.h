//
//  Photo.h
//  MiWiFi
//
//  Created by Huang Zhe on 14-12-20.
//  Copyright (c) 2014年 Huang Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;

@end
