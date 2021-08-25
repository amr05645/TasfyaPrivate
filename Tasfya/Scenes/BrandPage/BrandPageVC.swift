//
//  BrandPageVC.swift
//  Tasfya
//
//  Created by Amr on 4/15/21.
//

import UIKit
import Kingfisher

class BrandPageVC: BaseVC {
    
    private var lastContentOffset: CGFloat = 0
    var headerShown = true
    
    var products = [Product]()
    var detailImg = UIImageView()
	var selectedCellIndexpth = IndexPath(item: 0, section: 0)
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    
	@IBOutlet weak var brandImg: UIImageView!
	@IBOutlet weak var ProductCollectionView: UICollectionView!
	@IBOutlet weak var CategoryCollectionView: UICollectionView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
        getData()
		ProductCollectionView.delegate = self
		ProductCollectionView.dataSource = self
		CategoryCollectionView.delegate = self
		CategoryCollectionView.dataSource = self
		register()
        addSwipeGesture()
        brandImg.image = detailImg.image
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
                self.ProductCollectionView.reloadData()
                self.CategoryCollectionView.reloadData()
            }
        }.resume()
        
    }
	
	func register() {
		ProductCollectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "BrandCell")
		CategoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
	}
	
	@IBAction func homeTapped(_ sender: Any) {
		self.navigationController?.popToRootViewController(animated: true)
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
        guard ProductCollectionView.contentOffset.y <= 0 else {return}
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

extension BrandPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case ProductCollectionView:
            return products.count
		case CategoryCollectionView:
            return products.count
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case ProductCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
            cell.brandNameLbl.text = products[indexPath.row].title
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
		case CategoryCollectionView:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categoryLbl.text = products[indexPath.row].category
			cell.isSelected = indexPath.row == 0 ? true : false
			return cell
		default :
			return UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch collectionView {
		case ProductCollectionView:
            let selectedProduct = products[indexPath.row]
            let vc = ProductPageVC()
            vc.detailName = selectedProduct.title!
            vc.newprice = "\((selectedProduct.price)!)"
            let completeLink = URL(string: products[indexPath.row].image!)
            vc.detailImg.kf.setImage(with: completeLink)
			self.navigationController?.pushViewController(vc, animated: true)
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
            return CGSize(width: CategoryCollectionView.frame.width / 5, height: 30)
		default:
			return CGSize.zero
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

        // update the new position acquired
        lastContentOffset = scrollView.contentOffset.y
    }
	
}
