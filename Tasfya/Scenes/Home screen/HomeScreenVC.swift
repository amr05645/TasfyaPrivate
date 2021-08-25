//
//  HomeScreenVC.swift
//  Tasfya
//
//  Created by Amr on 4/13/21.
//

import UIKit
import Kingfisher
import ImageSlideshow

class HomeScreenVC: BaseVC {
    
    private var lastContentOffset: CGFloat = 0
    
    var headerShown = true
    
    let localSource = [BundleImageSource(imageString: "SmallPhoneImage"), BundleImageSource(imageString: "SmallMailImage"), BundleImageSource(imageString: "SmallLocationImage"), BundleImageSource(imageString: "SmallGenderImage")]
    
    var categories: Categories?
    
    @IBOutlet weak var advertiseImgSlider: ImageSlideshow!
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        showLogo()
        showLanguageBtn()
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        register()
        addSwipeGesture()
        setupImageSlider()
    }
    
    func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func callPostApi(){
        let url = URL(string: "http://yousry.drayman.co/allCategories")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let parameters = getPostString(params: ["language_id":1])
        request.httpBody = parameters.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data {
                do {
                    let parsedCat = try JSONDecoder().decode(Categories.self, from: data)
                    self.categories = parsedCat
                }
                catch let jsonError
                {
                    print("error serializing json", jsonError)
                }
            }
            DispatchQueue.main.async {
                self.brandsCollectionView.reloadData()
            }
        }
        task.resume()
    }
    
    func register() {
        brandsCollectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "BrandCell")
    }
    
    func setupImageSlider() {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        advertiseImgSlider.pageIndicator = pageIndicator
        advertiseImgSlider.slideshowInterval = 2.5
        advertiseImgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        advertiseImgSlider.pageIndicator?.numberOfPages = localSource.count
        advertiseImgSlider.contentScaleMode = UIViewContentMode.scaleAspectFit
        advertiseImgSlider.delegate = self
        advertiseImgSlider.setImageInputs(localSource)
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
        return categories?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
        let category = categories?.data?[indexPath.row]
        cell.addproductBtn.isHidden = true
        cell.brandNameLbl.text = category?.name
        let completeLink = URL(string: "https://yousry.drayman.co/resources"+"\(String(describing: category?.image))")
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories!.data![indexPath.row]
        let vc = BrandPageVC()
        vc.title = "\(String(describing: category.name!))"
        let completeLink = URL(string: (category.image!))
        vc.detailImg.kf.setImage(with: completeLink)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: (collectionViewSize/2) + 80)
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

extension HomeScreenVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
