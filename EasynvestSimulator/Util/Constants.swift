//
//  Constants.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 16/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

struct API {
    static let url = "https://api-simulator-calc.easynvest.com.br/calculator/simulate"
}

struct GenericMessages {
    static let kAlertTitle = "Ops..."
    static let kAlertDoneActionText = "Ok"

    static let kToolbarNext = "Próximo"
    static let kToolbarCancel = "Cancelar"

    static let kSuccess = "Sucesso!"
}

struct FormMessages {
    static let kInvalidMaturityDate = "Algum problema ocorreu com a data. Tente novamente!"
    static let kInvalidInvestedAmount = "Algum problema ocorreu com a total a ser investido. Tente novamente!"
    static let kInvalidRate = "Algum problema ocorreu com o percentual do papel. Tente novamente!"
}

struct DateFormats {
    static let kHumanReadable = "dd/MM/yyyy"
    static let kAPIRequest = "yyyy-MM-dd"
    static let kAPIResponse = "yyyy-MM-dd'T'HH:mm:ss"
}

struct ConsoleMessages {
    static let kNilError = "Algo inesperado ocorreu e não foi possível obter o erro..."
    static let kGenericMessage = "Algo ocorreu durante a requisição"
    static let kDecodeErrorTag = "[Easynvest/Decode_Error]"
    static let kRequestFailureTag = "[Easynvest/Request_Failure]"
    static let kRequestSuccessfulTag = "[Easynvest/Request_Successful]"
}
