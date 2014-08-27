#import "FieldInteger64.h"

@interface FieldInteger64 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldInteger64

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionInteger64 *)anyEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationEqaul toInt64:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger64 *)allEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationEqaul toInt64:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger64 *)noneEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationEqaul toInt64:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger64 *)anyMore:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationMore toInt64:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger64 *)allMore:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationMore toInt64:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger64 *)noneMore:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationMore toInt64:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger64 *)anyMoreOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationMoreOrEqual toInt64:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger64 *)allMoreOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationMoreOrEqual toInt64:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger64 *)noneMoreOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationMoreOrEqual toInt64:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger64 *)anyLess:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationLess toInt64:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger64 *)allLess:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationLess toInt64:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger64 *)noneLess:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationLess toInt64:value withOperation:ConditionAggregateOperationNone];
}

- (ConditionInteger64 *)anyLessOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationLessorEqual toInt64:value withOperation:ConditionAggregateOperationAny];
}
- (ConditionInteger64 *)allLessOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationLessorEqual toInt64:value withOperation:ConditionAggregateOperationAll];
}
- (ConditionInteger64 *)noneLessOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperation:ConditionOperationLessorEqual toInt64:value withOperation:ConditionAggregateOperationNone];
}

@end
