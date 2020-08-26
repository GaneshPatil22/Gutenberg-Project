//
//  ThemeCell.swift
//  StockStocker
//
//  Created by MacMini 20 on 8/13/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {

    let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImageView: CusomImageView = {
        let iv = CusomImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let aurthorNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = Font(.installed(.MontserratRegular), size: .standard(.h5)).instance
        lbl.textColor = UIColor(named: Color.Grey.rawValue)
        return lbl
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        lbl.font = Font(.installed(.MontserratRegular), size: .standard(.h5)).instance
        lbl.textColor = UIColor(named: Color.DarkGrey.rawValue)
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(holderView)
        holderView.addSubview(logoImageView)
        holderView.addSubview(titleLabel)
        holderView.addSubview(aurthorNameLabel)

        holderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        holderView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        holderView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: aurthorNameLabel.topAnchor, constant: -2).isActive = true
        
        logoImageView.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 136).isActive = true
        logoImageView.leftAnchor.constraint(equalTo: holderView.leftAnchor).isActive = true
        logoImageView.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        
        aurthorNameLabel.leftAnchor.constraint(equalTo: holderView.leftAnchor).isActive = true
        aurthorNameLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true

        
    }
    
    func setUpData(model: BookModel) {
        titleLabel.text = model.title
        aurthorNameLabel.text = model.authors.first?.name
        setUpImage(url: model.formats.imageJPEG)
    }
    
    func setUpImage(url: String?) {
        
        if let imageURL = url {
            logoImageView.setUpImage(using: imageURL)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
