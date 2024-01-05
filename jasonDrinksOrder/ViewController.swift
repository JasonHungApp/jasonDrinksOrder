//
//  ViewController.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2023/12/31.
//

import UIKit

class ViewController: UIViewController {

    var teaRecord: TeaRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getMenuClassic()
    }


    func getMenuClassic(){
        fetchMenuClassic { result in
            // print(result)

            DispatchQueue.main.async {
                guard let teaRecord = result as? TeaRecord else {
                    print("Invalid result type")
                    return
                }
                
                
                self.teaRecord = teaRecord
                print(self.teaRecord?.records)
                
                // 在這裡你可以進行進一步的處理，比如刷新界面等
            }
        }
    }

}

