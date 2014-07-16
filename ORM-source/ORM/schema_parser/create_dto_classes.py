import os
from helpers import upperCaseForFirstSymbol

def createHeaderDTOEntity(classDef, directory):
    fileName = classDef.name + 'DTO.h'
    file = open(os.path.join(directory, fileName), 'w+')
    file.write('#import <CoreData/CoreData.h>')
    file.write('\n')
    for property in classDef.properties:
        if property.relationship == None:
            continue
        subDTOName = classDef.name + upperCaseForFirstSymbol(property.name)
        file.write('@class {sn}DTO;'.format(sn = subDTOName))
        file.write('\n')
    file.write('\n')
    file.write('@interface {cn}DTO : NSObject'.format(cn = classDef.name))
    file.write('\n')
    
    file.write('@property (nonatomic, strong) NSManagedObjectID *objectID;\n')
    
    for property in classDef.properties:
        if property.relationship != None:
            continue
        field = classDef.entity.fieldByName(property.name)
        type = None
        mutateAttr = None
        if field.type == 'string':
            type = 'NSString'
            mutateAttr = 'strong'
        if field.type == 'float':
            type = 'float'
            mutateAttr = 'assign'
        if field.type == 'boolean':
            type = 'BOOL'
            mutateAttr = 'assign'
        if field.type == 'date':
            type = 'NSDate'
            mutateAttr = 'strong'
        if field.type == 'double':
            type = 'double'
            mutateAttr = 'assign'
        if field.type == 'data':
            type = 'NSData'
            mutateAttr = 'strong'
        if field.type == 'integer32':
            type = 'int32_t'
            mutateAttr = 'assign'
        if field.type == 'integer64':
            type = 'int64_t'
            mutateAttr = 'assign'
        if type == None:
            print('Bad type "{t}"'.format(t = field.type))
        pointer = '*' if (mutateAttr == 'strong') else ''
        file.write('@property (nonatomic, {ma}) {t} {p}{n};'.format(ma = mutateAttr, t = type, p = pointer, n = field.name))
        file.write('\n')
    
    for property in classDef.properties:
        if property.relationship != None and property.relationship.type == 'toMany':
            subDTOName = classDef.name + upperCaseForFirstSymbol(property.name)
            propertyName = property.name
            PropertyName = upperCaseForFirstSymbol(propertyName)
            file.write('@property (nonatomic, strong) NSArray *{name};'.format(name = propertyName))
            file.write('\n')
            file.write('- (void)add{pn}Object:({sn}DTO *)object;'.format(pn = PropertyName, sn = subDTOName))
            file.write('\n')
            file.write('- (void)remove{pn}Object:({sn}DTO *)object;'.format(pn = PropertyName, sn = subDTOName))
            file.write('\n')
        if property.relationship != None and property.relationship.type == 'toOne':
            subDTOName = classDef.name + upperCaseForFirstSymbol(property.name)
            propertyName = property.name
            file.write('@property (nonatomic, strong) {sn}DTO *{n};'.format(sn = subDTOName, n = propertyName))
        file.write('\n')
    
    file.write('@end')
    file.write('\n')
    file.close()

def createSourceFileDTOEntity(classDef, directory):
    fileName = classDef.name + 'DTO.m'
    file = open(os.path.join(directory, fileName), 'w+')
    
    file.write('#import "{cn}DTO.h"'.format(cn = classDef.name))
    file.write('\n')
    file.write('\n')
    
    file.write('@interface {cn}DTO ()'.format(cn = classDef.name))
    file.write('\n')
    file.write('{')
    file.write('\n')
    for property in classDef.properties:
        if property.relationship != None and property.relationship.type == 'toMany':
            propertyName = property.name
            file.write('\tNSMutableArray *m_{pn};'.format(pn = propertyName))
            file.write('\n')
            file.write('\tNSArray *im_{pn};'.format(pn = propertyName))
            file.write('\n')
    file.write('}')
    file.write('\n')
    file.write('\n')
    file.write('@end')
    file.write('\n')
    file.write('\n')

    file.write('@implementation {cn}DTO'.format(cn = classDef.name))
    file.write('\n')
    file.write('\n')
    file.write('- (id)init')
    file.write('\n')
    file.write('{')
    file.write('\n')
    file.write('\tself = [super init];')
    file.write('\n')
    file.write('\n')
    for property in classDef.properties:
        if property.relationship != None and property.relationship.type == 'toMany':
            propertyName = property.name
            file.write('\tm_{pn} = [NSMutableArray new];'.format(pn = propertyName))
            file.write('\n')
            file.write('\tim_{pn} = [NSArray new];'.format(pn = propertyName))
            file.write('\n')
            file.write('\n')
    file.write('\treturn self;')
    file.write('\n')
    file.write('}')

    for property in classDef.properties:
        if property.relationship != None and property.relationship.type == 'toMany':
            subDTOName = classDef.name + upperCaseForFirstSymbol(property.name)
            propertyName = property.name
            PropertyName = upperCaseForFirstSymbol(propertyName)
            lines = []
            lines.append('- (void)add{pn}Object:({sn}DTO *)object;'.format(pn = PropertyName, sn = subDTOName))
            lines.append('{')
            lines.append('\t[m_{pn} addObject:object];'.format(pn = propertyName))
            lines.append('\tim_{pn} = m_{pn}.copy;'.format(pn = propertyName))
            lines.append('}')
            lines.append('- (void)remove{pn}Object:({sn}DTO *)object;'.format(pn = PropertyName, sn = subDTOName))
            lines.append('{')
            lines.append('\t[m_{pn} removeObject:object];'.format(pn = propertyName))
            lines.append('\tim_{pn} = m_{pn}.copy;'.format(pn = propertyName))
            lines.append('}')
            lines.append('- (void)set{pn}:(NSArray *)objects;'.format(pn = PropertyName))
            lines.append('{')
            lines.append('\tim_{pn} = objects.copy;'.format(pn = propertyName))
            lines.append('}')
            lines.append('- (NSArray *){pn}'.format(pn = propertyName))
            lines.append('{')
            lines.append('\treturn im_{pn};'.format(pn = propertyName))
            lines.append('}')
            file.write('\n'.join(lines))
        file.write('\n')
    
    file.write('@end')
    file.write('\n')
    
    file.close()

def createDTOClasses(models, directory):
    for model in models:
        for struct in model.structs:
            classesDefs = struct.classesDefs()
            for d in classesDefs:
                createHeaderDTOEntity(d, directory)
                createSourceFileDTOEntity(d, directory)

