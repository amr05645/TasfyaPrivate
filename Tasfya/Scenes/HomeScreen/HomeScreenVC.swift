//
//  HomeScreenVC.swift
//  Tasfya
//
//  Created by Amr on 31/08/2021.
//

import UIKit
import ImageSlideshow

class HomeScreenVC: BaseVC {
    
    private var lastContentOffset: CGFloat = 0
    
    let vc = PagingControlVC()
    var getBanners: GetBanners?
    
    var headerShown = true
    var baseUrl = "https://yousry.drayman.co/"
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var advertiseImgSlider: ImageSlideshow!
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPostApi()
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        containerView.constrainToEdges(vc.view)
        addSwipeGesture()
    }
    
    func callPostApi() {
        let languagehandler = LanguageHandler()
        let parameter = [ "language_id" : languagehandler.languageId]
        
        let service = Service.init(baseUrl: baseUrl)
        service.getBanners(endPoint: "getBanners",parameter: parameter,  model: "GetBanners")
        service.completionHandler{ (banners, status, message) in
            
            if status {
                guard let  dataModel = banners else {return}
                self.getBanners = dataModel as? GetBanners
            }
            DispatchQueue.main.async {
                self.setupImageSlider()
            }
        }
    }
    
    func setupImageSlider() {
        let url = baseUrl
        var imagesSources: [KingfisherSource] = []
        guard let data = getBanners?.data else {return}
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
        advertiseImgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 0))
        advertiseImgSlider.activityIndicator = DefaultActivityIndicator()
        advertiseImgSlider.pageIndicator?.numberOfPages = imagesSources.count
        advertiseImgSlider.contentScaleMode = UIViewContentMode.scaleToFill
        advertiseImgSlider.delegate = self
        advertiseImgSlider.setImageInputs(imagesSources)
        
    }
    
    func addSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
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
        //        guard MainScreenVC().mainCollectionView.contentOffset.y <= 0 else {return}
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset > scrollView.contentOffset.y && self.lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
            // move down
            self.showHeader()
        } else if self.lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            // move up
            self.hideHeader()
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
}

extension HomeScreenVC: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
