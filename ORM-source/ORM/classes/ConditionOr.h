#import "Condition.h"

@interface ConditionOr : Condition

- (instancetype)initWithConditions:(NSArray *)conditions;

@end