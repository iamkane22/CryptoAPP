//
//  AlertExtension.swift
//  MovieApp
//
//  Created by Kenan on 08.01.25.
//

import UIKit

extension UIViewController {
    func showCustomAlert(title: String, message: String, buttonTitle: String = "OK", buttonColor: UIColor = UIColor.systemBlue, completion: (() -> Void)? = nil) {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        backgroundView.alpha = 0
        view.addSubview(backgroundView)
        
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 16
        alertView.layer.shadowColor = UIColor.black.cgColor
        alertView.layer.shadowOpacity = 0.1
        alertView.layer.shadowOffset = CGSize(width: 0, height: 2)
        alertView.layer.shadowRadius = 4
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .darkGray
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(messageLabel)
        
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = buttonColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(button)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -16)
        ])
        
        button.addAction(UIAction(handler: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                backgroundView.alpha = 0
                alertView.alpha = 0
            }, completion: { _ in
                backgroundView.removeFromSuperview()
                alertView.removeFromSuperview()
                completion?()
            })
        }), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.3) {
            backgroundView.alpha = 1
        }
    }
}
