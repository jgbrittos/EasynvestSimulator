//
//  NetworkDII.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
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
                let errorMessage = "Error: \(error?.localizedDescription ?? ConsoleMessages.kNilError)"
                self.logger.log(
                    ConsoleMessages.kGenericMessage,
                    errorMessage,
                    with: ConsoleMessages.kRequestFailureTag,
                    and: JGLDefaultOptions)
                failure(errorMessage)
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                self.logger.log(
                    ConsoleMessages.kGenericMessage,
                    "Status Code: \(response.statusCode)",
                    with: ConsoleMessages.kRequestFailureTag,
                    and: JGLDefaultOptions)
                failure(ConsoleMessages.kGenericMessage)
                return
            }

            if let data = data {
                self.logger.log(GenericMessages.kSuccess,
                                with: ConsoleMessages.kRequestSuccessfulTag,
                                and: JGLDefaultOptions)
                success(data)
            } else {
                self.logger.log(
                    ConsoleMessages.kGenericMessage,
                    with: ConsoleMessages.kRequestFailureTag,
                    and: JGLDefaultOptions)
                failure(ConsoleMessages.kGenericMessage)
            }
        }.resume()
    }
}
