//
//  TehaiView.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TehaiView.h"

@implementation TehaiView
{
    NSString *tehaiString;
    NSMutableArray *tehaiImages;
}

@synthesize tehaiString, tehaiImages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        tehaiImages = [[NSMutableArray array] retain];
        tehaiString = @"";
    }
    return self;
}

- (void)dealloc
{
    [tehaiImages release];
    [tehaiString release];
    
    [super dealloc];
}

- (UIImage *)loadPaiImageForKey:(NSString *)key
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:key ofType:@"gif"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

- (NSArray *)arrayBySplitString:(NSString *)str
{
    NSMutableArray *array = [NSMutableArray array];
    
    int len = 3;
    for (int i = 0; i + len <= [str length]; i += len) {
        NSRange range = NSMakeRange(i, len);
        [array addObject:[str substringWithRange:range]];
    }
    
    return array;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSArray *tehais = [self arrayBySplitString:tehaiString];
    
    NSMutableArray *newTehaiImages = [NSMutableArray array];
    for (NSString *tehai in tehais) {
        UIImage *img = [self loadPaiImageForKey:tehai];
        
        [newTehaiImages addObject:img];        
    }
    
    self.tehaiImages = newTehaiImages;

    
    for (int i = 0; i < [tehaiImages count]; i++) {
        UIImage *img = [self.tehaiImages objectAtIndex:i];
        CGRect imgRect;
        imgRect.size = img.size;
        imgRect.origin.x = i * img.size.width;
        
        [img drawInRect:imgRect];
    }
}

@end
