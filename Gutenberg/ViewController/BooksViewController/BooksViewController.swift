//
//  BooksViewController.swift
//  Gutenberg
//
//  Created by MacMini 20 on 8/26/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    //MARK: UI Elements
    let booksCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()        
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    let noDataLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = Messages.NoBooksAvailable.rawValue
        lbl.font = Font(.installed(.MontserratSemiBold), size: .standard(.h2)).instance
        lbl.textColor = UIColor(named: Color.Grey.rawValue)
        lbl.isHidden = true
        return lbl
    }()
    
    //MARK: Variables and constants
    var booksModel: BooksModel?
    var books: [BookModel] = []
    var pageNumber = 1
    var isFetchInProgress = false
    var totalBooks: Int?
    var category: String = ""
    var searchText: String = ""
    
    init(category: String) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpNavigationBar()
        setUpView()
        setUpDelegates()
        customiseSearchBar()
        fetchAllBooks()
    }
    
    private func setUpNavigationBar() {
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        navigationController?.navigationBar.isTranslucent = false
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        let label = UILabel(frame: CGRect(x: 30, y: 7, width: 190, height: 35))
        label.font = Font(.installed(.MontserratSemiBold), size: .standard(.h2)).instance
        label.textColor = UIColor(named: Color.PrimaryColor.rawValue)
        
        if let imgBackArrow = UIImage(named: SVGImageName.Back.rawValue) {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
        view.addSubview(label)
        label.text = category.capitalized
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view )
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpView() {
        
        view.addSubview(booksCollectionView)
        view.addSubview(searchBar)
        view.addSubview(noDataLabel)
        
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        booksCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15).isActive = true
        booksCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        booksCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        noDataLabel.centerXAnchor.constraint(equalTo: booksCollectionView.centerXAnchor).isActive = true
        noDataLabel.centerYAnchor.constraint(equalTo: booksCollectionView.centerYAnchor).isActive = true
    }
    
    private func setUpDelegates() {
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
        booksCollectionView.prefetchDataSource = self
        
        searchBar.delegate = self
        
        booksCollectionView.register(BookCell.self, forCellWithReuseIdentifier: CellIdentifier.BookCell.rawValue)
        booksCollectionView.backgroundColor = UIColor(named: Color.SecondaryColor.rawValue)
    }
    
    private func customiseSearchBar() {
        searchBar.barTintColor = UIColor(named: Color.SecondaryColor.rawValue)
        searchBar.isTranslucent = false
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.font = Font(.installed(Font.FontName.MontserratRegular), size: .standard(Font.StandardSize.h4)).instance
        textFieldInsideSearchBar?.textColor = UIColor(named: Color.DarkGrey.rawValue)
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.font = Font(.installed(Font.FontName.MontserratRegular), size: .standard(Font.StandardSize.h4)).instance
        textFieldInsideSearchBarLabel?.textColor = UIColor(named: Color.Grey.rawValue)
        
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = UIImage(named: SVGImageName.Search.rawValue)
    }
    
    private func fetchAllBooks() {
        
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        NetworkHelper<BooksModel>.APICall(APIPath.GetBooks(searchText, category, pageNumber).description) { [weak self] result in
            switch result {
            case .failure(let err):
                self?.isFetchInProgress = false
                AppUtil.showMessage("\(Messages.FailToFetchBooks.rawValue) \(err.localizedDescription)", messageTitle: Messages.Fail.rawValue , buttonTitle: Messages.Ok.rawValue)
            case .success(let model):
                self?.isFetchInProgress = false
                self?.booksModel = model
                DispatchQueue.main.async {
                    self?.noDataLabel.isHidden = !(model.count == 0)
                    self?.isFetchInProgress = false
                    self?.totalBooks = model.count
                    self?.books += self?.booksModel?.results ?? []
                    if (self?.pageNumber ?? 1) > 1 {
                        let indexPathsToReload = self?.calculateIndexPathsToReload(from: model.results)
                        self?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self?.onFetchCompleted(with: .none)
                    }
                    self?.pageNumber += 1
                }
            }
        }
    }
    
    private func openUrl(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}

extension BooksViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.fetchAllBooks()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.BookCell.rawValue, for: indexPath) as! BookCell
        let model = books[indexPath.row]
        cell.setUpData(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookFormat = books[indexPath.row].formats
        if let url = bookFormat.textHTML {
            openUrl(url: url)
        } else if let url = bookFormat.applicationPDF {
            openUrl(url: url)
        } else if let url = bookFormat.textPlain {
            openUrl(url: url)
        } else {
            AppUtil.showMessage(Messages.NoFormat.rawValue, messageTitle: "", buttonTitle: Messages.Ok.rawValue)
        }
    }
    
}

//MARK: Pagination
extension BooksViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (books.count - 20)
    }
    
    private func calculateIndexPathsToReload(from newBooks: [BookModel]) -> [IndexPath] {
        let startIndex = books.count - newBooks.count
        let endIndex = startIndex + newBooks.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        booksCollectionView.reloadData()
    }
}
//MARK: Search bar intigration
extension BooksViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        books = []
        pageNumber = 1
        fetchAllBooks()
    }
}
