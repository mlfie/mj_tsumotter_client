//
//  MjTsumotterUnitTest.m
//  MjTsumotterUnitTest
//
//  Created by 寺師 佳彦 on 12/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MjTsumotterUnitTest.h"

@implementation MjTsumotterUnitTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSString *str       = @"サンプル";
    STAssertEquals(str, @"サンプル", @"サンプルが一致しません。");
}

@end
