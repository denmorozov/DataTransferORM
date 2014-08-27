#import "FieldInteger32.h"

@interface FieldInteger32 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldInteger32

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionInteger32 *)anyEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toInt32:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger32 *)allEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toInt32:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger32 *)noneEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toInt32:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger32 *)anyMore:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toInt32:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger32 *)allMore:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toInt32:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger32 *)noneMore:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toInt32:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger32 *)anyMoreOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toInt32:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger32 *)allMoreOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toInt32:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger32 *)noneMoreOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toInt32:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger32 *)anyLess:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toInt32:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger32 *)allLess:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toInt32:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger32 *)noneLess:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toInt32:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger32 *)anyLessOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toInt32:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger32 *)allLessOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toInt32:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger32 *)noneLessOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toInt32:value withOperation:ConditionAggregateOperationNone];
}

@end
