//
//  Extended utility by Saoud M. Rizwan
//  https://medium.com/@sdrzn/swift-4-codable-lets-make-things-even-easier-c793b6cf29e1
//

import Foundation

public class PersistantStorage {
    
    fileprivate init() { }
    
    private static var _amfEncoder:IAMFCoder = AMF3Coder()
    private static var _amfDecoder:IAMFCoder = AMF3Coder()
    
    public enum Directory {
        // Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents
        
        // Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
        case caches
    }
    
    /// Returns URL constructed from specified directory
    static fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    static public func encodeItemToCache(cacheKey:String, cache:AMFPersistantCache, object: Any?  ) throws -> Bool{
        
       
        var mutableCache = cache
        // Encoder value
        _amfEncoder.resetPosition()
        _amfEncoder.encodeValue(object)
        
        let encodedObject = _amfEncoder.bytes
  
        let cacheIndex:Int? = mutableCache.indexOf(cacheKey, isFromClassName: true)
        
        if(cacheIndex != nil){
            // Remove value
            let valueRemoved =  mutableCache.cacheData?.remove(at: cacheIndex!)
            print("Removed")
            print(valueRemoved?.cacheKey )
        }
        
        let objectId =   String(describing: type(of: object))
        
        // Initialize
        if(mutableCache.cacheData == nil){
            mutableCache.cacheData = []
        }
        
        let item = try AMFPersistantCacheItem(cacheKey: cacheKey, objectId: objectId, objectData: encodedObject)
        
        mutableCache.cacheData?.append(item)
       
        return true
    }
    
    static public func decodeItemFromCache(cache:AMFPersistantCache, cacheKey:String, isFromClassName:Bool=true) throws -> Any? {
        
      
        do{
            guard let index = cache.indexOf(cacheKey, isFromClassName: isFromClassName) else{
                return nil
            }
            
            let cacheItem:AMFPersistantCacheItem? =  cache.cacheData?[index]
            
            if(cacheItem == nil){
                return nil
            }
            
            _amfDecoder.resetPosition()
            
            return try _amfDecoder.decodeValue(cacheItem!.objectData)
            
        }catch let e {
            print(e.localizedDescription)
        }
        
        return nil
    }
    
    
//    static func decodeItemFromCache(cache:AMFPersistantCache, cacheKey:String ) -> Any?
//    {
//
//        _amfDecoder.resetPosition()
//
//
////        let encodedObject = _amfEncoder.encode(object)
////        let defaultCacheKey = (cacheKey == nil) ? objectId : cacheKey
////
////        return AMFPersistantCacheItem(cacheKey: defaultCacheKey, objectId: objectId, objectData: encodedObject)
//
//    }
    
//    // AMF Encoding before saving to storage
//    _amfEncoder.resetPosition()
//    let encodedInAMF = _amfEncoder.encode(object)
//
//    // AMF Decoding before retreiving from Storage
//    _amfDecoder.resetPosition()
//    let decodedInAMF = _amfEncoder.decode(decodedValue)
    
    
    
    /// Store an encodable struct to the specified directory on disk
    ///
    /// - Parameters:
    ///   - object: the encodable struct to store
    ///   - directory: where to store the struct
    ///   - fileName: what to name the file where the struct data will be stored
    static public func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - fileName: name of the file where struct data is stored
    ///   - directory: directory where struct data is stored
    ///   - type: struct type (i.e. Message.self)
    /// - Returns: decoded struct model(s) of data
    static public func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File at path \(url.path) does not exist!")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = PropertyListDecoder()
            
            do {
                let decodedValue = try decoder.decode(type, from: data)
                
                return decodedValue
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(url.path)!")
        }
    }
    
    /// Remove all files at specified directory
    static public func clear(_ directory: Directory) {
        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Remove specified file from specified directory
    static public func remove(_ fileName: String, from directory: Directory) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    static public func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
}


