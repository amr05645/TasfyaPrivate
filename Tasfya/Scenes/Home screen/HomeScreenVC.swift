//
//  HomeScreenVC.swift
//  Tasfya
//
//  Created by Amr on 4/13/21.
//

import UIKit

class HomeScreenVC: BaseVC {
    
    private var lastContentOffset: CGFloat = 0
	
	var timer : Timer?
	var currentCellIndex = 0
    
    var headerShown = true
    
    var brandsImgs: [UIImage] = [UIImage(named: "Addidas")!,
                      UIImage(named: "DOLCE-GABBANA")!,
                      UIImage(named: "Gucci")!,
                      UIImage(named: "H&M")!,
                      UIImage(named: "Lcwaikiki")!
    ]
	
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    @IBOutlet weak var adsCollectionView: UICollectionView!
	@IBOutlet weak var pageContrl: UIPageControl!
	@IBOutlet weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var header: UIView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		showLogo()
		showLanguageBtn()
		adsCollectionView.delegate = self
		adsCollectionView.dataSource = self
		brandsCollectionView.delegate = self
		brandsCollectionView.dataSource = self
        pageContrl.numberOfPages = brandsImgs.count
		register()
		startTimer()
		refreshcollectionView()
        addSwipeGesture()
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
	
	func refreshcollectionView() {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refreshment), for: .valueChanged)
		brandsCollectionView.refreshControl = refreshControl
	}
	
	@objc func refreshment(refreshControl: UIRefreshControl) {
		print("refresh done")
		refreshControl.endRefreshing()
	}
    
    func addSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            showHeader()
        }

        if gesture.direction == .up {
            hideHeader()
        }
    }

    func showHeader() {
        guard !headerShown else {return}
        guard brandsCollectionView.contentOffset.y <= 0 else {return}
        headerShown = true
        header.isHidden = false
        headerTop.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.header.layoutIfNeeded()
        })
    }

    func hideHeader() {
        guard headerShown else {return}
        headerShown = false
        header.isHidden = true
        headerTop.constant = -self.header.bounds.height
        UIView.animate(withDuration: 0.5, animations: {
            self.header.layoutIfNeeded()
        })
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
            if indexPath.row < brandsImgs.count {
                cell.brandImgs.image = brandsImgs[indexPath.row]
            }
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
            pageContrl.currentPage = indexPath.row % brandsImgs.count
			currentCellIndex = indexPath.row
		}
	}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

//        #warning("get direction")
        
        if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
            // move down
            showHeader()
        } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            // move up
            hideHeader()
        }

        // update the new position acquired
        lastContentOffset = scrollView.contentOffset.y
    }
	
}
