//
//  OrganizationCell.swift
//  sometestapp
//
//  Created by Yuriy on 12.04.2022.
//

import UIKit

final class OrganizationCell: UITableViewCell {
    let logoView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(logoView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            logoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 50),
            logoView.heightAnchor.constraint(equalToConstant: 50),
            logoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
