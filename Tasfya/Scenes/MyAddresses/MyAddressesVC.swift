//
//  MyAddressesVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit
import PKHUD

class MyAddressesVC: BaseVC {
    var customerId : String?
    let baseUrl = "http://yousry.drayman.co/"
    private var picker: UIPickerView?
    private var pickerData = ["Egypt", "Kwait"]
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var countryTF: PickerTF!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zoneTF: UITextField!
    @IBOutlet weak var postCodeTF: UITextField!
    private var AddAddressModel : AddAddresses?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInputPicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCustomerId()

    }
    func getCustomerId(){
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            customerId = userdata.customersID
        }
    }
    
    func setInputPicker() {
        picker = UIPickerView()
        picker?.dataSource = self
        picker?.delegate = self
        countryTF.inputView = picker
//        self.navigationItem.setLeftBarButton(nil, animated: false)
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
        DispatchQueue.main.async {
            //functin to send user address to API
        
            self.sendUserAddress()
            DefaultAddress.login()
            HUD.flash(.success)
            self.firstNameTF.text = nil
            self.lastNameTF.text = nil
            self.addressTF.text = nil
            self.countryTF.text = nil
            self.cityTF.text = nil
        }
    }
    
    // method send user address to backend
    
    func sendUserAddress(){
        let parameter = ["customers_id": self.customerId ?? "" , "entry_firstname" :self.firstNameTF.text! ,"entry_lastname" : self.lastNameTF.text! , "entry_street_address" : self.addressTF.text!,"entry_postcode" : 5, "entry_city" :self.cityTF.text!, "entry_country_id" :  self.countryTF.text!,"entry_zone_id" : 2] as [String : Any]
        
        let service = Service.init(baseUrl: baseUrl)
        service.addAddresses(endPoint: "addShippingAddress",parameter: parameter,  model: "AddAddresses")
        service.completionHandler{[weak self] (category, status, message) in
            
            if status {
                guard let  dataModel = category else {return}
                self?.AddAddressModel = dataModel as? AddAddresses
                print(self?.AddAddressModel ?? 0)
            }
            else{
               print(message)
            }
        }
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        guard dataExist(in: [firstNameTF, lastNameTF, addressTF, countryTF, cityTF]) else {
            showAlert(with: Constants.messages.emptyTF)
            return
        }
        sendReport()
    }
    }

extension MyAddressesVC: UIPickerViewDataSource, UIPickerViewDelegate {
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
