//
//  AppleMarketingRssFeed.swift
//  phw14-2-json-decode
//
//  Created by jasonhung on 2023/12/20.
//

import Foundation

/*

 {
   "records":
      [
        {
           "id":"rec2gNNKIOnZG172z",
           "createdTime":"2023-12-30T18:30:48.000Z",
           "fields":
             {
              "descriptionShort":"帶有濃穩果香的經典紅茶",
              "hotAvailable":"true",
              "priceM":35,
              "name":"熟成紅茶",
              "image":
                [
                 {
                   "id":"att8ew6pOKKxlLV99",
                   "width":540,
                   "height":540,
                   "url":"https://v5.airtableusercontent.com/v2/24/24/1703980800000/Vwn3RcgvulGofCNwvc0O5Q/Gwu4LMRYhfzwdjNxODauJJuP3GzD06CbPvt2NRicQshx2-SQ35S4m1uTKuCV1cIRFnP1EqzX1-mDBeqsQULFgwCtiolJ96iWReVtV847zcIws5CIUHAYS5IjMhKFqFIkqLevvRk7Z29zfcXpP-L0tQ/i9vK2_GSQRIhINfYgJGWwudZR-PuuNwGPTb2qKN4WqE",
                    "filename":"24熟成紅茶.png",
                    "size":353012,
                    "type":"image/png",
                    "thumbnails":
                      {
                        "small":
                           {
                            "url":"https://v5.airtableusercontent.com/v2/24/24/1703980800000/9xvPxYC9Cyvl5zTV4UsOOA/BxfSW2HihAPN8QrxlAvWPxMv6r2ghMNGeMltYG2oY7lVczyDyg5Imum2Dle4mL7pSxB7x9fQop6vwnTl7qSk-DwfaJhJeFdkkBGHS3IM46gKASYXH1ITmNFXVw23X2JxeL6gX6jclrEblsgw5S_wuw/gYvA1zfPRL-_lDu6iS6dEz1sKAYny06gnuz-D3TqS6E",
                             "width":36,
                             "height":36
                             },
                         "large":
                            {
                              "url":"https://v5.airtableusercontent.com/v2/24/24/1703980800000/7-13Fc4gnamUx6E-V-LRbQ/FNcPt5C_p27qinxKsbKJ6B7bmcpnZ3Fi3AmvqkzCwe8lOPeY2EPo3rxBQlYxe-4QLnojynRgNAMYSgpu77-dRuzRcvcwjnn9KsCcKDzYbLZ7QDI9zWB-0-3_bF0TMefqVlM8Ouar4anlVH9n5BoEWg/0D9R3pQq9r599Nhf2PEhvJnnDeUrcydZ341-9lk6nwA",
                                "width":512,
                                "height":512
                               },
                           "full":{"url":"https://v5.airtableusercontent.com/v2/24/24/1703980800000/TXyFtgTbsfAUdEdjGCsmrQ/H-yNeJBv0aNUNDLhD2jJ-Ocd3W49fFSoD03JYx7FGRsWd-mZVrTX86j2fO28fjxs5EryMRvX2XOAmKb7uRbdElKa6T2RDYgejCRpxXt5Y3DDvFF0dpepFSz9X1ReMj-THhQdtE20WelnRlQq999ApQ/v1lokGdVYH2MHwAWQhuhKDaupTehrMZP3pLN41Hpems","width":540,"height":540}}}
                      ],
                "descriptionLong":"木質帶熟果香調的風味，流露熟齡男子的沈穩氣息，低調而迷人。嚴選自斯里蘭卡產區之茶葉，帶有濃郁果香及醇厚桂圓香氣；與肉類料理一同品嚐，得以化解舌尖上所殘留的油膩感。",
                 "priceL":40
                }
           },
           {
             "id":"rec66hXLxVFY7JNHS",
             "createdTime":"2023-12-30T18:30:48.000Z"
 }]}

 */


func fetchMenu(completion: @escaping (TeaRecord?) -> Void) {
    let url = URL(string: "https://api.airtable.com/v0/appBBDhGnweLyIoSi/menu")!

    fetchDataAuthorization(from: url) { data in
        guard let data = data else {
            // 處理錯誤，這裡可以根據實際情況進行更多處理
            print("未獲得有效的 JSON 數據")
            completion(nil)
            return
        }

        do {
            // 將 data 轉換為字符串印出
            if let dataString = String(data: data, encoding: .utf8) {
                print("接收到的數據：", dataString)
            }
            
            let decodedData = try JSONDecoder().decode(TeaRecord.self, from: data)
            completion(decodedData) // 調用 completion handler 傳遞結果
            
        } catch {
            print("解碼 JSON 時發生錯誤:", error.localizedDescription)
            completion(nil) // 如果發生錯誤，可以傳遞一個空的 TeaRecord 或其他預設值
        }
    }
}
