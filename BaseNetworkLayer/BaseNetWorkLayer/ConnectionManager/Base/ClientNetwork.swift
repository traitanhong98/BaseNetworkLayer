//
//  ClientNetwork.swift
//  BaseNetworkLayer
//
//  Created by Nguyễn Hoàng on 20/08/2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case urlError
    case requestError(errorCode:Int, message: String?)
    case networkError(error: AFError)
    case dataNull
    case parseObjectError
}

class ClientNetwork {
    // MARK: - Singleton
    static let shared = ClientNetwork()
    private init() {}
    
    // MARK: - Method
    
    func sendRequestAndHanleResponse<T: Codable>(
        endPoint: String,
        method: HTTPMethod,
        parameter: [String: Any] = BaseNetworkInput.baseParam,
        header: HTTPHeaders? = BaseNetworkInput.getHeaders(),
        responseType: T.Type,
        successBlock: @escaping (_ response: T)-> Void,
        failBlock: @escaping (_ error: NetworkError) -> Void
    ) {
        sendRequest(endPoint: endPoint, method: method, responseType: BaseResponseContainer<T>.self) { response in
            if response.code == 1 {
                if let data = response.data {
                    successBlock(data)
                } else {
                    failBlock(.dataNull)
                }
            } else {
                failBlock(.requestError(errorCode: response.code, message: response.message))
            }
        } failBlock: { error in
            failBlock(error)
        }

    }
    
    func sendRequest<T: Codable>(
        endPoint: String,
        method: HTTPMethod,
        parameter: [String: Any] = BaseNetworkInput.baseParam,
        header: HTTPHeaders? = BaseNetworkInput.getHeaders(),
        responseType: T.Type,
        successBlock: @escaping (_ response: T)-> Void,
        failBlock: @escaping (_ error: NetworkError) -> Void
    ) {
        guard let url = URL(string: getUrlString(withEndPoint: endPoint)) else {
            failBlock(.urlError)
            return
        }
        
        let request = AF.request(url, method: method, parameters: parameter, headers: header)
        request.cURLDescription {
            print($0)
        }
        
        request
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    guard let response: T = self.handleResponse(fromData: data) else {
                        failBlock(.parseObjectError)
                        return
                    }
                    successBlock(response)
                case .failure(let error):
                    failBlock(.networkError(error: error))
                }
            }
    }
    
    private func handleResponse<T: Codable>(fromData data: Data?) -> T? {
        guard let data = data else {
            return nil
        }
        do {
           let decodedData = try JSONDecoder().decode(T.self, from: data)
           return decodedData
        } catch let err {
            print(
                """
                ===================== RequestError =====================
                \(String(describing: err))
                =====================     End      =====================
                """
            )
            return nil
        }

    }
    
    private func getUrlString(withEndPoint endPoint: String) -> String {
        AppConfigs.baseUrl + endPoint
    }
}
