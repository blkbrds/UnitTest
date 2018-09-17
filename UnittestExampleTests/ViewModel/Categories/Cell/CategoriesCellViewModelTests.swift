//
//  CategoriesCellViewModelTests.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Quick
import Nimble

@testable import UnittestExample

final class CategoriesCellViewModelTests: QuickSpec {

    override func spec() {
        var viewModel: CategoriesCellViewModel!

        context("When cell's properties have value") {

            beforeEach {
                viewModel = CategoriesCellViewModel(item: Dummy.items)
            }

            it("The properties should be valid value") {
                expect(viewModel.snipet.assignable) == true
                expect(viewModel.snipet.channelId) == "UCBR8-60-B28hp2BmDPdntcQ"
                expect(viewModel.snipet.channelTitle) == "Film & Animation"
            }
        }
    }
}

extension CategoriesCellViewModelTests {

    struct Dummy {
        static var items: Items {
            let item = Items()
            item.etag = "\"XI7nbFXulYBIpL0ayR_gDh3eu1k/Xy1mB4_yLrHy_BmKmPBggty2mZQ\""
            item.id = "1"
            item.kind = "youtube#videoCategory"
            item.snippet = snippet
            return item
        }

        static var snippet: Snippet {
            let snippet = Snippet()
            snippet.assignable = true
            snippet.channelId = "UCBR8-60-B28hp2BmDPdntcQ"
            snippet.channelTitle = "Film & Animation"
            return snippet
        }
    }
}
