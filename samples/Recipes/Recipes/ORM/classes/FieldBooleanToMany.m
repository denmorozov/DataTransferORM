#import "FieldBooleanToMany.h"

@interface FieldBooleanToMany ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldBooleanToMany

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionBoolean *)anyIsYES
{
	return [[ConditionBoolean alloc] initIsYESWithFieldName:self.name withAggregateOperation:ConditionAggregateOperationAny];
}

- (ConditionBoolean *)anyIsNO
{
	return [[ConditionBoolean alloc] initIsNOWithFieldName:self.name withAggregateOperation:ConditionAggregateOperationAny];
}

- (ConditionBoolean *)allIsYES
{
	return [[ConditionBoolean alloc] initIsYESWithFieldName:self.name withAggregateOperation:ConditionAggregateOperationAll];
}

- (ConditionBoolean *)allIsNO
{
	return [[ConditionBoolean alloc] initIsNOWithFieldName:self.name withAggregateOperation:ConditionAggregateOperationAll];
}

- (ConditionBoolean *)noneIsYES
{
	return [[ConditionBoolean alloc] initIsYESWithFieldName:self.name withAggregateOperation:ConditionAggregateOperationNone];
}

- (ConditionBoolean *)noneIsNO
{
	return [[ConditionBoolean alloc] initIsNOWithFieldName:self.name withAggregateOperation:ConditionAggregateOperationNone];
}


@end
