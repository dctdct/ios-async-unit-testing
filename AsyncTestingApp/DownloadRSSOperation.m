//
//  DownloadRSSOperation.m
//  AsyncTestingApp
//
//  Created by David C. Thömmes on 10.08.14.
//  Copyright (c) 2014 dct. All rights reserved.
//

#import "DownloadRSSOperation.h"

@implementation DownloadRSSOperation

@synthesize url = _url;
@synthesize result = _result;

- (void)main
{
    _result = nil;
    
    // Start sync download
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];

    // Sleep
    [NSThread sleepForTimeInterval:1.0f];
    
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (error == nil)
    {
        // Danger!
        _result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
}

/*- (void)main
{
    _result = nil;
    
    // Start sync download
    NSString* response = [DownloadURL downloadURLAsString:_url];
    
    // Parse
    _result = [XMLFeedParser parse:response];
    
    // Save
    bool = [FeedDatabase updateFeed:_result];
    
    ...
}*/

@end

