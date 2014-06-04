#import "ConditionAnd.h"

Condition * AND(Condition *condition1, Condition *condition2)
{
	return [[ConditionAnd alloc] initWithConditions:@[condition1, condition2]];
}

Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3)
{
	return [[ConditionAnd alloc] initWithConditions:@[condition1, condition2, condition3]];
}

Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4)
{
	return [[ConditionAnd alloc] initWithConditions:@[condition1, condition2, condition3, condition4]];
}

Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5)
{
	return [[ConditionAnd alloc] initWithConditions:@[condition1, condition2, condition3, condition4, condition5]];
}

Condition * AND(Condition *condition1, Condition *condition2, Condition *condition3, Condition *condition4, Condition *condition5, Condition *condition6)
{
	return [[ConditionAnd alloc] initWithConditions:@[condition1, condition2, condition3, condition4, condition5, condition6]];
}


@interface Condition ()

- (NSString *)condition;

@end

@interface ConditionAnd ()

@property (nonatomic, strong) NSArray *conditions;

@end

@implementation ConditionAnd

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
	
	NSString *condsString = [conds componentsJoinedByString:@"AND"];
	
	return [NSString stringWithFormat:@"(%@)", condsString];
}

@end