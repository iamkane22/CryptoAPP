//
//  LoginController.swift
//  CryptoAPP
//
//  Created by Kenan on 27.02.25.
//

import UIKit

final class LoginController: BaseVC {
    private var viewModel: LoginViewModel
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email daxil edin"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Şifrə daxil edin"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş", for: .normal)
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Google ilə Giriş", for: .normal)
        return button
    }()
    
    // Qeydiyyata keçid düyməsi
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hesabınız yoxdur? Qeydiyyatdan keçin", for: .normal)
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) implement edilməyib")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField,
                                                       errorLabel,
                                                       loginButton,
                                                       googleButton,
                                                       signUpButton])
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
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
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
    
    @objc private func loginTapped() {
        view.endEditing(true)
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    @objc private func googleTapped() {
        AuthManager.shared.signInWithGoogle(presenting: self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Google ilə giriş uğurlu: \(user.email ?? "Email yoxdur")")
                    self?.viewModel.requestCallBack?(.success)
                    self?.viewModel.navigation?.showHome()
                case .failure(let error):
                    self?.viewModel.requestCallBack?(.error(error.localizedDescription))
                }
            }
        }
    }
    
    @objc private func signUpTapped() {
        viewModel.navigation?.showAuth()
    }
}
