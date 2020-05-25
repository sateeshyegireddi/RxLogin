//
//  Field.swift
//  RxLogin
//
//  Created by Sateesh Yegireddi on 23/05/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol FieldValidatable {
    
    //MARK: - Properties
    var title: String { get }
    var errorMessage: String { get }

    //MARK: - Observables
    var value: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get }

    //MARK: - Validation
    func validate() -> Observable<Bool>
}

//MARK: - Validation -

extension FieldValidatable {
    func validateSize(_ value: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
    func matches(_ value: String, with anotherValue: String) -> Bool {
        return value == anotherValue
    }
}

//MARK: - Secure Field -

protocol SecureFieldValidatable {
    var isSecure: Bool { get }
}
