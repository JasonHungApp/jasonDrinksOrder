//
//  fetchOrderDetail.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2023/12/31.
//

import Foundation



// 函數用於從指定的 URL 讀取 JSON 數據
//func fetchOrderDetail(completion: @escaping ([OrderDetail]?) -> Void) {

func fetchOrderDetail(completion: @escaping ([OrderDetail]?) -> Void) {
    guard let url = URL(string: orderDetailURL) else {
        print("Invalid URL")
        completion(nil)
        return
    }

    var request = URLRequest(url: url)
    request.setValue("Bearer \(AirtablePersonAccessKey)", forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error fetching JSON:", error?.localizedDescription ?? "Unknown error")
            completion(nil)
            return
        }

        do {
            // 將 data 轉換為字符串印出
            if let dataString = String(data: data, encoding: .utf8) {
                print("接收到的數據：", dataString)
            }
            
            let decodedData = try JSONDecoder().decode(OrderDetailRecord.self, from: data)
            print("decodedData \(decodedData)")
            completion(decodedData.records)
        } catch {
            print("Error decoding JSON:", error.localizedDescription)
            completion(nil)
        }
    }.resume()
}
