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
{
    BOOL isRun;
}

- (void)setUp
{
    [super setUp];
    isRun = NO;
    agari = [[MjAgari alloc] init];
}

- (void)tearDown
{
    [agari release];
    while (isRun) {}
    
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

- (void)test_MjAgari_fromJSON
{
    NSString *json = @"{ \
    \"agari\":{ \
      \"total_fu_num\":20, \
      \"is_furo\":true, \
      \"mangan_scale\":1.5, \
      \"tehai_list\":\"m1t\", \
      \"yaku_list\":[ \
        {\"name\":\"pinfu\", \
        \"han_num\":1, \
        \"naki_han_num\":0} \
    ]}}";
    
    STAssertTrue([agari fromJSON:json], @"fromJSON should return true when passing valid json string");
    
    STAssertEquals(agari.total_fu_num, 20, @"fromJSON should assign integer value");
    STAssertTrue(agari.is_furo, @"fromJSON should assign boolean value");
    STAssertEquals(agari.mangan_scale, 1.5F, @"fromJSON should assign float value");
    STAssertEqualObjects(agari.tehai_list, @"m1t", @"fromJSON should assign string value");

    NSMutableDictionary *yaku = [NSMutableDictionary dictionary];
    [yaku setValue:@"pinfu" forKey:@"name"];
    [yaku setValue:[NSNumber numberWithInt:1] forKey:@"han_num"];
    [yaku setValue:[NSNumber numberWithInt:0] forKey:@"naki_han_num"];
    NSArray *yaku_list = [NSArray arrayWithObject:yaku];
    STAssertEqualObjects(agari.yaku_list, yaku_list, @"fromJSON should assign dictionary value");
    
    NSString *invalid = @"invalid";
    STAssertFalse([agari fromJSON:invalid], @"fromJSON should return false when passing invalid json string");
    
    NSString *undefined_key = @"{\"agari\":{\"undefined\":0}}";
    STAssertFalse([agari fromJSON:undefined_key], @"fromJSON should return false when passing undefined key");
}

- (void)test_sendAgari
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *imagePath = [bundle pathForResource:@"valid_sample" 
                                                          ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    
    agari.img = imgData;
    
    isRun = YES;
    
    MjAPIConnection *con = [[MjAPIConnection alloc] init];
    [con sendAgari:agari withHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString, NSError *error) {
        NSLog(@"response = %@", responseString);
        isRun = NO;
    }];
}

@end
