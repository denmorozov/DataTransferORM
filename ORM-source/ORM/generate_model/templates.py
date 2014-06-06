def methodTemplate(beforeBlock, tryBlock, exceptionBlock, finallyBlock, afterBlock):
    lines = []
    lines.append('{')
    for line in beforeBlock:
        lines.append('\t' + line)
    lines.append('\t')
    lines.append('\t' + 'NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];')
    lines.append('\t' + 'context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;')
    lines.append('\t' + '@try')
    lines.append('\t' + '{')
    for line in tryBlock:
        lines.append('\t\t' + line)
    lines.append('\t' + '}')
    lines.append('\t' + '@catch(NSException *e)')
    lines.append('\t' + '{')
    for line in exceptionBlock:
        lines.append('\t\t' + line)
    lines.append('\t' + '}')
    lines.append('\t' + '@finally')
    lines.append('\t' + '{')
    for line in finallyBlock:
        lines.append('\t\t' + line)
    lines.append('\t' + '}')
    lines.append('\t')
    for line in afterBlock:
        lines.append('\t' + line)
    lines.append('}')
    
    return '\n'.join(lines)

def headerFileTemplate(importBlock, typedefBlock, className, methodsBlock):
    lines = []
    lines.append('')
    for importFile in importBlock:
        lines.append('#import "{f}"'.format(f = importFile))
    lines.append('')
    for typedef in typedefBlock:
        lines.append(typedef)
    lines.append('')
    lines.append('@interface {cn} : NSObject'.format(cn = className))
    lines.append('')
    for line in methodsBlock:
        lines.append(line)
    lines.append('')
    lines.append('@end')
    return '\n'.join(lines)

def sourceFileTemplate(importBlock, declarationMethodsBlock, className, methodsBlock):
    lines = []
    lines.append('#import "{cn}.h"'.format(cn = className))
    lines.append('')
    for importFile in importBlock:
        lines.append('#import "{f}"'.format(f = importFile))
    lines.append('')
    lines.append('@interface {cn} ()'.format(cn = className))
    lines.append('')
    for method in declarationMethodsBlock:
        lines.append(method)
    lines.append('')
    lines.append('@end')
    lines.append('')
    lines.append('@implementation {cn}'.format(cn = className))
    lines.append('')
    for method in methodsBlock:
        lines.append(method)
        lines.append('')
    lines.append('@end')
    return '\n'.join(lines)

