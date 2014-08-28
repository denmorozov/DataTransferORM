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

- (ConditionDate *)equal:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual withValue:value];
}

- (ConditionDate *)more:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore withValue:value];
}

- (ConditionDate *)moreOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual withValue:value];
}

- (ConditionDate *)less:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess withValue:value];
}

- (ConditionDate *)lessOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual withValue:value];
}

- (ConditionDate *)null
{
	return [[ConditionDate alloc] initIsNULLWithFieldName:self.name];
}

@end
