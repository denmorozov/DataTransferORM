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
	return [[ConditionFloat alloc] initWithFieldName:self.name equalToFloat:value];
}

- (ConditionFloat *)more:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name moreToFloat:value];
}

- (ConditionFloat *)moreOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name moreOrEqualToFloat:value];
}

- (ConditionFloat *)less:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name lessToFloat:value];
}

- (ConditionFloat *)lessOrEqual:(CGFloat)value
{
	return [[ConditionFloat alloc] initWithFieldName:self.name lessOrEqualToFloat:value];
}


@end
