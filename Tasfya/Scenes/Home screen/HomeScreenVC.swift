//
//  HomeScreenVC.swift
//  Tasfya
//
//  Created by Amr on 4/13/21.
//

import UIKit
import Kingfisher

class HomeScreenVC: BaseVC {
    
    private var lastContentOffset: CGFloat = 0
	
	var timer : Timer?
	var currentCellIndex = 0
    
    var headerShown = true
    
    var products = [Product]()
	
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    @IBOutlet weak var adsCollectionView: UICollectionView!
	@IBOutlet weak var pageContrl: UIPageControl!
	@IBOutlet weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var header: UIView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        getData()
		showLogo()
		showLanguageBtn()
		adsCollectionView.delegate = self
		adsCollectionView.dataSource = self
		brandsCollectionView.delegate = self
		brandsCollectionView.dataSource = self
        pageContrl.translatesAutoresizingMaskIntoConstraints = false
        pageContrl.numberOfPages = 5
		register()
		startTimer()
		refreshcollectionView()
        addSwipeGesture()
	}
    
    func getData() {
        let jsonUrlString = "https://fakestoreapi.com/products"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                self.products = try JSONDecoder().decode([Product].self, from: data)
            }
            catch let jsonError
            {
                print("error serializing json", jsonError)
            }
            DispatchQueue.main.async {
                self.brandsCollectionView.reloadData()
            }
        }.resume()
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
            return products.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case adsCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertiseCell", for: indexPath) as! AdvertiseCell
            if indexPath.row < products.count   {
                let completeLink = URL(string: products[indexPath.row].image!)
                cell.brandImgs.kf.setImage(with: completeLink)
                let processor = DownsamplingImageProcessor(size: cell.brandImgs.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 20)
                cell.brandImgs.kf.indicatorType = .activity
                cell.brandImgs.kf.setImage(
                    with: completeLink,
                    placeholder: nil,
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            } else {
                currentCellIndex = 0
            }
            return cell
		case brandsCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
			cell.addproductBtn.isHidden = true
            cell.brandNameLbl.text = products[indexPath.row].category
            let completeLink = URL(string: products[indexPath.row].image!)
            cell.brandPhotoImg.kf.setImage(with: completeLink)
            let processor = DownsamplingImageProcessor(size: cell.brandPhotoImg.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            cell.brandPhotoImg.kf.indicatorType = .activity
            cell.brandPhotoImg.kf.setImage(
                with: completeLink,
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            cell.newPriceLbl.text = "\((products[indexPath.row].price)!)"
			return cell
		default :
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch collectionView {
		case brandsCollectionView:
			let vc = BrandPageVC()
            vc.title = "\((products[indexPath.row].category)!)"
            let completeLink = URL(string: products[indexPath.row].image!)
            vc.detailImg.kf.setImage(with: completeLink)
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
            pageContrl.currentPage = indexPath.row
			currentCellIndex = indexPath.row
		}
	}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
            // move down
            showHeader()
        } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            // move up
            hideHeader()
        }
        lastContentOffset = scrollView.contentOffset.y
    }
}
