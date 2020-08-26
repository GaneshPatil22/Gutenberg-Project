//
//  Enum.swift
//  Gutenberg
//
//  Created by MacMini 20 on 8/25/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//


import Foundation

//MARK: Color set
enum Color: String {
    case PrimaryColor
    case SecondaryColor
    case LightGrey
    case Grey
    case DarkGrey
}

//MARK: App Details
enum AppDetail: String {
    case AppName = "Gutenberg Project"
    case AppDescription = "A social cataloging website that allows you to freely search its database of books, annotations, and reviews."
}

//MARK: Image SVG file assets
enum SVGImageName: String {
    case Back
    case Cancel
    case Next
    case Pattern
    case Search
    case Fiction
    case Drama
    case Humour
    case Politics
    case Philosophy
    case History
    case Adventure
}


enum Constants: String {
    case Fiction = "FICTION"
    case Drama = "DRAMA"
    case Humor = "HUMOR"
    case Politics = "POLITICS"
    case Philosophy = "PHOLOSOPHY"
    case History = "HISTORY"
    case Adventure = "ADVENTURE"
}

enum CellIdentifier: String {
    case BookCell
    case CategoryCell
}

enum APIPath : CustomStringConvertible {
    case GetBooks(String, String, Int)
    
    var description : String {
        switch self {
        case .GetBooks(let searchText, let category, let pageNumber): return "http://skunkworks.ignitesol.com:8000/books/?search=\(searchText)&topic=\(category)&mime_type=image%2F&page=\(pageNumber)"
        }
    }
}

enum Messages: String {
    case Ok
    case Fail
    case FailToFetchBooks = "Fail to fetch books"
    case NoFormat = "No viewable version available."
    case NoBooksAvailable = "No Books Available"
}
