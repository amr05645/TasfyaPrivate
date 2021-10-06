//
//  Services.swift
//  Tasfya
//
//  Created by Amr on 05/09/2021.
//

import Foundation
import Alamofire

class Service {
    
    var baseUrl = "https://yousry.drayman.co/"
    var callBack : DataCallBack?
    
    typealias DataCallBack = (_ category : Any?, _ status: Bool, _ message :String ) -> Void
    
    init (baseUrl : String){
        self.baseUrl = baseUrl
    }
    
    func getBanners(endPoint : String , parameter: [String : Any], model: String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "GetBanners") {
                    let model =  try JSONDecoder().decode(GetBanners.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func getProducts(endPoint : String , parameter: [String : Any], model: String) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "getAllProducts") {
                    let model =  try JSONDecoder().decode(AllProducts.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func getCategories(endPoint : String , parameter: [String : Any], model: String) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "allCategories") {
                    let model =  try JSONDecoder().decode(Categories.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
    func getLikes(endPoint : String , parameter: [String : Any], model: String) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "LikesModel") {
                    let model =  try JSONDecoder().decode(LikesModel.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
//    func userLogin(endPoint : String , parameter: [String : Any], model: String) {
//        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter , encoder: URLEncodedFormParameterEncoder.default,  headers:nil , interceptor: nil).response{
//            response in
//            guard let data = response.data else{self.callBack?(nil, false, "")
//                return}
//            do {
//                let model = try JSONDecoder().decode(Login.self, from: data)
//                if (model == "processLogin") {
//                    let model =  try JSONDecoder().decode(Login.self, from: data)
//                    self.callBack?(model , true, "")
//                }
//            } catch {
//                self.callBack?(nil, false, error.localizedDescription)
//            }
//        }
//    }
    func getAllAddresses(endPoint : String , parameter: [String : Any], model: String) {
        
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "AllAddresses") {
                    let model =  try JSONDecoder().decode(AllAddresses.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    func getPassword(endPoint : String , parameter: [String : Any], model: String) {

        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "forgetPassword") {
                    let model =  try JSONDecoder().decode(ForgetPassword.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    func addAddresses(endPoint : String , parameter: [String : Any], model: String) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            response in
            guard let data = response.data else {
                self.callBack?(nil, false, "")
                return}
            do{
                if (model == "AddAddresses") {
                    let model =  try JSONDecoder().decode(AddAddresses.self, from: data)
                    self.callBack?(model , true, "")
                }
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
        }
    }
    
//    func postRegisteration(endPoint : String , parameter: [String : Any], model: String) {
//        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
//            response in
//            guard let data = response.data else {
//                self.callBack?(nil, false, "")
//                return}
//            do{
//                if (model == "RegisterModel") {
//                    let model =  try JSONDecoder().decode(RegisterModel.self, from: data)
//                    self.callBack?(model , true, "")
//                }
//            } catch {
//                self.callBack?(nil, false, error.localizedDescription)
//            }
//        }
//    }
    
    func completionHandler(callBack: @escaping DataCallBack){
        self.callBack = callBack
    }
    
}

