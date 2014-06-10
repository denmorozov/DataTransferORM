import os

def createHeaderDTOEntity(entity, directory):
    fileName = entity.name + 'DTO.h'
    file = open(os.path.join(directory, fileName), 'w+')
    file.write('#import <CoreData/CoreData.h>')
    file.write('\n')
    for r in entity.relationships:
        file.write('@class {en}DTO;'.format(en = r.entity.name))
        file.write('\n')
    file.write('\n')
    file.write('@interface {className}DTO : NSObject'.format(className = entity.name))
    file.write('\n')
    
    file.write('@property (nonatomic, strong) NSManagedObjectID *objectID;\n')
    for field in entity.fields:
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
    
    for r in entity.relationships:
        if r.type == 'toMany':
            file.write('@property (nonatomic, strong) NSArray *{name};'.format(name = r.name))
        if r.type == 'toOne':
            file.write('@property (nonatomic, strong) {e}DTO *{n};'.format(e = r.entity.name, n = r.name))
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

def createDTOEntities(entities, directory):
    if not os.path.exists(directory):
        os.makedirs(directory)
    for entity in entities:
        createHeaderDTOEntity(entity, directory)
        createSourceFileDTOEntity(entity, directory)