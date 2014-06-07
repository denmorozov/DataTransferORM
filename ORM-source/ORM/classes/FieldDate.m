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
	return [[ConditionDate alloc] initWithFieldName:self.name equalToDate:value];
}

- (ConditionDate *)more:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name moreToDate:value];
}

- (ConditionDate *)moreOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name moreOrEqualToDate:value];
}

- (ConditionDate *)less:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name lessToDate:value];
}

- (ConditionDate *)lessOrEqual:(NSDate *)value
{
	return [[ConditionDate alloc] initWithFieldName:self.name lessOrEqualToDate:value];
}

- (ConditionDate *)null
{
	return [[ConditionDate alloc] initIsNULLWithFieldName:self.name];
}

@end
