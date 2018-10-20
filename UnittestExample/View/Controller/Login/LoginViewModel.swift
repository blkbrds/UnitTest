//
//  LoginViewModel.swift
//  Tutorial
//
//  Created by Hai Nguyen H.P. on 12/26/17.
//  Copyright © 2017 Hai Nguyen H.P. All rights reserved.
//

import MVVM

final class LoginViewModel: MVVM.ViewModel {
    enum Field: String {
        case email
        case password
    }
}
