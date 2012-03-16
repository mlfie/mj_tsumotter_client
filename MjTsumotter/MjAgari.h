//
//  DummyAgari.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MjAgari : NSObject
{
    NSData * img;
    NSInteger total_point;
    NSInteger total_fu_num;
    NSInteger *total_han_num;
    NSInteger *mangan_scale;
    NSString * bakaze;
    NSString * jikaze;
    NSInteger *honba_num;
    BOOL is_tsumo;
    BOOL is_parent;
    BOOL is_furo;
    NSString * tehai_list;
    NSInteger *dora_num;
    NSInteger *reach_num;
    BOOL is_ippatsu;
    BOOL is_haitei;
    BOOL is_rinshan;
    BOOL is_chankan;
    BOOL is_tenho;
    BOOL is_chiho;
}

@property (nonatomic, retain) NSData * img;
@property NSInteger total_point;
@property NSInteger total_fu_num;
@property NSInteger *total_han_num;
@property NSInteger *mangan_scale;
@property (nonatomic, retain) NSString * bakaze;
@property (nonatomic, retain) NSString * jikaze;
@property NSInteger *honba_num;
@property (nonatomic) BOOL is_tsumo;
@property (nonatomic) BOOL is_parent;
@property (nonatomic) BOOL is_furo;
@property (nonatomic, retain) NSString * tehai_list;
@property NSInteger * dora_num;
@property NSInteger * reach_num;
@property (nonatomic) BOOL is_ippatsu;
@property (nonatomic) BOOL is_haitei;
@property (nonatomic) BOOL is_rinshan;
@property (nonatomic) BOOL is_chankan;
@property (nonatomic) BOOL is_tenho;
@property (nonatomic) BOOL is_chiho;

- (NSString *)toJSON;

@end
