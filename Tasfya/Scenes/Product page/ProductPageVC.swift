//
//  ProductPageVC.swift
//  Tasfya
//
//  Created by Amr on 4/8/21.
//

import UIKit

class ProductPageVC: UIViewController {
	
	@IBOutlet weak var ProductImgCollectionView: UICollectionView!
	@IBOutlet weak var SizeCollectionView: UICollectionView!
	@IBOutlet weak var ColorCollectionView: UICollectionView!
	@IBOutlet weak var PageController: UIPageControl!
	@IBOutlet weak var oldPriceLbl: UILabel!
	@IBOutlet weak var newPriceLbl: UILabel!
	
	@IBAction func addToCartBtn(_ sender: Any) {
		
	}
	
	var timer : Timer?
	var currentCellIndex = 0
	
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
		register()
		startTimer()
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
		if collectionView == ProductImgCollectionView {
			return Int(Int16.max)
		} else if collectionView == SizeCollectionView {
			return 20
		} else if collectionView == ColorCollectionView {
			return 20
		} else {
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == ProductImgCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImgCell", for: indexPath) as! ProductImgCell
			return cell
		} else if collectionView == SizeCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCell", for: indexPath) as! SizeCell
			return cell
		} else if collectionView == ColorCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
			cell.backgroundColor = .red
			return cell
		} else {
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		if collectionView == ProductImgCollectionView {
			return 0
		} else if collectionView == SizeCollectionView {
			return 10
		} else if collectionView == ColorCollectionView {
			return 10
		} else {
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == ProductImgCollectionView {
			return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
		} else if collectionView == SizeCollectionView {
			return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
		} else if collectionView == ColorCollectionView {
			return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
		} else {
			return CGSize()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		PageController.currentPage = indexPath.row % 5
		currentCellIndex = indexPath.row
	}
	
}
