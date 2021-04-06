//
//  AddressesVC.swift
//  Tasfya
//
//  Created by Elsaadany on 06/04/2021.
//

import UIKit

class AddressesVC: UIViewController {
    
    var selectedCellIndexpth = IndexPath(item: 0, section: 0)
    
    var addresses = [1, 2, 3, 4, 5]
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        register()
    }
    
    func register() {
        collectionView.register(UINib(nibName: AddressCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: AddressCell.reuseIdentifier)
    }

}

extension AddressesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        addresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCell.reuseIdentifier, for: indexPath) as! AddressCell
        cell.addressNameLabel.text = "\(addresses[indexPath.row])"
        cell.index = indexPath.row
        
        cell.remove = { index in
            self.addresses.remove(at: index)
            collectionView.deleteItems(at: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        
        return CGSize(width: width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let previousCell = collectionView.cellForItem(at: selectedCellIndexpth) as? AddressCell {
            previousCell.isSelected = false
        }
        
        selectedCellIndexpth = indexPath
        
        if let currentCell = collectionView.cellForItem(at: indexPath) as? AddressCell {
            currentCell.isSelected = true
        }
    }
}
