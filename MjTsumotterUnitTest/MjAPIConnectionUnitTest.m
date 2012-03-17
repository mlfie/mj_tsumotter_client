//
//  MjAPIConnectionUnitTest.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MjAPIConnectionUnitTest.h"
#import "MjAPIConnection.h"

@implementation MjAPIConnectionUnitTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_init
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"valid_sample" 
                                                          ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    
    MjAgari * agari = [[MjAgari alloc] init];
    agari.img = imgData;
    
    MjAPIConnection *con = [[MjAPIConnection alloc] init];
    [con sendAgari:agari delegate:nil];
}

@end
