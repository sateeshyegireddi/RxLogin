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

struct Field: FieldValidatable {
    var type: FieldType
    private(set) var title: String = ""
    private(set) var errorMessage: String = ""
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    init(of type: FieldType) {
        self.type = type
        self.title = type.title
        self.errorMessage = type.errorMessage
    }
    
    func validate() -> Observable<Bool> {
        guard validateString(value.value, pattern: type.validationPattern) else {
            errorValue.accept(errorMessage)
            return Observable<Bool>.just(false)
        }
        errorValue.accept(nil)
        return Observable<Bool>.just(true)
    }
}
