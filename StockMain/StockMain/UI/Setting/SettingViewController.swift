//
//  SettingViewController.swift
//  StockMain
//
//  Created by Andy on 2022/3/6.
//

import UIKit

class SettingViewController: UIViewController {
    static func new(with viewModel: StockViewModel) -> SettingViewController {
        let vc = UIStoryboard.Main.newInstance(typeName: "SettingViewController") as! SettingViewController
        vc.viewModel = viewModel
        return vc
    }
    
    @IBOutlet weak var timeTextField: UITextField!
    
    private var viewModel = StockViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        timeTextField.delegate = self
        timeTextField.text = "\(Int(viewModel.refreshTime * 1000))"
        timeTextField.keyboardType = .numberPad
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let time = TimeInterval(text) else { return }
        viewModel.refreshTime = time / 1000
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentText = textField.text! + string
        return currentText.count <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        textFieldDidEndEditing(textField)
        return true
    }

}
