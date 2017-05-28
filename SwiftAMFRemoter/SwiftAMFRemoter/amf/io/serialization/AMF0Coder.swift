//
//  AMF0Encoder.swift
//  AmfWriterTest
//
//  Created by Tony Henderson on 12/7/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation



/// AMF3 Type values 0-16
public enum AMF0DataType : UInt8 {
    case number      = 0x00
    case bool        = 0x01
    case string      = 0x02
    case object      = 0x03
    // case MovieClip   = 0x04
    case null        = 0x05
    case undefined   = 0x06
    case reference   = 0x07
    case ecmaArray   = 0x08
    case objectEnd   = 0x09
    case strictArray = 0x0a
    case date        = 0x0b
    case longString  = 0x0c
    case unsupported = 0x0d
    // case RecordSet   = 0x0e
    case xmlDocument = 0x0f
    case typedObject = 0x10
    case avmplush    = 0x11
    
    

}

class AMF0Coder : AMFCoder{


}
