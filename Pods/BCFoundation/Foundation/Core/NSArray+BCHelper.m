//
//  NSArray+BCHelper.m
//  Pods
//
//  Created by Basic on 15/2/8.
//  Copyright (c) 2015年 Basic. All rights reserved.
//

#import "NSArray+BCHelper.h"
#import "NSDictionary+BCHelper.h"
#import "BCFoundationUtils.h"

@implementation NSArray (BCHelper)

#pragma mark - 去除null

-(NSMutableArray *)bc_removeNull
{
    NSMutableArray *marraySelf = nil;
    if([self isKindOfClass:[NSMutableArray class]] || [self isKindOfClass:[NSArray class]]){
        if([self isKindOfClass:[NSArray class]]){
            marraySelf = [[NSMutableArray alloc] initWithArray:self];
        }
        else{
            marraySelf = (NSMutableArray *)self;
        }
        for (NSInteger i=0; i<[marraySelf count]; i++) {
            NSDictionary *dictItem = marraySelf[i];
            dictItem = [dictItem bc_removeNull];
            [marraySelf replaceObjectAtIndex:i withObject:dictItem];
        }
    }
    return marraySelf;
}


- (NSString *)bc_toJson
{
    if(self.count<=0){
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if(!jsonData || error){
        BCLogs(@"err:%@",[error description]);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n  " withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

- (id)bc_safeObjectAtIndex:(NSUInteger)idx {
    if (idx <self.count) {
        return self[idx];
    }else{
        return nil;
    }
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (BCHelper)
-(void)bc_addObject:(id)anObject
{
    if(anObject!=nil) {
        [self addObject:anObject];
    }
}
@end



#pragma --mark NSOrderedSet setter
@implementation NSOrderedSet (BCHelper)
- (id)bc_safeObjectAtIndex:(NSUInteger)idx {
    if (idx <self.count) {
        return self[idx];
    }else{
        return nil;
    }
}
@end
