
#import "ConditionInteger32.h"

@interface FieldInteger32ToMany : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionInteger32 *)anyEqual:(int32_t)value;
- (ConditionInteger32 *)allEqual:(int32_t)value;
- (ConditionInteger32 *)noneEqual:(int32_t)value;

- (ConditionInteger32 *)anyMore:(int32_t)value;
- (ConditionInteger32 *)allMore:(int32_t)value;
- (ConditionInteger32 *)noneMore:(int32_t)value;

- (ConditionInteger32 *)anyMoreOrEqual:(int32_t)value;
- (ConditionInteger32 *)allMoreOrEqual:(int32_t)value;
- (ConditionInteger32 *)noneMoreOrEqual:(int32_t)value;

- (ConditionInteger32 *)anyLess:(int32_t)value;
- (ConditionInteger32 *)allLess:(int32_t)value;
- (ConditionInteger32 *)noneLess:(int32_t)value;

- (ConditionInteger32 *)anyLessOrEqual:(int32_t)value;
- (ConditionInteger32 *)allLessOrEqual:(int32_t)value;
- (ConditionInteger32 *)noneLessOrEqual:(int32_t)value;

@end