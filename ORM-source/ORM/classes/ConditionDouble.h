#import "Condition.h"

@interface ConditionDouble : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toDouble:(double)value;
- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toDouble:(double)value withOperation:(ConditionAggregateOperation)operation;

@end