//
//  Agari.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Yaku;

@interface Agari : NSManagedObject

@property (nonatomic, retain) NSData * img;
@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSDecimalNumber * total_point;
@property (nonatomic, retain) NSDecimalNumber * total_fu_num;
@property (nonatomic, retain) NSDecimalNumber * total_han_num;
@property (nonatomic, retain) NSDecimalNumber * mangan_scale;
@property (nonatomic, retain) NSString * bakaze;
@property (nonatomic, retain) NSString * jikaze;
@property (nonatomic, retain) NSDecimalNumber * honba_num;
@property (nonatomic) BOOL is_tsumo;
@property (nonatomic) BOOL is_parent;
@property (nonatomic) BOOL is_furo;
@property (nonatomic, retain) NSString * tehai_list;
@property (nonatomic, retain) NSDecimalNumber * dora_num;
@property (nonatomic, retain) NSDecimalNumber * reach_num;
@property (nonatomic) BOOL is_ippatsu;
@property (nonatomic) BOOL is_haitei;
@property (nonatomic) BOOL is_rinshan;
@property (nonatomic) BOOL is_chankan;
@property (nonatomic) BOOL is_tenho;
@property (nonatomic) BOOL is_chiho;
@property (nonatomic, retain) NSSet *yaku;
@end

@interface Agari (CoreDataGeneratedAccessors)

- (void)addYakuObject:(Yaku *)value;
- (void)removeYakuObject:(Yaku *)value;
- (void)addYaku:(NSSet *)values;
- (void)removeYaku:(NSSet *)values;

@end
