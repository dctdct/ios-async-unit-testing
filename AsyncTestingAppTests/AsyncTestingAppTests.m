//
//  AsyncTestingAppTests.m
//  AsyncTestingAppTests
//
//  Created by David C. Thömmes on 10.08.14.
//  Copyright (c) 2014 dct. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Service.h"
#import "DownloadRSSOperation.h"

@interface AsyncTestingAppTests : XCTestCase

@end

@implementation AsyncTestingAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDownloadRSS
{
    // Arrange
    __block bool running = true;
    
    // Timeout
    NSDate* methodStart = [NSDate date];
    
    // Act
    [[Service sharedService] downloadRSSWithCompletionBlock:^(BOOL success, NSString* result)
     {
         if (success)
         {
             NSLog(@"Download result > %@", result);
             XCTAssertTrue([result length] > 0, @"Download");
         }
         else
         {
             NSLog(@"Download failed!");
             XCTAssertTrue(false, @"Download failed");
         }
         
         running = false;
     }];
    
    //while (running && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    while (running && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
    {
        // Timeout if the callback will not be called...
        NSTimeInterval executionTime = [[NSDate date] timeIntervalSinceDate:methodStart];
        
        NSLog(@"Time %F", executionTime);
        
        if (executionTime > 3)
        {
            XCTAssertTrue(false, @"downloadRSSWithCompletionBlock - Timeout");
            running = false;
        }
    }
    
    // Old and not working cuz waitUntilAllOperationsAreFinished will be called before our callback block will be called! You need to reimplement this mechanism.
    //[[[Service sharedService] queue] waitUntilAllOperationsAreFinished];
    // https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/testing_with_xcode/testing_3_writing_test_classes/testing_3_writing_test_classes.html
    //[self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
}

- (void)testDownloadRSS_8
{
    // Arrange
    XCTestExpectation* expectation = [self expectationWithDescription:@"Download RSS"];
    
    // Act
    [[Service sharedService] downloadRSSWithCompletionBlock:^(BOOL success, NSString* result)
     {
         [expectation fulfill];
         
         if (success)
         {
             NSLog(@"Download result > %@", result);
             XCTAssertTrue([result length] > 0, @"Download");
         }
         else
         {
             NSLog(@"Download failed!");
             XCTAssertTrue(false, @"Download failed");
         }
     }];
    
    // iOS 8
    [self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error)
     {
         NSLog(@"Time %@", error);
     }];
}

- (void)testDownloadRSSOperationAlone
{
    // Arrange
    DownloadRSSOperation* operation = [[DownloadRSSOperation alloc] init];
    operation.url = @"http://www.davidchristian.de/index.php/blog/rss";
    
    // Act
    [operation main];
    
    // Assert
    XCTAssertTrue(operation.result != nil && [operation.result length] > 0, @"Download");
}

@end
