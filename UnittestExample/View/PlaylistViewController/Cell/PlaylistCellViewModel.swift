//
//  PlaylistCellViewModel.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import MVVM

final class PlaylistCellViewModel: ViewModel {

    private(set) var item: Items

    private var snipet: Snippet {
        return item.snippet
    }

    var path: String {
        return snipet.thumbnails.normal.url
    }

    var title: String {
        return snipet.title
    }

    var description: String {
        return snipet.description
    }

    init(item: Items = Items()) {
        self.item = item
    }
}
