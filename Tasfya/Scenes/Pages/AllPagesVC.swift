//
//  AllPagesVC.swift
//  Tasfya
//
//  Created by BMS on 12/10/2021.
//

import UIKit

class AllPagesVC: UIViewController {
    @IBOutlet weak var pagesTV: UITextView!
    var pageNo = 0
    let baseUrl = "https://yousry.drayman.co/"
    var pagesModel : Pages?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pageNo)
        
        callPostApi()
    }

    func callPostApi(){
        let languagehandler = LanguageHandler()
        let parameter = ["language_id": languagehandler.languageId]
        let service = Service.init(baseUrl: baseUrl)
        service.getAllPages(endPoint: "getAllPages",parameter: parameter as [String : Any],  model: "AllPages")
        service.completionHandler{[weak self] (category, status, message) in
            if status {
                guard let  dataModel = category else {return}
                self?.pagesModel = dataModel as? Pages
                print(self?.pagesModel ?? 0)
                self?.setTextView()
                
            }
        }
    }
    
    func setTextView() {
        switch pageNo {
        case 1 :
            let data = pagesModel?.pagesData?[0].pagesDatumDescription
            pagesTV.attributedText = data?.htmlAttributedString()
            break
        
        case 2:
            let data = pagesModel?.pagesData?[1].pagesDatumDescription
            pagesTV.attributedText = data?.htmlAttributedString()
            break
            
        case 3 :
            let data = pagesModel?.pagesData?[2].pagesDatumDescription
            pagesTV.attributedText = data?.htmlAttributedString()
            break
            
        case 4 :
            let data = pagesModel?.pagesData?[3].pagesDatumDescription
            pagesTV.attributedText = data?.htmlAttributedString()
            break
        
        default:
            return
        }
    }
    
    
    
}


