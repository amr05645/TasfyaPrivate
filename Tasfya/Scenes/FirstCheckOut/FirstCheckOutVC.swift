//
//  FirstCheckOutVC.swift
//  Tasfya
//
//  Created by Amr on 09/09/2021.
//

import UIKit
import PKHUD

class FirstCheckOutVC: BaseVC {
    
    private var picker: UIPickerView?
    private var pickerData = ["Egypt", "Kwait"]
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var countryTF: PickerTF!
    @IBOutlet weak var cityTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setLeftBarButton(nil, animated: false)
        setInputPicker()
    }
    
    func setInputPicker() {
        picker = UIPickerView()
        picker?.dataSource = self
        picker?.delegate = self
        countryTF.inputView = picker
        self.navigationItem.setLeftBarButton(nil, animated: false)
        setToolbar()
    }
    
    func setToolbar() {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: Constants.titles.done, style: .plain, target: self, action: #selector(doneAction))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: Constants.titles.cancel, style: .plain, target: self, action: #selector(cancelAction))
        bar.items = [cancel, spacer, done]
        bar.sizeToFit()
        countryTF.inputAccessoryView = bar
    }
    
    @objc func doneAction() {
        guard let picker = picker else {return}
        countryTF.text = pickerData[picker.selectedRow(inComponent: 0)]
        countryTF.resignFirstResponder()
    }
    
    @objc func cancelAction() {
        countryTF.resignFirstResponder()
    }
    
    func sendReport() {
        self.showProgress()
        self.hideProgress()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        self.navigationController?.pushViewController(SecondCheckOutVC(), animated: true)
    }
    
}

extension FirstCheckOutVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.countryTF.text = pickerData[row]
    }
}