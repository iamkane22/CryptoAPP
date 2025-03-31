//  CurrencyController.swift
//  CryptoAPP
//
//  Created by Kenan on 06.02.25.
//

import UIKit

final class CurrencyController: UIViewController {
    private let viewModel: CurrencyVM
    private let currencies = ["BTC", "ETH", "BNB", "XRP", "ADA", "DOGE", "DOT", "SOL"]
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Məbləğ daxil et"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Çevir", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let fromPicker = UIPickerView()
    private let toPicker = UIPickerView()
    
    init(viewModel: CurrencyVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fromPicker.delegate = self
        fromPicker.dataSource = self
        toPicker.delegate = self
        toPicker.dataSource = self
        convertButton.addTarget(self, action: #selector(convertTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [amountTextField, fromPicker, toPicker, convertButton, resultLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func convertTapped() {
        guard let text = amountTextField.text, let amount = Double(text) else {
            resultLabel.text = "Xahiş olunur, məbləğ daxil edin"
            return
        }
        let fromCurrency = currencies[fromPicker.selectedRow(inComponent: 0)]
        let toCurrency = currencies[toPicker.selectedRow(inComponent: 0)]
        
        viewModel.convert(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency) { [weak self] result in
            DispatchQueue.main.async {
                self?.resultLabel.text = result
            }
        }
    }
}

extension CurrencyController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { currencies.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { currencies[row] }
}
