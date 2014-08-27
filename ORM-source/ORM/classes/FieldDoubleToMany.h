
#import "ConditionDouble.h"

@interface FieldDouble : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionDouble *)anyEqual:(double)value;
- (ConditionDouble *)allEqual:(double)value;
- (ConditionDouble *)noneEqual:(double)value;

- (ConditionDouble *)anyMore:(double)value;
- (ConditionDouble *)allMore:(double)value;
- (ConditionDouble *)noneMore:(double)value;

- (ConditionDouble *)anyMoreOrEqual:(double)value;
- (ConditionDouble *)allMoreOrEqual:(double)value;
- (ConditionDouble *)noneMoreOrEqual:(double)value;

- (ConditionDouble *)anyLess:(double)value;
- (ConditionDouble *)allLess:(double)value;
- (ConditionDouble *)noneLess:(double)value;

- (ConditionDouble *)anyLessOrEqual:(double)value;
- (ConditionDouble *)allLessOrEqual:(double)value;
- (ConditionDouble *)noneLessOrEqual:(double)value;

@end