#import "FieldDouble.h"

@interface FieldDouble ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldDouble

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionDouble *)anyEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorEqual toDouble:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionDouble *)allEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorEqual toDouble:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionDouble *)noneEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorEqual toDouble:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDouble *)anyMore:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorMore toDouble:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionDouble *)allMore:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorMore toDouble:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionDouble *)noneMore:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorMore toDouble:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDouble *)anyMoreOrEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toDouble:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionDouble *)allMoreOrEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toDouble:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionDouble *)noneMoreOrEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toDouble:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDouble *)anyLess:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorLess toDouble:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionDouble *)allLess:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorLess toDouble:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionDouble *)noneLess:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorLess toDouble:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDouble *)anyLessOrEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toDouble:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionDouble *)allLessOrEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toDouble:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionDouble *)noneLessOrEqual:(double)value
{
	return [[ConditionDouble init] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toDouble:value withOperation:ConditionAggregateOperationNone];
}


@end
