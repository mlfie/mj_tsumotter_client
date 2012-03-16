//
//  AgariUnitTest.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AgariUnitTest.h"
#import "MjAgari.h"
#import "SBJson.h"

@implementation AgariUnitTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testToJSON
{
    MjAgari *agari = [[MjAgari alloc] init];
    agari.total_point = 1000;
    agari.total_fu_num = 20;
    NSString *json = [agari toJSON];
    NSLog(@"toJSON = %@", json);
}

@end
