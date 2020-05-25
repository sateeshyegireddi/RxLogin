//
//  FieldType.swift
//  RxLogin
//
//  Created by Sateesh Yegireddi on 23/05/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

enum FieldType {
    case email
    case password
}

//MARK: - Title -

extension FieldType {
    var title: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }
}

//MARK: - Error message -

extension FieldType {
    var errorMessage: String {
        switch self {
        case .email:
            return "Invalid Email"
        case .password:
            return "Invalid Password"
        }
    }
}

//MARK: - Validation Regex -

extension FieldType {
    var validationPattern: String {
        switch self {
        case .email:
            return #"[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\.[A-Za-z]{2,64}"#
        case .password:
            return #"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[*.!@#$%^&(){}\[\]:\";'<>,.?\/~`_+=-])[A-Za-z\d*.!@#$%^&(){}\[\]:\";'<>,.?\/~`_+=-]{8,20}"#
        }
    }
}
