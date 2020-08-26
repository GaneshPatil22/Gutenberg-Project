//
//  HomeViewController.swift
//  Gutenberg
//
//  Created by MacMini 20 on 8/25/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//

import UIKit
import SwiftSVG

class HomeViewController: UIViewController {
    
    //MARK: UI Elements
    
    let backgroundView: UIView = {
        let view = SVGView(SVGNamed: SVGImageName.Pattern.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.2
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Font(.installed(.MontserratSemiBold), size: .standard(.h1)).instance
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: Color.PrimaryColor.rawValue)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Font(.installed(.MontserratSemiBold), size: .standard(.h3)).instance
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(named: Color.DarkGrey.rawValue)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let categoryGenreTV: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    //MARK: Constants and variables
    let categories = AppUtil.getCategories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: Color.SecondaryColor.rawValue)
        
        setUpView()
        setUpDelegate()
        setUpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Set up view and its constraints
    private func setUpView() {
        //MARK: Add view
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(categoryGenreTV)
        
        //MARK: Constraints
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        
        categoryGenreTV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryGenreTV.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 15).isActive = true
        categoryGenreTV.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        categoryGenreTV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    //MARK: Set-up delegates
    private func setUpDelegate() {
        categoryGenreTV.delegate = self
        categoryGenreTV.dataSource = self
        categoryGenreTV.register(CategoryCell.self, forCellReuseIdentifier: CellIdentifier.CategoryCell.rawValue)
        
        categoryGenreTV.backgroundColor = .clear
        categoryGenreTV.separatorStyle = .none
        
    }
    
    //MARK: Set-up Data
    private func setUpData() {
        titleLabel.text = AppDetail.AppName.rawValue
        descriptionLabel.text = AppDetail.AppDescription.rawValue
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.CategoryCell.rawValue, for: indexPath) as! CategoryCell
        cell.selectionStyle = .none
        cell.setUpData(model: categories[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BooksViewController(category: categories[indexPath.row].name.lowercased())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
