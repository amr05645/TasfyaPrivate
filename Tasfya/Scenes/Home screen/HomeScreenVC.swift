//
//  HomeScreenVC.swift
//  Tasfya
//
//  Created by Amr on 4/13/21.
//

import UIKit

class HomeScreenVC: BaseVC {
	
	var timer : Timer?
	var currentCellIndex = 0
	
	@IBOutlet weak var adsCollectionView: UICollectionView!
	@IBOutlet weak var pageContrl: UIPageControl!
	@IBOutlet weak var brandsCollectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        showLogo()
        showLanguageBtn()
		adsCollectionView.delegate = self
		adsCollectionView.dataSource = self
		brandsCollectionView.delegate = self
		brandsCollectionView.dataSource = self
		pageContrl.numberOfPages = 5
		register()
		startTimer()
	}
	
	func register() {
		adsCollectionView.register(UINib(nibName: "AdvertiseCell", bundle: nil), forCellWithReuseIdentifier: "AdvertiseCell")
		brandsCollectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "BrandCell")
	}
	
	func startTimer() {
		timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
	}
	
	@objc func moveToNextIndex() {
		currentCellIndex += 1
		adsCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
	}
	
}


extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case adsCollectionView:
			return Int(Int16.max)
		default:
			return 20
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case adsCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertiseCell", for: indexPath) as! AdvertiseCell
			return cell
		case brandsCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
			cell.addproductBtn.isHidden = true
			return cell
		default :
			return UICollectionViewCell()
		}
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case brandsCollectionView:
            let vc = BrandPageVC()
            vc.title = "Brand Name"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		switch collectionView {
		case adsCollectionView:
			return 0
		default:
			return 20
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		switch collectionView {
		case brandsCollectionView:
			return 20
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		switch collectionView {
		case brandsCollectionView:
			return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
		default:
			return UIEdgeInsets()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionView {
		case adsCollectionView:
			return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
		case brandsCollectionView:
			let padding: CGFloat =  20
			let collectionViewSize = collectionView.frame.size.width - padding
			return CGSize(width: collectionViewSize/2, height: (collectionViewSize/2) + 80)
		default:
			return CGSize()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if collectionView == adsCollectionView {
			pageContrl.currentPage = indexPath.row % 5
			currentCellIndex = indexPath.row
		}
	}
	
}
