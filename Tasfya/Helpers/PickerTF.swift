//
//  PickerTF.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import UIKit

class PickerTF: UITextField {
    
    var didSelect: ((String?) -> ())?
    var changeLanguage: (() -> ())?
    
    private var picker: UIPickerView?
    private var shadowLayer: CAShapeLayer!
    private var pickerData: [String]? {
        didSet {
            picker?.reloadComponent(0)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPicker()
    }
    
    func setInputPickerData(to data: [String]) {
        pickerData = data
    }
    
    private func setupPicker() {
        picker = UIPickerView()
        picker?.dataSource = self
        picker?.delegate = self
        self.inputView = picker
        setToolbar()
    }
    
    private func setToolbar() {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: Constants.titles.done, style: .plain, target: self, action: #selector(doneAction))
        done.tintColor = #colorLiteral(red: 0.07100000232, green: 0.1019999981, blue: 0.3140000105, alpha: 1)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: Constants.titles.cancel, style: .plain, target: self, action: #selector(cancelAction))
        cancel.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        bar.items = [cancel, spacer, done]
        bar.sizeToFit()
        self.inputAccessoryView = bar
    }
    
    @objc private func doneAction() {
        guard let picker = picker else {return}
        let selectedTitle = pickerData?[picker.selectedRow(inComponent: 0)] ?? ""
        self.text = selectedTitle
        self.changeLanguage?()
        self.didSelect?(selectedTitle)
        self.resignFirstResponder()
    }
    
    @objc private func cancelAction() {
        self.resignFirstResponder()
    }
}

//MARK:- UIPickerViewDataSource, UIPickerViewDelegate
extension PickerTF: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData?[row] ?? ""
    }
}
