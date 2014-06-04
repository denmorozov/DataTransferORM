#import "Condition.h"

Condition * OR(Condition *condition1, Condition *condition2);
Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3);
Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4);
Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5);
Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5, Condition *condition6);

@interface ConditionOr : Condition

- (instancetype)initWithConditions:(NSArray *)conditions;

@end