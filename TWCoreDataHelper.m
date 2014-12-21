//
//  TWCoreDataHelper.m
//  Thousand Words
//
//  Created by Eliot Arntz on 11/14/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "TWCoreDataHelper.h"

@implementation TWCoreDataHelper

/* Class method which first gets a variable that points to an instance of our App Delegate. Using this instance we get the NSManagedObjectContext for our application. */
+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end
