#import "Condition.h"

@interface ConditionInteger32 : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt32:(int32_t)value;
- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toInt32:(int32_t)value withOperation:(ConditionAggregateOperation)operation;

@end