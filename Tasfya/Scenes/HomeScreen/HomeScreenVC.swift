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
    //    let mainScreenVC = MainScreenVC()
    var getBanners: GetBanners?
    
    var headerShown = true
    let pageview = PagingControlVC()
    
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
    
    func callPostApi(){
        let url = URL(string: "http://yousry.drayman.co/getBanners")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data {
                do {
                    let parsedCat = try JSONDecoder().decode(GetBanners.self, from: data)
                    self.getBanners = parsedCat
                }
                catch let jsonError
                {
                    print("error serializing json", jsonError)
                }
            }
            DispatchQueue.main.async {
                self.setupImageSlider()
            }
        }
        task.resume()
    }
    
    func setupImageSlider() {
        let url = "http://yousry.drayman.co/"
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
        //                guard mainScreenVC.mainCollectionView.contentOffset.y <= 0 else {return}
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
