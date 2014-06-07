#import "ConditionString.h"

@interface ConditionString ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionString

- (instancetype)initWithFieldName:(NSString *)fieldName equalToString:(NSString *)string
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == '%@')", fieldName, string];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName likeToPattern:(NSString *)pattern
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ like '%@')", fieldName, pattern];
	}
	
	return self;
}

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == '%@')", fieldName, nil];
	}
	
	return self;
}

@end