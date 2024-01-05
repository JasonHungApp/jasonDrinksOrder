//
//  uploadOrderDetail.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/5.
//

import Foundation

func uploadOrderDetail(orderDetailRecord: OrderDetailRecord, completion: @escaping (Data?) -> Void) {
    // 轉換 OrderDetailRecord 為 JSON 數據
    guard let jsonData = try? JSONEncoder().encode(orderDetailRecord) else {
        print("Error encoding orderDetailRecord to JSON")
        return
    }

    // 設定 API 端點 URL，這裡請替換成你的 Airtable API URL
    guard let url = URL(string: orderDetailURL) else {
        print("Invalid URL")
        return
    }

    // 設定 POST 請求
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(AirtablePersonAccessKey)", forHTTPHeaderField: "Authorization")
    request.httpBody = jsonData

    // 發送請求
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error uploading orderDetailRecord:", error?.localizedDescription ?? "Unknown error")
            completion(nil)
            return
        }

        // 解析回傳的數據，這裡假設你的 Airtable API 回傳的數據是一個 JSON，你可能需要根據實際情況進行調整
        if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            print("Upload successful:", jsonResponse)
            
            
            completion(data)
            
            
        } else {
            print("Error decoding upload response")
            completion(nil)
        }
    }.resume()
}




func uploadOrderDetail(orderDetailRecord: OrderDetailRecord) {
    // 轉換 OrderDetailRecord 為 JSON 數據
    guard let jsonData = try? JSONEncoder().encode(orderDetailRecord) else {
        print("Error encoding orderDetailRecord to JSON")
        return
    }

    // 設定 API 端點 URL，這裡請替換成你的 Airtable API URL
    guard let url = URL(string: orderDetailURL) else {
        print("Invalid URL")
        return
    }

    // 設定 POST 請求
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(AirtablePersonAccessKey)", forHTTPHeaderField: "Authorization")
    request.httpBody = jsonData

    // 發送請求
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error uploading orderDetailRecord:", error?.localizedDescription ?? "Unknown error")
            return
        }

        // 解析回傳的數據，這裡假設你的 Airtable API 回傳的數據是一個 JSON，你可能需要根據實際情況進行調整
        if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            print("Upload successful:", jsonResponse)
            
            
            
            
            
        } else {
            print("Error decoding upload response")
        }
    }.resume()
}
