
#import "ConditionInteger64.h"

@interface FieldInteger64 : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionInteger64 *)anyEqual:(int64_t)value;
- (ConditionInteger64 *)allEqual:(int64_t)value;
- (ConditionInteger64 *)noneEqual:(int64_t)value;

- (ConditionInteger64 *)anyMore:(int64_t)value;
- (ConditionInteger64 *)allMore:(int64_t)value;
- (ConditionInteger64 *)noneMore:(int64_t)value;

- (ConditionInteger64 *)anyMoreOrEqual:(int64_t)value;
- (ConditionInteger64 *)allMoreOrEqual:(int64_t)value;
- (ConditionInteger64 *)noneMoreOrEqual:(int64_t)value;

- (ConditionInteger64 *)anyLess:(int64_t)value;
- (ConditionInteger64 *)allLess:(int64_t)value;
- (ConditionInteger64 *)noneLess:(int64_t)value;

- (ConditionInteger64 *)anyLessOrEqual:(int64_t)value;
- (ConditionInteger64 *)allLessOrEqual:(int64_t)value;
- (ConditionInteger64 *)noneLessOrEqual:(int64_t)value;

@end