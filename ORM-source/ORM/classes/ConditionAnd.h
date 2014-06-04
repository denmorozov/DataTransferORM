#import "Condition.h"

Condition * AND(Condition *condition1, Condition *condition2);
Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3);
Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4);
Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5);
Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5, Condition *condition6);

@interface ConditionAnd : Condition

- (instancetype)initWithConditions:(NSArray *)conditions;

@end