//
//  Service.h
//  AsyncTestingApp
//
//  Created by David C. Thömmes on 10.08.14.
//  Copyright (c) 2014 dct. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DownloadRSSCompletionBlock) (BOOL success, NSString* result);

@interface Service : NSObject

@property (nonatomic, strong) NSOperationQueue* queue;

- (id)init;
- (void)downloadRSSWithCompletionBlock:(DownloadRSSCompletionBlock)block;

+ (Service*)sharedService;

@end
