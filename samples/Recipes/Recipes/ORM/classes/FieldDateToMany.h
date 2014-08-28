
#import "ConditionDate.h"

@interface FieldDateToMany : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionDate *)anyEqual:(NSDate *)value;
- (ConditionDate *)allEqual:(NSDate *)value;
- (ConditionDate *)noneEqual:(NSDate *)value;
- (ConditionDate *)anyMore:(NSDate *)value;
- (ConditionDate *)allMore:(NSDate *)value;
- (ConditionDate *)noneMore:(NSDate *)value;
- (ConditionDate *)anyMoreOrEqual:(NSDate *)value;
- (ConditionDate *)allMoreOrEqual:(NSDate *)value;
- (ConditionDate *)noneMoreOrEqual:(NSDate *)value;
- (ConditionDate *)anyLess:(NSDate *)value;
- (ConditionDate *)allLess:(NSDate *)value;
- (ConditionDate *)noneLess:(NSDate *)value;
- (ConditionDate *)anyLessOrEqual:(NSDate *)value;
- (ConditionDate *)allLessOrEqual:(NSDate *)value;
- (ConditionDate *)noneLessOrEqual:(NSDate *)value;
- (ConditionDate *)anyNull;
- (ConditionDate *)allNull;
- (ConditionDate *)noneNull;

@end