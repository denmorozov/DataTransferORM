#import "FieldFloat.h"

@interface FieldFloat ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldFloat

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionFloat *)equal:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toFloat:value];
}

- (ConditionFloat *)more:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toFloat:value];
}

- (ConditionFloat *)moreOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toFloat:value];
}

- (ConditionFloat *)less:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toFloat:value];
}

- (ConditionFloat *)lessOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toFloat:value];
}


@end
