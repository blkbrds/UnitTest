//
//  CategoriesCellViewModel.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import MVVM

final class CategoriesCellViewModel: ViewModel {

    private(set) var item: Dynamic<Items>

    var snipet: Snippet {
        return item.value.snippet
    }

    init(item: Items = Items()) {
        self.item = Dynamic(item)
    }
}
