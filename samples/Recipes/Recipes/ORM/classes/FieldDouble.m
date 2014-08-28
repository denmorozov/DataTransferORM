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

- (ConditionDouble *)equal:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toDouble:value];
}

- (ConditionDouble *)more:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toDouble:value];
}

- (ConditionDouble *)moreOrEqual:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toDouble:value];
}

- (ConditionDouble *)less:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toDouble:value];
}

- (ConditionDouble *)lessOrEqual:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toDouble:value];
}


@end
