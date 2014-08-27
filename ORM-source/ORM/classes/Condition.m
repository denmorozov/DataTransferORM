#import "Condition.h"

#import "ConditionOr.h"
#import "ConditionAnd.h"

Condition * OR(Condition *firstArg, ...)
{
	NSMutableArray *array = [NSMutableArray new];
	va_list args;
	va_start(args, firstArg);
	for (Condition *arg = firstArg; arg != nil; arg = va_arg(args, Condition*))
	{
		[array addObject:arg];
	}
	va_end(args);

	return [[ConditionOr alloc] initWithConditions:array];
}

Condition * AND(Condition *firstArg, ...)
{
	NSMutableArray *array = [NSMutableArray new];
	va_list args;
	va_start(args, firstArg);
	for (Condition *arg = firstArg; arg != nil; arg = va_arg(args, Condition*))
	{
		[array addObject:arg];
	}
	va_end(args);

	return [[ConditionAnd alloc] initWithConditions:array];
}

@interface Condition ()
{
	NSString *_condition;
}

@end

@implementation Condition

- (id)initWithCondition:(NSString *)condition
{
	if ( (self = [super init]) )
	{
		_condition = condition;
	}
}

- (NSPredicate *)predicate
{
	return [NSPredicate predicateWithFormat:self.condition];
}

- (NSString *)condition
{
	return _condition;
}

- (NSString *)stringOperation:(ConditionAggregateOperation)op
{
	switch (op)
	{
		case ConditionAggregateOperationNo: return @"";
		case ConditionAggregateOperationAny: return @"ANY";
		case ConditionAggregateOperationAll: return @"ALL";
		case ConditionAggregateOperationNone: return @"NONE";
	}
}

- (NSString *)stringOperator:(ConditionOperator)op
{
	switch (op)
	{
		case ConditionOperatorLess: return @"<";
		case ConditionOperatorLessOrEqual: return @"<=";
		case ConditionOperatorEqual: return @"==";
		case ConditionOperatorMoreOrEqual: return @">=";
		case ConditionOperatorMore: return @">";
	}
}

@end
