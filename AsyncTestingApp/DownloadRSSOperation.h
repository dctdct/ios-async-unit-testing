//
//  DownloadRSSOperation.h
//  AsyncTestingApp
//
//  Created by David C. Thömmes on 10.08.14.
//  Copyright (c) 2014 dct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadRSSOperation : NSOperation

@property (atomic, strong) NSString* url;
@property (atomic, strong) NSString* result;

@end
