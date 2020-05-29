//
//  UITextField+Rx.swift
//  RxLogin
//
//  Created by Sateesh Yemireddi on 5/27/20.
//  Copyright © 2020 Company. All rights reserved.
//

import UIKit
import RxSwift

extension UITextField {
    func invoke(next textField: UITextField) -> Disposable {
        return self.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { _ in
                textField.becomeFirstResponder()
            })
    }
}
