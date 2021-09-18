//
//  MainCVCell.swift
//  Tasfya
//
//  Created by Amr on 31/08/2021.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    var likesModel: LikesModel?
    
    var baseUrl = "https://yousry.drayman.co/"
    
    let likedImg = #imageLiteral(resourceName: "likedPhoto")
    let unlikeImg = #imageLiteral(resourceName: "unlikePhoto")
    var notSelected = true
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var brandNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func callPostApi() {
        
//        guard let likesData = likesModel?.productData else { return }
        
        let parameter = ["liked_products_id": 1, "liked_customers_id": 1]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getLikes(endPoint: "likeProduct",parameter: parameter,  model: "LikesModel")
        service.completionHandler{ (products, status, message) in
            
            if status {
                guard let  dataModel = products else {return}
                self.likesModel = dataModel as? LikesModel
            }
        }
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        if notSelected {
            likeBtn.setImage(likedImg, for: .normal)
            callPostApi()
            
        } else {
            likeBtn.setImage(unlikeImg, for: .normal)
        }
        notSelected = !notSelected
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
    }
    
}
