#import "FieldFloatToMany.h"

@interface FieldFloatToMany ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldFloatToMany

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionFloat *)anyEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toFloat:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionFloat *)allEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toFloat:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionFloat *)noneEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toFloat:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionFloat *)anyMore:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toFloat:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionFloat *)allMore:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toFloat:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionFloat *)noneMore:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toFloat:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionFloat *)anyMoreOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toFloat:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionFloat *)allMoreOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toFloat:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionFloat *)noneMoreOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toFloat:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionFloat *)anyLess:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toFloat:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionFloat *)allLess:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toFloat:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionFloat *)noneLess:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toFloat:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionFloat *)anyLessOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toFloat:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionFloat *)allLessOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toFloat:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionFloat *)noneLessOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toFloat:value withOperation:ConditionAggregateOperationNone];
}


@end
