//
//  fetchData.swift
//  phw14-2-json-decode
//
//  Created by jasonhung on 2023/12/20.
//

import Foundation

func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("取得 JSON 時發生錯誤:", error?.localizedDescription ?? "未知錯誤")
            completion(nil)
            return
        }
        completion(data)
    }.resume()
}

func fetchDataAuthorization(from url: URL, completion: @escaping (Data?) -> Void) {
    
    var request = URLRequest(url: url)
    request.setValue("Bearer \(AirtablePersonAccessKey)", forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("取得 JSON 時發生錯誤:", error?.localizedDescription ?? "未知錯誤")
            completion(nil)
            return
        }
        completion(data)
    }.resume()
}





