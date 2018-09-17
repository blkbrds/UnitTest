//
//  PlaylistCellViewModelTests.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Quick
import Nimble

@testable import UnittestExample

final class PlaylistCellViewModelTests: QuickSpec {

    override func spec() {
        var viewModel: PlaylistCellViewModel!

        context("When cell's properties have value") {

            beforeEach {
                viewModel = PlaylistCellViewModel(item: Dummy.items)
            }

            it("The properties should be valid value") {
                expect(viewModel.path) == "https://i.ytimg.com/vi/EPjhpXTpHjs/default.jpg"
                expect(viewModel.title) == "ABC"
                expect(viewModel.description) == "Test Data"
            }
        }
    }
}

extension PlaylistCellViewModelTests {

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
            snippet.title = "ABC"
            snippet.description = "Test Data"
            snippet.thumbnails = thumbnail
            return snippet
        }

        static var thumbnail: Thumbnails {
            let thumbnail = Thumbnails()
            thumbnail.normal = path
            return thumbnail
        }

        static var path: Path {
            let path = Path()
            path.url = "https://i.ytimg.com/vi/EPjhpXTpHjs/default.jpg"
            path.width = 120
            path.height = 90
            return path
        }
    }
}
