//
//  MyFavoritesVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class MyFavoritesVC: BaseVC {
    
    @IBOutlet weak var MyFavoritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyFavoritesCollectionView.delegate = self
        MyFavoritesCollectionView.dataSource = self
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()
    }
    
    func register() {
        MyFavoritesCollectionView.register(UINib(nibName: "MainCVCell", bundle: nil), forCellWithReuseIdentifier: "MainCVCell")
    }
    
}

extension MyFavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        cell.likeBtn.setImage(#imageLiteral(resourceName: "likedPhoto"), for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected")
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
    
}
