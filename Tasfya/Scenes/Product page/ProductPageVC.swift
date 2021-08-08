//
//  ProductPageVC.swift
//  Tasfya
//
//  Created by Amr on 4/8/21.
//

import UIKit
import RealmSwift

class ProductPageVC: BaseVC {
	
    var count: Int? {
        didSet {
            amountLbl.text = "\(count ?? 0)"
        }
    }
	
	var max = 10
	
	@IBOutlet weak var ProductImgCollectionView: UICollectionView!
	@IBOutlet weak var SizeCollectionView: UICollectionView!
	@IBOutlet weak var ColorCollectionView: UICollectionView!
	@IBOutlet weak var PageController: UIPageControl!
	@IBOutlet weak var productNameLbl: UILabel!
	@IBOutlet weak var oldPriceLbl: UILabel!
	@IBOutlet weak var newPriceLbl: UILabel!
	@IBOutlet weak var detailsLabel: UILabel!
	@IBOutlet weak var amountLbl: UILabel!
	
	var timer : Timer?
	var currentCellIndex = 0
    
    var detailName = ""
    var newprice = ""
    var detailImg = UIImageView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.edgesForExtendedLayout = []
		ProductImgCollectionView.delegate = self
		ProductImgCollectionView.dataSource = self
		SizeCollectionView.delegate = self
		SizeCollectionView.dataSource = self
		ColorCollectionView.delegate = self
		ColorCollectionView.dataSource = self
		PageController.numberOfPages = 5
		count = 1
		amountLbl.text = "\(count ?? 0)"
		register()
		startTimer()
        detailsLabel.text = detailName
        productNameLbl.text = detailName
        newPriceLbl.text = newprice
        let language = LanguageHandler.getLanguage()
        detailsLabel.textAlignment = language == .ar ? .right : .left
	}
	
	@IBAction func minCountBtn(_ sender: Any) {
		guard count! > 1 else {return}
				count! -= 1
	}
	
	@IBAction func addCountBtn(_ sender: Any) {
		guard count! < max else {return}
				count! += 1
	}
	
	@IBAction func addToCartBtn(_ sender: Any) {
	}
	
	func register() {
		ProductImgCollectionView.register(UINib(nibName: "ProductImgCell", bundle: nil), forCellWithReuseIdentifier: "ProductImgCell")
		SizeCollectionView.register(UINib(nibName: "SizeCell", bundle: nil), forCellWithReuseIdentifier: "SizeCell")
		ColorCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
	}
	
	func startTimer() {
		timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
	}
	
	@objc func moveToNextIndex() {
		currentCellIndex += 1
		ProductImgCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
	}
	
}


extension ProductPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case ProductImgCollectionView:
			return Int(Int16.max)
		case SizeCollectionView:
			return 20
		case ColorCollectionView:
			return 20
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case ProductImgCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImgCell", for: indexPath) as! ProductImgCell
            cell.productPhoto.image = detailImg.image
			return cell
		case SizeCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCell", for: indexPath) as! SizeCell
			return cell
		case ColorCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
			cell.backgroundColor = .red
			return cell
		default:
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		switch collectionView {
		case ProductImgCollectionView:
			return 0
		case SizeCollectionView:
			return 10
		case ColorCollectionView:
			return 10
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionView {
		case ProductImgCollectionView:
			return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
		case SizeCollectionView:
			return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
		case ColorCollectionView:
			return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
		default:
			return CGSize()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		switch collectionView {
		case ProductImgCollectionView:
			PageController.currentPage = indexPath.row % 5
			currentCellIndex = indexPath.row
		default:
			return
		}
	}
	
}
