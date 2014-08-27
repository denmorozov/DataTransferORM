
typedef enum
{
	ConditionAggregateOperationNo = 0,
	ConditionAggregateOperationAny = 1,
	ConditionAggregateOperationAll = 2,
	ConditionAggregateOperationNone = 3,
}ConditionAggregateOperation;

typedef enum
{
	ConditionOperatorLess = 1,
	ConditionOperatorLessOrEqual = 2,
	ConditionOperatorEqual = 3,
	ConditionOperatorMoreOrEqual = 4,
	ConditionOperatorMore = 5,
}ConditionOperator;


@class Condition;

Condition * OR(Condition *firstArg, ...);
Condition * AND(Condition *firstArg, ...);

@interface Condition : NSObject

- (id)initWithCondition:(NSString *)condition;

- (NSPredicate *)predicate;

@end