import Foundation

/// DHQueryString
public struct DHQueryString {
    
    private init() {}
    
    public static func toDictionary(_ queryString: String, removePercentEncoding: Bool = true) -> [String:String] {
        return queryString.toDictionary(removePercentEncoding)
    }
    
    public static func toString(_ dictionary: [String:String], addingPercentEncoding: Bool = true) -> String {
        return dictionary.toQueryString(addingPercentEncoding)
    }
    
    public static func toString<Key: ExpressibleByStringLiteral, Value: ExpressibleByStringLiteral>(
        _ dictionary: DictionaryLiteral<Key, Value>, addingPercentEncoding: Bool = true) -> String {
        return dictionary.toQueryString(addingPercentEncoding)
    }
    
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: ExpressibleByStringLiteral {
    
    fileprivate func toQueryString(_ addingPercentEncoding: Bool = true) -> String {
        return queryString(self.map {($0.key as! String, $0.value as! String)}, addingPercentEncoding: addingPercentEncoding)
    }
    
}

extension KeyValuePairs where Key: ExpressibleByStringLiteral, Value: ExpressibleByStringLiteral {
    
   fileprivate func toQueryString(_ addingPercentEncoding: Bool = true) -> String {
        return queryString(self.map {($0.key as! String, $0.value as! String)}, addingPercentEncoding: addingPercentEncoding)
    }
    
}

fileprivate func queryString<T: Sequence, V: ExpressibleByStringLiteral>(_ seq: T, addingPercentEncoding: Bool) -> String
    where T.Iterator.Element == (V, V) {
        let array = seq.map { (k, v) -> String in
            var key = k as! String
            var value = v as! String
            
            if addingPercentEncoding {
                key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
                value = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
            }
            
            return "\(key)=\(value)"
        }
        return array.joined(separator: "&")
}

extension Sequence {
    
    fileprivate func toDictionary<K: Hashable, V>() -> [K:V] where Iterator.Element == (K, V) {
        var dictionary = [K:V]()
        for (key, value) in self {
            dictionary[key] = value
        }
        return dictionary
    }
    
}

extension String {
    
    fileprivate func toDictionary(_ removePercentEncoding: Bool = true) -> [String:String] {
        guard self.contains("=") else {
            return [:]
        }
        
        var query = self
        if query.hasPrefix("?") {
            query.remove(at: query.startIndex)
        }
        
        let seq = query.components(separatedBy: "&").map { s -> (String, String) in
            let data = s.components(separatedBy: "=")
            var key = data.first!
            var value = data.last!
            
            if removePercentEncoding {
                key = key.removingPercentEncoding ?? key
                value = value.removingPercentEncoding ?? value
            }
            
            return (key, value)
        }
        
        return seq.toDictionary()
    }
    
}
