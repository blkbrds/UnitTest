//
//  App.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

struct App {

    struct Foursquare {
        static var clienID = "W3FQKXGJIHXNX4ZFT1GX04LC5SRNI5ULAVMQJB4DNIWVM3HJ"
        static var clienSecret = "U1YHLKYWW1MYI3ZNSE3XQKPFHHVEQDOMUPVSDWRLJHDQGUGX"
        static var redirectURI = "http://google.com"
    }
}

struct Google {
    static var apiPublicKey: String { return "publicKey" }
    static var apiSecretKey: String { return "secretKey" }
}

struct Facebook {
    static var apiPublicKey: String { return "publicKey" }
    static var apiSecretKey: String { return "secretKey" }
}
