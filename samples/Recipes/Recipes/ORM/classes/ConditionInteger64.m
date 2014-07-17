#import "ConditionInteger64.h"

@interface ConditionInteger64 ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionInteger64

- (instancetype)initWithFieldName:(NSString *)fieldName equalToInteger64:(int64_t)value;
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == %lli)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreToInteger64:(int64_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ > %lli)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName moreOrEqualToInteger64:(int64_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ >= %lli)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessToInteger64:(int64_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ < %lli)", fieldName, value];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName lessOrEqualToInteger64:(int64_t)value
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ <= %lli)", fieldName, value];
	}
	
	return self;
}


@end