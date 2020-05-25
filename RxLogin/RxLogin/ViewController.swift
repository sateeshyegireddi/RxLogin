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

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel : UILabel!
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
            .bind(to: label.rx.isHidden )
            .disposed(by: disposeBag)
        error.bind(to: label.rx.text)
            .disposed(by: disposeBag)
        field.rx.controlEvent([.editingChanged])
            .bind { self.loginViewModel.validateFields() }
            .disposed(by: disposeBag)
    }
}
