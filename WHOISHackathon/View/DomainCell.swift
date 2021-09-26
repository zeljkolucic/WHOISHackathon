//
//  DomainCell.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 26.9.21..
//

import UIKit

class DomainCell: UITableViewCell {
    
    var title: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: Fonts.mainFontBold, size: 20)
        title.textColor = UIColor(named: "AppBlue")
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var info: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: Fonts.mainFont, size: 16)
        date.textColor = UIColor(named: "AppBlue")
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private let icon: UIImageView = {
        let image = UIImage(systemName: "")
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(title)
        addSubview(info)
        addSubview(icon)
    }
    
    private func setConstraints() {
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        title.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        info.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        info.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        info.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

}
