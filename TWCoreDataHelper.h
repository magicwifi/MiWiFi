//
//  TWCoreDataHelper.h
//  Thousand Words
//
//  Created by Eliot Arntz on 11/14/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface TWCoreDataHelper : NSObject

/* Helper method which returns an NSManagedObjectContext object from our App Delegate */
+(NSManagedObjectContext *)managedObjectContext;

@end
