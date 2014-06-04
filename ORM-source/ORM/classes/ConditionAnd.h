#import "Condition.h"

@interface ConditionAnd : Condition

- (instancetype)initWithConditions:(NSArray *)conditions;

@end