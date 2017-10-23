//
//  ReferenceData.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


open class ReferenceData {
    
    fileprivate var _strings:[Int:String]
    fileprivate var _objects:[Int:Any]
    fileprivate var _classDefinitions:[Int:ClassDefinition]
    fileprivate static var _classMaps:[ClassMap] = []
    
    
    init(){
        
        _strings = [:]
        _objects = [:]
        _classDefinitions = [:]
        
        registerFlexClasses()
        
    }
    
    
    fileprivate func registerFlexClasses(){
        
        // Need to set default class maps from core flex classesuper.bytess
        
        add(ClassMap(className: "AcknowledgeMessage", classAlias: "flex.messaging.messages.AcknowledgeMessage"))
        add(ClassMap(className: "AsyncMessage", classAlias: "flex.messaging.messages.AsyncMessage"))
        add(ClassMap(className: "ErrorMessage", classAlias: "flex.messaging.messages.ErrorMessage"))
        add(ClassMap(className: "FlexMessage", classAlias: "flex.messaging.messages.FlexMessage"))
        add(ClassMap(className: "AcknowledgeMessage", classAlias: "flex.messaging.messages.AcknowledgeMessage"))
        add(ClassMap(className: "AcknowledgeMessage", classAlias: "flex.messaging.messages.AcknowledgeMessage"))
        
    }
    
    open var classDefinitions:[Int:ClassDefinition]{
        
        get { return _classDefinitions }
        //set { _classDefinitions = newValue }
    }
    
    open var objects:[Int:Any]{
        get { return _objects }
        //set { _objects = newValue }
    }
    
    open var strings:[Int:String]{
        get { return _strings }
        //set { _strings = newValue }
    }
    
    open var classMaps:[ClassMap]{
        get { return ReferenceData._classMaps }
        //set { _classMaps = newValue }
    }
    
    func add(_ value:String) {
        
        if(indexOf(value) != nil){
            if(AMF3Coder.verboseDebug){ print("Reference string \(value) already exists") }
            return
        }
        
        _strings[_strings.count] = value
    }
    
    func add(_ value:BasicObject) {
        
        if(indexOf(value) != nil){
            if(AMF3Coder.verboseDebug){ print("Reference Object already exists ") }
            
            return
        }
        
        _objects[_objects.count] = value
    }
    
    func add(_ value:Date) {
        
        if(indexOf(value) != nil){
            if(AMF3Coder.verboseDebug){ print("Reference Date already exists ") }
            return
        }
        
        _objects[_objects.count] = value
    }

    
    func add(_ value:ClassDefinition) {
        
        if(indexOf(value) != nil){
            if(AMF3Coder.verboseDebug){ print("Reference ClassDefinition already exists ") }
            return
        }
        
        //_objects[_objects.count] = value // Temporary, only until we add class definitions into objects.
        _classDefinitions[_classDefinitions.count] = value
    }
    
    func add(_ value:ClassMap) {
        
        if(indexOf(value) != nil){
            if(AMF3Coder.verboseDebug){ print("Reference ClassMap already exists ") }
            return
        }
        
        ReferenceData._classMaps.append(value)
    }
    
    func add(_ value:ASArray) {
        
        if(indexOf(value) != nil){
            if(AMF3Coder.verboseDebug){ print("Reference ClassMap already exists ") }
            
            return
        }
        
        _objects[_objects.count] = value

    }
    
    func getString(_ index:Int) throws -> String {
        
        if (_strings.count <= index) {
            print("Error: getString: \(index)")
            throw AMFCoderError.outOfIndex
        }
        return strings[index]! as String
    }
    
    func getObject(_ index:Int) throws -> Any {
        if (_objects.count <= index) {
            print("Error: getObject: \(index)")
            throw AMFCoderError.outOfIndex
        }
        return _objects[index]!
    }
    
    func getClassDefinition(_ index:Int) throws -> ClassDefinition {
        if (_classDefinitions.count <= index) {
            print("Error: getClassDefinition: \(index)")
            throw AMFCoderError.outOfIndex
        }
        return _classDefinitions[index]!
    }
    
    func getClassDefinition(_ value:String) -> ClassDefinition? {
        
        let clsDef:ClassDefinition = ClassDefinition(name: value)
        
        do{
            guard let index = indexOf(clsDef) else{
                return nil
            }
            
            return try getClassDefinition(index)
            
        }catch let e {
            print(e.localizedDescription)
        }
        
        return nil
    }
    
    
    func getClassMap(_ index:Int) throws -> ClassMap {
        if (ReferenceData._classMaps.count <= index) {
            throw AMFCoderError.outOfIndex
        }
        return ReferenceData._classMaps[index]
    }
    
    func getClassMap(_ value:String, isFromClassName:Bool=true) -> ClassMap? {
        
        let clsMap:ClassMap = (isFromClassName) ? ClassMap(className: value, classAlias: "") : ClassMap(className: "", classAlias: value)
        
        do{
            guard let index = indexOf(clsMap, isFromClassName: isFromClassName) else{
                return nil
            }
            
            return try getClassMap(index)
            
        }catch let e {
            print(e.localizedDescription)
        }
        
        return nil
    }
    
    func indexOf(_ value:Date) -> Int? {

        for (index, object) in _objects {
            if let object:Date = object as? Date , String(format: "Date- %.2f", (object as Date).timeIntervalSince1970) == String(format: "Date- %.2f", value.timeIntervalSince1970) {
                return index
            }
        }

        return nil
    }
    
    func indexOf<T:Equatable>(_ value: T) -> Int? {
        for (index, object) in _objects {
            if let object:T = object as? T , object == value {
                return index
            }
        }
        
        return nil
    }
    
    func indexOf(_ value:BasicObject) -> Int? {
        
        for (index, object) in _objects {
            if let object:BasicObject = object as? BasicObject , object === value {
                return index
            }
        }
        
        return nil
    }
    
    //    func indexOfObject(_ value:ASObject) -> Int? {
    //        for (index, data) in _objects.enumerated() {
    //            if let data:ASObject = data as? ASObject , data === value {
    //                return index
    //            }
    //        }
    //        return nil
    //    }
    
    func indexOf(_ value:String) -> Int? {
        
        for (key, string) in _strings {
            if(string == value){ return key }
        }
        
        return nil
    }
    
    
    func indexOf(_ value:ClassMap, isFromClassName:Bool=true) -> Int? {
        
        let searchValue:String = (isFromClassName) ? value.className : value.classAlias
        
        for (index, data) in ReferenceData._classMaps.enumerated() {
            
            let dataValue = (isFromClassName) ? data.className : data.classAlias
            
            if dataValue == searchValue  {
                return index
            }
        }
        return nil
    }
    
    func indexOf(_ value:ClassDefinition) -> Int? {
        
        for (index, classDef) in _classDefinitions {
            if classDef.name == value.name {
                return index
            }
        }
        
        return nil
    }
    
    
    func reset(excludeClassMap:Bool=true){
        
        _strings.removeAll()
        _objects.removeAll()
        _classDefinitions.removeAll()
        
        //_strings.append(UUID().uuidString)
        
        if(!excludeClassMap){
            ReferenceData._classMaps.removeAll()
        }
    }
    
    
    
    
    
}
