//
//  Service.m
//  AsyncTestingApp
//
//  Created by David C. Thömmes on 10.08.14.
//  Copyright (c) 2014 dct. All rights reserved.
//

#import "Service.h"
#import "DownloadRSSOperation.h"

@implementation Service

@synthesize queue = _queue;

- (id)init
{
    if (self = [super init])
    {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void)downloadRSSWithCompletionBlock:(DownloadRSSCompletionBlock)block
{
    DownloadRSSOperation* operation = [[DownloadRSSOperation alloc] init];
    operation.url = @"http://www.davidchristian.de/index.php/blog/rss";
    
    __weak DownloadRSSOperation* weakOp = operation;
    
    [operation setCompletionBlock:^
    {
        NSLog(@"setCompletionBlock");
        
        if (weakOp.result != nil)
        {
            NSString* copy = [weakOp.result copy];
            
            // Always dispatch callbacks on main queue
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               // Copy string!!
                               block(YES, copy);
                           });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               block(NO, nil);
                           });
        }
    }];
    
    [_queue addOperation:operation];
}

+ (Service*)sharedService
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

@end
