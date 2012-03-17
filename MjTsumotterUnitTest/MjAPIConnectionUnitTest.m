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
    agari = [[MjAgari alloc] init];
}

- (void)tearDown
{
    [agari release];
    [super tearDown];
}

- (void)test_MjAgari_toJSON
{
    agari.bakaze = @"ton";
    agari.jikaze = @"nan";
    agari.honba_num = 0;
    agari.dora_num = 2;
    agari.reach_num = 1;
    
    agari.is_furo = YES;
    agari.is_tsumo = NO;
    
    NSString *json = agari.toJSON;

    STAssertFalse([json rangeOfString:@"\"agari\":"].location == NSNotFound,
                  @"agari is not include in json correctly");    
    STAssertFalse([json rangeOfString:@"\"bakaze\":\"ton\""].location == NSNotFound,
                  @"bakaze is not include in json correctly");
    STAssertFalse([json rangeOfString:@"\"jikaze\":\"nan\""].location == NSNotFound,
                  @"jikaze is not include in json correctly");
    STAssertFalse([json rangeOfString:@"\"honba_num\":0"].location == NSNotFound,
                  @"honba_num is not include in json correctly");
    STAssertFalse([json rangeOfString:@"\"dora_num\":2"].location == NSNotFound,
                  @"dora_num is not include in json correctly");
    STAssertFalse([json rangeOfString:@"\"reach_num\":1"].location == NSNotFound,
                  @"reach_num is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_tsumo\":false"].location == NSNotFound,
                  @"is_tsumo is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_ippatsu\":false"].location == NSNotFound,
                  @"is_ippatsu is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_haitei\":false"].location == NSNotFound,
                  @"is_haitei is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_rinshan\":false"].location == NSNotFound,
                  @"is_rinshan is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_chankan\":false"].location == NSNotFound,
                  @"is_tsumo is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_tenho\":false"].location == NSNotFound,
                  @"is_tenho is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_chiho\":false"].location == NSNotFound,
                  @"is_chiho is not include in json correctly");
    
    STAssertFalse([json rangeOfString:@"\"is_parent\":false"].location == NSNotFound,
                  @"is_parent is not include in json correctly");
    
    
    NSLog(@"json = %@", json);
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
