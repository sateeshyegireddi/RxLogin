//
//  LoginViewModel.swift
//  RxLogin
//
//  Created by Sateesh Yegireddi on 23/05/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    
    // MARK: - Properties
    var user = User()
    var emailField = Field(of: .email)
    var passwordField = Field(of: .password, isSecure: true)
    
    // MARK: - RX Properties
    let isLoading = BehaviorRelay(value: false)
    var isSuccess = BehaviorRelay(value: false)
    var errorMessage = BehaviorRelay<String?>(value: nil)
    var isValidationSuccess = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(_ user: User = User()) {
        self.user = user
    }
}

// MARK: - Validation -

extension LoginViewModel {
    func validateFields() {
        let fields = [emailField, passwordField]
        let validations = fields.map { $0.validate() }
        Observable.combineLatest(validations) { validation in
            validation.reduce(true) { $0 && $1 }
        }
        .bind(to: isValidationSuccess)
        .disposed(by: disposeBag)
    }
}

//MARK: - Network -

extension LoginViewModel {
    func login() {
        //TODO: Create a login request and parse response
    }
}
