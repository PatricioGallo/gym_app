//
//  netWorkingProvider.swift
//  api_rest
//
//  Created by Pato Gallo on 19/09/2024.
//

import Foundation
import Alamofire

final class netWorkingProvider{
    
    static let shared = netWorkingProvider()
    
    private let kbaseUrl = "https://66ec441f2b6cf2b89c5de52a.mockapi.io/gymApy/"
    
    func getUser(id: Int, success: @escaping (_ user: Persona) -> (),failure: @escaping (_ error: Error?) -> ()){
        
        let url = "\(kbaseUrl)/users/\(id)"
        AF.request(url, method: .get).validate(statusCode: 200...299).responseDecodable (of: Persona.self){
            response in
            if let error = response.error {
                failure(error)
            } else if let user = response.value {
                success(user)
            }

        }
    }
    
//    func addUser(user: newUser, success: @escaping (_ user: User) -> (),failure: @escaping (_ error: Error?) -> ()){
//
//        let url = "\(kbaseUrl)/users"
//
//        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: 200...299).responseDecodable (of: User.self){
//            response in
//            if let error = response.error {
//                failure(error)
//            } else if let user = response.value {
//                success(user)
//            }
//
//        }
//    }
//
    func editInfo(id: Int, user: Persona_mod, success: @escaping (_ user: Persona_mod) -> (),failure: @escaping (_ error: Error?) -> ()){

        let url = "\(kbaseUrl)/users/\(id)"

        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: 200...299).responseDecodable (of: Persona_mod.self){
            response in
            if let error = response.error {
                failure(error)
            } else if let user = response.value {
                success(user)
            }
        }
    }
}

