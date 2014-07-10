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
            print('Bad type "{t}"', t = field.type)
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
        if property.relationship != None and property.relationship.type == 'toOne':
            subDTOName = classDef.name + upperCaseForFirstSymbol(property.name)
            propertyName = property.name
            file.write('@property (nonatomic, strong) {sn}DTO *{n};'.format(sn = subDTOName, n = propertyName))
        file.write('\n')
    
    file.write('@end')
    file.write('\n')
    file.close()

def createSourceFileDTOEntity(entity, directory):
    fileName = entity.name + 'DTO.m'
    file = open(os.path.join(directory, fileName), 'w+')
    
    file.write('#import "{className}DTO.h"'.format(className = entity.name))
    file.write('\n')
    file.write('\n')
    
    file.write('@implementation {className}DTO'.format(className = entity.name))
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
                #createSourceFileDTOEntity(entity, directory)