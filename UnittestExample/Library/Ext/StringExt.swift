//
//  String.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

enum Process {
    case encode
    case decode
}

extension String {

    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func base64(_ method: Process) -> String? {
        switch method {
        case .encode:
            guard let data = data(using: .utf8) else { return nil }
            return data.base64EncodedString()
        case .decode:
            guard let data = Data(base64Encoded: self) else { return nil }
            return String(data: data, encoding: .utf8)
        }
    }

    // MARK: Validation
    public struct Regex {
        public static let PasswordRegex = "[a-zA-Z0-9_]+"
        public static let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }

    public func validate(_ regex: String) -> Bool {
        let pre = NSPredicate(format: "SELF MATCHES %@", regex)
        return pre.evaluate(with: self)
    }
}
