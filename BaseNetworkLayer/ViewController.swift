//
//  ViewController.swift
//  BaseNetworkLayer
//
//  Created by Nguyễn Hoàng on 20/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ClientNetwork
            .shared
            .sendRequest(
                endPoint: "",
                method: .get,
                responseType: EmployeeResponse.self
            ) { response in
                print(response)
            } failBlock: { error in
                print(error)
            }
        
    }
}

