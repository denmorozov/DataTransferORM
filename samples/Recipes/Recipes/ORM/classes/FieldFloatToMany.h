
#import "ConditionFloat.h"

@interface FieldFloatToMany : NSObject

- (instancetype)initWithName:(NSString *)name;

- (ConditionFloat *)anyEqual:(CGFloat)value;
- (ConditionFloat *)allEqual:(CGFloat)value;
- (ConditionFloat *)noneEqual:(CGFloat)value;

- (ConditionFloat *)anyMore:(CGFloat)value;
- (ConditionFloat *)allMore:(CGFloat)value;
- (ConditionFloat *)noneMore:(CGFloat)value;

- (ConditionFloat *)anyMoreOrEqual:(CGFloat)value;
- (ConditionFloat *)allMoreOrEqual:(CGFloat)value;
- (ConditionFloat *)noneMoreOrEqual:(CGFloat)value;

- (ConditionFloat *)anyLess:(CGFloat)value;
- (ConditionFloat *)allLess:(CGFloat)value;
- (ConditionFloat *)noneLess:(CGFloat)value;

- (ConditionFloat *)anyLessOrEqual:(CGFloat)value;
- (ConditionFloat *)allLessOrEqual:(CGFloat)value;
- (ConditionFloat *)noneLessOrEqual:(CGFloat)value;

@end