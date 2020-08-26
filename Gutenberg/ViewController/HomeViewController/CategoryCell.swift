//
//  CategoryCell.swift
//  Gutenberg
//
//  Created by MacMini 20 on 8/26/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//
import UIKit
import SwiftSVG

class CategoryCell: UITableViewCell {

    //MARK: UI Elements
    let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        
        return view
    }()
    
    var logoImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.backgroundColor = .systemPink
        return iv
    }()
    
    let categoryTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.textColor = UIColor(named: Color.DarkGrey.rawValue)
        lbl.font = Font(.installed(.MontserratSemiBold), size: .standard(.h3)).instance
        return lbl
    }()
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: SVGImageName.Next.rawValue))
//        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setUpView()
    }
    
    private func setUpView() {
        addSubview(holderView)
        holderView.addSubview(categoryTitleLabel)
        holderView.addSubview(logoImageView)
        holderView.addSubview(arrowImageView)
    
        holderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        holderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        holderView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        holderView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true

        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoImageView.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 10).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        categoryTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryTitleLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 10).isActive = true
        categoryTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        categoryTitleLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -10).isActive = true
        
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        arrowImageView.rightAnchor.constraint(equalTo: holderView.rightAnchor, constant: -10).isActive = true
        
    }
    
    func setUpData(model: CategoryModel) {
        categoryTitleLabel.text = model.name
        logoImageView.image = UIImage(named: model.imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
