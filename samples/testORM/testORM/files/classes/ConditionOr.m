#import "ConditionOr.h"

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