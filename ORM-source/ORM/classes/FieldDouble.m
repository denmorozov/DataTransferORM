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
	return [[ConditionDouble alloc] initWithFieldName:self.name equalToDouble:value];
}

- (ConditionDouble *)more:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name moreToDouble:value];
}

- (ConditionDouble *)moreOrEqual:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name moreOrEqualToDouble:value];
}

- (ConditionDouble *)less:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name lessToDouble:value];
}

- (ConditionDouble *)lessOrEqual:(double)value
{
	return [[ConditionDouble alloc] initWithFieldName:self.name lessOrEqualToDouble:value];
}


@end
