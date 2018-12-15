//
//  NetworkDII.swift
//  zimcorretor
//
//  Created by João Gabriel on 01/10/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

struct NetworkDII: JGNetwork {
    var logger: JGLogger

    init(logHandler: JGLogger) {
        self.logger = logHandler
    }

    func getRequest(for urlString: String,
                    with parameters: AnyParameters,
                    success: @escaping JGNetworkCompletionSuccess,
                    failure: @escaping JGNetworkCompletionFailure) {
        var urlComponents = URLComponents(string: urlString)
        var items = [URLQueryItem]()

        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: String(describing: value)))
        }

        urlComponents?.queryItems = items
        let urlRequest = URLRequest(url: urlComponents!.url!)

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            guard error == nil else {
                self.logger.log(
                    "Algo ocorreu durante a requisição",
                    "Error: \(error?.localizedDescription ?? "---")",
                    with: "[Easynvest/Request_Failure]",
                    and: JGLDefaultOptions)
                failure("\(error?.localizedDescription ?? "Algo inesperado ocorreu...")")
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                self.logger.log(
                    "Algo ocorreu durante a requisição.",
                    "Status Code: \(response.statusCode)",
                    with: "[Easynvest/Request_Failure]",
                    and: JGLDefaultOptions)
                failure("Algo ocorreu durante a requisição.")
                return
            }

            if let data = data {
                self.logger.log("Sucesso!", with: "[Easynvest/Request_Successful]", and: JGLDefaultOptions)
                success(data)
            } else {
                self.logger.log(
                    "Algo ocorreu durante a requisição!",
                    with: "[Easynvest/Request_Failure]",
                    and: JGLDefaultOptions)
                failure("Algo ocorreu durante a requisição!")
            }
        }.resume()
    }
}
