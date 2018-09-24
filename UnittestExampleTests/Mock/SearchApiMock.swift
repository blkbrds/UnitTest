//
//  SearchApiMock.swift
//  UnittestExampleTests
//
//  Created by Su Nguyen T. on 9/20/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

@testable import UnittestExample

final class SearchApiMock: SearchProtocol {
    static func search(keySearch: String) -> Observable<Result<Categories>> {
        return Observable.create({ (observer) -> Disposable in
            observer.onNext(SearchViewModelTests.result)
            return Disposables.create()
        })
    }
}
