//
//  NSURLSession+Extensions.swift
//  Pods
//
//  Created by Matt Thomas on 3/17/16.
//
//
import Foundation

public typealias JSON = [AnyHashable: Any]

public enum APIClientError: Error {
    case cannotCreateURL
    case badResponse(response: URLResponse)
    case noData(response: URLResponse?)
    case cannotSerializeToJSON(data: Data)
    case resultJSONMissingKey(key: String, json: JSON)
    
    public var errorObject: NSError {
        return NSError(domain: "MISLClientErrorDomain", code: errorInfo.code, userInfo: errorInfo.userInfo)
    }
    
    fileprivate var errorInfo:(code: Int, userInfo: [AnyHashable: Any]?) {
        switch self {
            
        case .cannotCreateURL:
            return (code: 1, userInfo: nil)
            
        case .badResponse(let response):
            return (code: 2, userInfo: ["response": response])
            
        case .noData(let response):
            return (code: 3, userInfo: ["response": response ?? NSNull()])
            
        case .cannotSerializeToJSON(let data):
            return (code: 4, userInfo: ["data": "\(data)"])
            
        case .resultJSONMissingKey(let key, let json):
            return (code: 5, userInfo: [
                "key": "\(key)",
                "json": json
                ])
        }
    }
}

public extension URLSession {
    public func loadHTTP(request: URLRequest, completion: @escaping (_ result: Result<Data>) -> Void) {
        self.load(request: request) { (response, result) in
            // Because NSURLSessions "succeed" with any response, we need to check
            // and see if the response is an HTTP 400-599 to see if it’s an HTTP failure.
            if let httpResponse = response as? HTTPURLResponse , 400...599 ~= httpResponse.statusCode,
                case .success = result {
                    completion(Result(APIClientError.badResponse(response: httpResponse)))
            }
            else {
                completion(result)
            }
        }
    }
    
    public func load(request: URLRequest, completion: @escaping (_ response: URLResponse?, _ result: Result<Data>) -> Void) {
        let task = dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(response, Result(error))
            }
            else if let data = data {
                completion(response, Result(data))
            }
            else {
                completion(response, Result(APIClientError.noData(response: response)))
            }
        })
        
        task.resume()
    }
}
