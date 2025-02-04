//
//  TextFieldCorrect.swift
//  MovieApp
//
//  Created by Kenan on 08.01.25.
//
import UIKit

extension UITextField {
    func setErrorBorder() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
    }

    func clearErrorBorder() {
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 1.0
    }
}
