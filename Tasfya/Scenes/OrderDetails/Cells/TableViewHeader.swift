//
//  TableViewHeader.swift
//  Tasfya
//
//  Created by Amr on 12/09/2021.
//

import Foundation
import UIKit

class SectionHeader: UIView {
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    var button: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "darkEditicon"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("button Tapped")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
