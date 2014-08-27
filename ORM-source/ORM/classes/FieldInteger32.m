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

- (ConditionInteger32 *)equal:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toInt32:value];
}

- (ConditionInteger32 *)more:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toInt32:value];
}

- (ConditionInteger32 *)moreOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toInt32:value];
}

- (ConditionInteger32 *)less:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toInt32:value];
}

- (ConditionInteger32 *)lessOrEqual:(int32_t)value
{
	return [[ConditionInteger32 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toInt32:value];
}


@end
