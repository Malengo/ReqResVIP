//
//  HomeModel.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 03/03/23.
//

import Foundation

enum HomeModel {
    enum GetUsers {
        struct Request{}
        
        struct Response {
            var clients: [Client]
        }
        
        struct ViewModel {
            var clients: [Client]
        }
    }
}
