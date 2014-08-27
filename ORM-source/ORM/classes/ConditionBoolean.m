#import "ConditionBoolean.h"

@interface ConditionBoolean ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionBoolean

- (instancetype)initIsYESWithFieldName:(NSString *)fieldName
{
	self = [super init];
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ != 0)", fieldName];
	}
	return self;
}

- (instancetype)initIsNOWithFieldName:(NSString *)fieldName
{
	self = [super init];
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == 0)", fieldName];
	}
	return self;
}

- (instancetype)initIsYESWithFieldName:(NSString *)fieldName withAggregateOperation:(ConditionAggregateOperation)aggregateOperation
{
	self = [super init];
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ != 0)", [self stringOperation:aggregateOperation], fieldName];
	}
	return self;
}

- (instancetype)initIsNOWithFieldName:(NSString *)fieldName withAggregateOperation:(ConditionAggregateOperation)aggregateOperation
{
	self = [super init];
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ == 0)", [self stringOperation:aggregateOperation], fieldName];
	}
	return self;
}

@end