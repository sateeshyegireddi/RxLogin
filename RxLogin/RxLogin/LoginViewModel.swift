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
    var passwordField = Field(of: .password)
    
    // MARK: - RX Properties
    let isLoading = BehaviorRelay(value: false)
    var isSuccess = BehaviorRelay(value: false)
    var errorMessage = BehaviorRelay<String?>(value: nil)
    var isValidationSuccess = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(_ user: User = User()) {
        self.user = user
        self.updateModel()
    }
    
    func updateModel() {
        emailField.value
            .bind { self.user.email = $0 }
            .disposed(by: disposeBag)
        passwordField.value
            .bind { self.user.password = $0 }
            .disposed(by: disposeBag)
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
    
//    func validateFields() {
//        let fields = Observable.from([emailField, passwordField])
//        fields.compactMap { $0.errorValue.value }
//            .bind(to: errorMessage)
//            .disposed(by: disposeBag)
//    }
}

//MARK: - Network -

extension LoginViewModel {
    func login() {
        //TODO: Create a login request and parse response
    }
}
