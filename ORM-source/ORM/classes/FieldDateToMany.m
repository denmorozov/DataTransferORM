#import "FieldDate.h"

@interface FieldDate ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldDate

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionDate *)anyEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual withValue:value withOperation:ConditionAggregateOperationAny];
}

- (ConditionDate *)allEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual withValue:value withOperation:ConditionAggregateOperationAll];
}

- (ConditionDate *)noneEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual withValue:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDate *)anyMore:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore withValue:value withOperation:ConditionAggregateOperationAny];
}

- (ConditionDate *)allMore:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore withValue:value withOperation:ConditionAggregateOperationAll];
}

- (ConditionDate *)noneMore:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore withValue:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDate *)anyMoreOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual withValue:value withOperation:ConditionAggregateOperationAny];
}

- (ConditionDate *)allMoreOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual withValue:value withOperation:ConditionAggregateOperationAll];
}

- (ConditionDate *)noneMoreOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual withValue:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDate *)anyLess:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess withValue:value withOperation:ConditionAggregateOperationAny];
}

- (ConditionDate *)allLess:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess withValue:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionDate *)noneLess:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess withValue:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDate *)anyLessOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual withValue:value withOperation:ConditionAggregateOperationAny];
}

- (ConditionDate *)allLessOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual withValue:value withOperation:ConditionAggregateOperationAll];
}

- (ConditionDate *)noneLessOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual withValue:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionDate *)anyNull
{
	return [[ConditionDate alloc] initIsNULLWithFieldName:self.name withOperation:ConditionAggregateOperationAny];
}

- (ConditionDate *)allNull
{
	return [[ConditionDate alloc] initIsNULLWithFieldName:self.name withOperation:ConditionAggregateOperationAll];
}

- (ConditionDate *)noneNull
{
	return [[ConditionDate alloc] initIsNULLWithFieldName:self.name withOperation:ConditionAggregateOperationNone];
}

@end
