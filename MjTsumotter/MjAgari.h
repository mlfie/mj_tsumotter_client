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
    NSString * bakaze;
    NSString * jikaze;
    NSInteger honba_num;
    NSInteger dora_num;
    NSInteger reach_num;
    BOOL is_tsumo;
    BOOL is_parent;
    BOOL is_ippatsu;
    BOOL is_haitei;
    BOOL is_rinshan;
    BOOL is_chankan;
    BOOL is_tenho;
    BOOL is_chiho;

    NSInteger total_fu_num;
    NSInteger total_han_num;
    NSInteger child_point;
    NSInteger parent_point;
    NSInteger ron_point;
    NSInteger total_point;
    Float32 mangan_scale;
    BOOL is_furo;
    NSString * tehai_list;
    NSDictionary *yaku_list;
}

@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSString * bakaze;
@property (nonatomic, retain) NSString * jikaze;
@property NSInteger honba_num;
@property NSInteger dora_num;
@property NSInteger reach_num;
@property (nonatomic) BOOL is_tsumo;
@property (nonatomic) BOOL is_parent;
@property (nonatomic) BOOL is_ippatsu;
@property (nonatomic) BOOL is_haitei;
@property (nonatomic) BOOL is_rinshan;
@property (nonatomic) BOOL is_chankan;
@property (nonatomic) BOOL is_tenho;
@property (nonatomic) BOOL is_chiho;

@property NSInteger total_fu_num;
@property NSInteger total_han_num;
@property NSInteger child_point;
@property NSInteger parent_point;
@property NSInteger ron_point;
@property NSInteger total_point;
@property Float32 mangan_scale;
@property (nonatomic) BOOL is_furo;
@property (nonatomic, retain) NSString *tehai_list;
@property (nonatomic, retain) NSDictionary *yaku_list;


- (NSString *)toJSON;
- (BOOL)fromJSON:(NSString *)json;

@end
