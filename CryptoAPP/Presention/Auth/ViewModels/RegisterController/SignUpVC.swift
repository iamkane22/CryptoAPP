//
//  SignUpVC.swift
//  CryptoAPP
//
//  Created by Kenan on 01.03.25.
//

import UIKit

final class SignUpVC: BaseVC {
    private var viewModel: SignUpViewModel
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email daxil edin"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Şifrə daxil edin"
        field.isSecureTextEntry = true
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Qeydiyyatdan keç", for: .normal)
        return button
    }()
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, errorLabel, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.requestCallBack = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self?.errorLabel.isHidden = true
                case .success, .loaded:
                    self?.errorLabel.isHidden = true
                case .error(let message):
                    self?.errorLabel.text = message
                    self?.errorLabel.isHidden = false
                }
            }
        }
    }
    
    @objc private func signUpTapped() {
        view.endEditing(true)
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            errorLabel.text = "Email və şifrə boş ola bilməz!"
            errorLabel.isHidden = false
            return
        }
        viewModel.signUp(email: email, password: password)
    }
}
