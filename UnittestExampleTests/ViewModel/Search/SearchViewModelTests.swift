//
//  SearchViewModelTests.swift
//  UnittestExampleTests
//
//  Created by Su Nguyen T. on 9/20/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import RxSwift
import RxTest
import Quick
import Nimble
import Alamofire

@testable import UnittestExample

final class SearchViewModelTests: QuickSpec {
    static var result: Result<Categories> = Dummy.successResponse

    override func spec() {
        describe("Test `SearchViewModel`") {
            var scheduler: TestScheduler!
            var viewModel: SearchViewModel!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                viewModel = SearchViewModel(searchApiProtocol: SearchApiMock.self,
                                            scheduler: scheduler)
            }
            context("When call search api", {

                it("have response with json successfully") {
                    SearchViewModelTests.result = Dummy.successResponse
                    let searchKeyObservable: PublishSubject<String> = PublishSubject<String>()
                    let observer = scheduler.createObserver((Result<Any>).self)

                    scheduler.scheduleAt(0, action: {
                        viewModel.configSearchBar(searchBar: searchKeyObservable.asObserver())
                        viewModel.searchCompletion.asObserver()
                        .subscribe(observer)
                        .disposed(by: viewModel.disposeBag)
                    })

                    scheduler.scheduleAt(10, action: {
                        searchKeyObservable.onNext("youtube")
                    })

                    scheduler.start()
                }

                it("have response with failure") {
                    SearchViewModelTests.result = Dummy.failureResponse
                    let searchKeyObservable: PublishSubject<String> = PublishSubject<String>()
                    scheduler.scheduleAt(0, action: {
                        viewModel.configSearchBar(searchBar: searchKeyObservable.asObserver())
                    })

                    scheduler.scheduleAt(10, action: {
                        searchKeyObservable.onNext("youtube")
                    })

                    scheduler.start()
                }
            })

            context("When keysearch is empty", {

                it("No call api so has no result") {
                    let searchKeyObservable: PublishSubject<String> = PublishSubject<String>()

                    scheduler.scheduleAt(0, action: {
                        viewModel.configSearchBar(searchBar: searchKeyObservable.asObserver())
                    })

                    scheduler.scheduleAt(10, action: {
                        searchKeyObservable.onNext("")
                    })

                    scheduler.start()
                }
            })
        }
    }
}

extension SearchViewModelTests {
    struct Dummy {
        static let successResponse: Result<Categories> = .success(Dummy.category)
        static let failureResponse: Result<Categories> = .failure(Api.Error.json)

        static var items: [Items] {
            let item = Items()
            item.id = "youtubeId"
            return [item]
        }

        static var category: Categories {
            let cate = Categories()
            cate.kind = "video"
            cate.items = items
            return cate
        }
    }
}
