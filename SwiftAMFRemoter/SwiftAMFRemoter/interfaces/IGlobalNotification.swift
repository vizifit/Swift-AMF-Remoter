 
public protocol IGlobalNotification  {
    
    
    /// Get the name of the `INotification` instance.
    var name: String { get }
    
    /// Get or set the body of the `INotification` instance
    var body: Any? { get set }
    
    /// Get or set the type of the `INotification` instance
    var type: String? { get set }
    
    /// Get the string representation of the `INotification` instance
    func description() -> String

}

