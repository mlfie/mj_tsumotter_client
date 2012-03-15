//
//  Agari.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


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
@property (nonatomic, retain) NSSet *yaku;
@end

@interface Agari (CoreDataGeneratedAccessors)

- (void)addYakuObject:(NSManagedObject *)value;
- (void)removeYakuObject:(NSManagedObject *)value;
- (void)addYaku:(NSSet *)values;
- (void)removeYaku:(NSSet *)values;

@end
