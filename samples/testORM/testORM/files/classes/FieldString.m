#import "FieldString.h"

@interface FieldString ()

@property (nonatomic, strong) NSString *name;

@end

@implementation FieldString

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		self.name = name;
	}
	return self;
}

- (ConditionString *)equal:(NSString *)string
{
	return [[ConditionString alloc] initWithFieldName:self.name equalToString:string];
}

- (ConditionString *)like:(NSString *)pattern
{
	return [[ConditionString alloc] initWithFieldName:self.name likeToPattern:pattern];
}

@end
