//
//  RequestError.swift
//  ReqResVIP
//
//  Created by user on 11/12/22.
//

import Foundation

enum ResponseError: Error {
    case invalidData
    case decodeError
    case httpStatusCodeError(Int)
    
    var description: String {
        switch self {
        case .invalidData:
            return "Dados inválidos"
        case .decodeError:
            return "Error ao decodificar dados"
        case .httpStatusCodeError(let status):
            return httpErrorDescription(status)
        }
    }
    
    func httpErrorDescription(_ status: Int) -> String {
        switch status {
        case 400:
            return "Requisição Inválida"
        case 404:
            return "O servidor não pode encontrar o recurso solicitado"
        case 500:
            return "O servidor encontrou uma situação com a qual não sabe lidar."
        default:
            return "Falha no Servidor"
        }
    }
}

