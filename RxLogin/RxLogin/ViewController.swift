//
//  ViewController.swift
//  RxLogin
//
//  Created by Sateesh Yegireddi on 23/05/20.
//  Copyright © 2020 Company. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private var loginViewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bindViewModelWithUIElements()
    }
}

//MARK: - Binding -

extension ViewController {
    func bindViewModelWithUIElements() {
        bind(text: loginViewModel.emailField.value,
             to: emailTextField,
             error: loginViewModel.emailField.errorValue,
             to: emailErrorLabel)
        
        bind(text: loginViewModel.passwordField.value,
             to: passwordTextField,
             error: loginViewModel.passwordField.errorValue,
             to: passwordErrorLabel)
        
        loginViewModel.isValidationSuccess
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(onNext: { _ in
                self.view.endEditing(true)
                self.loginViewModel.login()
            })
            .disposed(by: disposeBag)
        
        emailTextField
            .invoke(next: passwordTextField)
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                self.backgroundScrollView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: disposeBag)
        

//        loginViewModel.errorMessage.bind { error in
//            self.showAlert(title: "RxLogin",
//                           message: error,
//                           style: .alert,
//                           actions: [.action(title: "OK")])
//                .subscribe(onNext: { index in
//                    print("OK Button Tapped!")
//                }).disposed(by: disposeBag)
//        }.disposed(by: disposeBag)
    }
    
    func bind(text: BehaviorRelay<String>,
              to field: UITextField,
              error: BehaviorRelay<String?>,
              to label: UILabel) {
        field.rx.text
            .orEmpty
            .bind(to: text)
            .disposed(by: disposeBag)
        field.rx.text
            .map { ($0 ?? "").count <= 0 }
            .bind(to: label.rx.isHidden)
            .disposed(by: disposeBag)
        error.bind(to: label.rx.text)
            .disposed(by: disposeBag)
        field.rx.controlEvent([.editingChanged])
            .bind { self.loginViewModel.validateFields() }
            .disposed(by: disposeBag)
    }
}
