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
                self.setupImageSlider()
            }
        }
        task.resume()
    }
    
    func register() {
        brandsCollectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "BrandCell")
    }
    
    func setupImageSlider() {
        let url = "http://yousry.drayman.co/"
        var imagesSources: [KingfisherSource] = []
        guard let data = categories?.data else {return}
        for item in data {
            let imageUrl = item.image ?? ""
            let finalUrl = url + imageUrl
            guard let completeLink = URL(string: finalUrl ) else {return}
            imagesSources.append(KingfisherSource(url: completeLink))
        }
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = #colorLiteral(red: 0.07058823529, green: 0.1019607843, blue: 0.3137254902, alpha: 1)
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        advertiseImgSlider.pageIndicator = pageIndicator
        advertiseImgSlider.slideshowInterval = 2.5
        advertiseImgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        advertiseImgSlider.activityIndicator = DefaultActivityIndicator()
        advertiseImgSlider.pageIndicator?.numberOfPages = imagesSources.count
        advertiseImgSlider.contentScaleMode = UIViewContentMode.scaleToFill
        advertiseImgSlider.delegate = self
        advertiseImgSlider.setImageInputs(imagesSources)
        
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
        let url = "http://yousry.drayman.co/"
        let imageURL = category?.image ?? ""
        let finalUrl = url + imageURL
        let completeLink = URL(string: finalUrl )
        cell.brandLogoImg.kf.setImage(with: completeLink)
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
        let masterUrl = "http://yousry.drayman.co/"
        let iconURL = category?.icon ?? ""
        let finalIconUrl = masterUrl + iconURL
        let completeIconLink = URL(string: finalIconUrl )
        cell.brandLogoImg.kf.setImage(with: completeIconLink)
        cell.brandLogoImg.kf.setImage(with: completeIconLink)
        let process = DownsamplingImageProcessor(size: cell.brandPhotoImg.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.brandPhotoImg.kf.indicatorType = .activity
        cell.brandPhotoImg.kf.setImage(
            with: completeLink,
            placeholder: nil,
            options: [
                .processor(process),
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
        let url = "http://yousry.drayman.co/"
        let imageURL = category.image ?? ""
        let finalUrl = url + imageURL
        let completeLink = URL(string: finalUrl )
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
