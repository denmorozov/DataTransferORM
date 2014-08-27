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
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperator:ConditionOperatorEqual toInt64:value];
}

- (ConditionInteger64 *)more:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMore toInt64:value];
}

- (ConditionInteger64 *)moreOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperator:ConditionOperatorMoreOrEqual toInt64:value];
}

- (ConditionInteger64 *)less:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLess toInt64:value];
}

- (ConditionInteger64 *)lessOrEqual:(int64_t)value
{
	return [[ConditionInteger64 alloc] initWithFieldName:self.name withOperator:ConditionOperatorLessOrEqual toInt64:value];
}


@end
