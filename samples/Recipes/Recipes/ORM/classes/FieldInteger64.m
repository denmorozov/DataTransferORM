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

- (ConditionInteger64 *)equal:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name equalToInteger64:value];
}

- (ConditionInteger64 *)more:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name moreToInteger64:value];
}

- (ConditionInteger64 *)moreOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name moreOrEqualToInteger64:value];
}

- (ConditionInteger64 *)less:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name lessToInteger64:value];
}

- (ConditionInteger64 *)lessOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name lessOrEqualToInteger64:value];
}


@end
