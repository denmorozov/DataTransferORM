#import "ConditionOr.h"

Condition * OR(Condition *condition1, Condition *condition2)
{
	return [[ConditionOr alloc] initWithConditions:@[condition1, condition2]];
}

Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3)
{
	return [[ConditionOr alloc] initWithConditions:@[condition1, condition2, condition3]];
}

Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4)
{
	return [[ConditionOr alloc] initWithConditions:@[condition1, condition2, condition3, condition4]];
}

Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5)
{
	return [[ConditionOr alloc] initWithConditions:@[condition1, condition2, condition3, condition4, condition5]];
}

Condition * OR(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5, Condition *condition6)
{
	return [[ConditionOr alloc] initWithConditions:@[condition1, condition2, condition3, condition4, condition5, condition6]];
}

@interface Condition ()

- (NSString *)condition;

@end

@interface ConditionOr ()

@property (nonatomic, strong) NSArray *conditions;

@end

@implementation ConditionOr

- (instancetype)initWithConditions:(NSArray *)conditions
{
	self = [super init];
	
	if (self)
	{
		self.conditions = conditions;
	}
	
	return self;
}

- (NSString *)condition
{
	NSMutableArray *conds = [NSMutableArray new];
	
	for (Condition *cond in self.conditions)
	{
		[conds addObject:cond.condition];
	}
	
	NSString *condsString = [conds componentsJoinedByString:@"OR"];
	
	return [NSString stringWithFormat:@"(%@)", condsString];
}

@end