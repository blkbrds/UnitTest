//
//  MatchersExt.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Mockingjay

/**
 Custom http with parameters

 - Parameter method: the Mockingjay HTTPMethod enum
 - Parameter uri: api path
 - Parameter parameters: paramaters for request, handle by Alamofire ParameterEncoding function
 */

func http(_ method: HTTPMethod, uri: String, parameters: [String: Any]) -> (_ request: URLRequest) -> Bool {
    var path = uri
    if var urlComponents = URLComponents(string: path), !parameters.isEmpty {
        if let percentEncodedQuery = urlComponents.percentEncodedQuery.map({ $0 + "&" }) {
            urlComponents.percentEncodedQuery = percentEncodedQuery + query(parameters)
        } else {
            urlComponents.percentEncodedQuery = query(parameters)
        }
        if let absoluteString = urlComponents.url?.absoluteString {
            path = absoluteString
        }
    }
    return http(method, uri: path)
}

// The functions blow is referenced from Alamofire ParameterEncoding.swift
private func escape(_ string: String) -> String {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowedCharacterSet = CharacterSet.urlQueryAllowed
    allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

    var escaped = ""

    //==========================================================================================================
    //
    //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
    //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
    //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
    //  info, please refer to:
    //
    //      - https://github.com/Alamofire/Alamofire/issues/206
    //
    //==========================================================================================================

    if #available(iOS 8.3, *) {
        escaped = string
        if let stringEncoding = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            escaped = stringEncoding
        }
    } else {
        let batchSize = 50
        var index = string.startIndex

        while index != string.endIndex {
            let startIndex = index
            var endIndex = string.endIndex
            if let stringEndIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) {
                endIndex = stringEndIndex
            }
            let range = startIndex..<endIndex

            let substring = string[range]
            if let substringEndcoding = substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                escaped += substringEndcoding
            } else {
                escaped += String(substring)
            }
            index = endIndex
        }
    }
    return escaped
}

private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []

    if let dictionary = value as? [String: Any] {
        dictionary.forEach { (nestedKey, value) in
            components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [Any] {
        array.forEach { value in
            components += queryComponents(fromKey: "\(key)[]", value: value)
        }
    } else if let value = value as? NSNumber {
        if value.isBool {
            components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
    } else if let bool = value as? Bool {
        components.append((escape(key), escape((bool ? "1" : "0"))))
    } else {
        components.append((escape(key), escape("\(value)")))
    }

    return components
}

private func query(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    parameters.keys.sorted(by: <).forEach { key in
        if let value = parameters[key] {
            components += queryComponents(fromKey: key, value: value)
        }
    }
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
