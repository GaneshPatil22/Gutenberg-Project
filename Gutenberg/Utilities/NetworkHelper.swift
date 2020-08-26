//
//  Enum.swift
//  Gutenberg
//
//  Created by MacMini 20 on 8/25/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//


import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}


class NetworkHelper<T: Codable> {
    static func APICall(_ apiUrl : String,
                      method: String = "GET",
                      resultHandler : @escaping((Result<T, RequestError>) -> Void)) {
        
        ActivityIndicatorHelper.sharedInstance.startLoader()
        let url = URL(string: apiUrl)!
        
        let urlTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                resultHandler(.failure(.clientError))
                ActivityIndicatorHelper.sharedInstance.stopLoader()
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                ActivityIndicatorHelper.sharedInstance.stopLoader()
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                ActivityIndicatorHelper.sharedInstance.stopLoader()
                return
            }

            guard let decodedData: T = ResponseHelper<T>().decodedData(data) else {
                resultHandler(.failure(.dataDecodingError))
                ActivityIndicatorHelper.sharedInstance.stopLoader()
                return
            }
            ActivityIndicatorHelper.sharedInstance.stopLoader()
            resultHandler(.success(decodedData))
        }
        urlTask.resume()
    }
}


open class ResponseHelper<T: Codable> {
    open func decodedData(_ data: Data) -> T? {
        try? JSONDecoder().decode(T.self, from: data)
    }
}
