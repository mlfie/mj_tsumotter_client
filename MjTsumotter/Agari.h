//
//  Agari.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MjAgari.h"

@class Yaku;

@interface Agari : NSManagedObject

@property (nonatomic, retain) NSString * bakaze;
@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSDecimalNumber * dora_num;
@property (nonatomic, retain) NSDecimalNumber * honba_num;
@property (nonatomic, retain) NSData * img;
@property (nonatomic) BOOL is_chankan;
@property (nonatomic) BOOL is_chiho;
@property (nonatomic) BOOL is_furo;
@property (nonatomic) BOOL is_haitei;
@property (nonatomic) BOOL is_ippatsu;
@property (nonatomic) BOOL is_parent;
@property (nonatomic) BOOL is_rinshan;
@property (nonatomic) BOOL is_tenho;
@property (nonatomic) BOOL is_tsumo;
@property (nonatomic, retain) NSString * jikaze;
@property (nonatomic, retain) NSDecimalNumber * mangan_scale;
@property (nonatomic, retain) NSDecimalNumber * reach_num;
@property (nonatomic, retain) NSString * tehai_list;
@property (nonatomic, retain) NSDecimalNumber * total_fu_num;
@property (nonatomic, retain) NSDecimalNumber * total_han_num;
@property (nonatomic, retain) NSDecimalNumber * total_point;
@property (nonatomic, retain) NSDecimalNumber * child_point;
@property (nonatomic, retain) NSDecimalNumber * parent_point;
@property (nonatomic, retain) NSDecimalNumber * ron_point;
@property (nonatomic, retain) NSSet *yakus;
@end

@interface Agari (CoreDataGeneratedAccessors)

- (void)addYakusObject:(Yaku *)value;
- (void)removeYakusObject:(Yaku *)value;
- (void)addYakus:(NSSet *)values;
- (void)removeYakus:(NSSet *)values;

- (void)fromMjAgari:(MjAgari *)mjAgari;

@end
