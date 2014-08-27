#import "Condition.h"

@interface ConditionDate : Condition

- (instancetype)initWithFieldName:(NSString *)fieldName
					 withOperator:(ConditionOperator)operator
						withValue:(NSDate *)value;

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName;

- (instancetype)initWithFieldName:(NSString *)fieldName
					 withOperator:(ConditionOperator)operator
						withValue:(NSDate *)value
					withOperation:(ConditionAggregateOperation)operation;

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName
						  withOperation:(ConditionAggregateOperation)operation;

@end