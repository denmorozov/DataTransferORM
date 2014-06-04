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

@end

@implementation Condition

- (NSPredicate *)predicate
{
	return [NSPredicate predicateWithFormat:self.condition];
}

- (NSString *)condition
{
	assert(false);
	return @"";
}

@end
