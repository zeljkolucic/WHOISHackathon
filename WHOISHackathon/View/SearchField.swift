//
//  SearchField.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 26.9.21..
//

import UIKit

class SearchField: UITextField {
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.searchBarPlaceholder, for: .normal)
        button.backgroundColor = UIColor(named: "SearchButtonGreen")
        button.titleLabel?.textColor = UIColor(named: "AppIndigoBlue")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        setupLayout()
        setConstraints()
        
        searchButton.layer.cornerRadius = 10
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLayout() {
        addSubview(searchButton)
    }
    
    func setConstraints() {
        searchButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
