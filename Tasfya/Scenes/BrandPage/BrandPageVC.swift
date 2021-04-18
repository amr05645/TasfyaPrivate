//
//  BrandPageVC.swift
//  Tasfya
//
//  Created by Amr on 4/15/21.
//

import UIKit

class BrandPageVC: BaseVC {
    
    let categories = ["All", "Men", "Women", "Kids"]
    var selectedCellIndexpth = IndexPath(item: 0, section: 0)
	
	@IBOutlet weak var brandImg: UIImageView!
	@IBOutlet weak var ProductCollectionView: UICollectionView!
	@IBOutlet weak var CategoryCollectionView: UICollectionView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        register()
    }
	
	func register() {
		ProductCollectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "BrandCell")
		CategoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
	}
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

extension BrandPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case ProductCollectionView:
			return 20
		case CategoryCollectionView:
            return categories.count
		default:
			return 0
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case ProductCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
			cell.brandNameLbl.text = "Product name"
			return cell
		case CategoryCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categoryLbl.text = categories[indexPath.row]
            cell.isSelected = indexPath.row == 0 ? true : false
			return cell
		default :
			return UICollectionViewCell()
		}
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case ProductCollectionView:
            self.navigationController?.pushViewController(ProductPageVC(), animated: true)
        case CategoryCollectionView:
            if let previousCell = collectionView.cellForItem(at: selectedCellIndexpth) as? CategoryCell {
                previousCell.isSelected = false
            }
            
            selectedCellIndexpth = indexPath
            
            if let currentCell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                currentCell.isSelected = true
            }
        default:
            return
        }
    }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		switch collectionView {
		case ProductCollectionView:
			return 20
		default:
			return 20
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		switch collectionView {
		case ProductCollectionView:
			return 20
		default:
			return 20
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		switch collectionView {
		case ProductCollectionView:
			return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
		default:
			return UIEdgeInsets()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionView {
		case ProductCollectionView:
			let padding: CGFloat =  20
			let collectionViewSize = collectionView.frame.size.width - padding
			return CGSize(width: collectionViewSize/2, height: (collectionViewSize/2) + 80)
		case CategoryCollectionView:
			return CGSize(width: 10, height: 30)
		default:
			return CGSize.zero
		}
	}
}
