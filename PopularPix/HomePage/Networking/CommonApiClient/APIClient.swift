//
//  APIClient.swift
//  PopularPix
//
//  Created by Miwand Najafe on 2019-02-24.
//  Copyright © 2019 Miwand Najafe. All rights reserved.
//

import Foundation

enum APIError: Error
{
    case invalidURL
    case noData
    case invalidBody
    case networkError
    case noErrorData
    case invalidJSONForErrorBody
}

protocol APIClient
{
    associatedtype RequestType: Codable
    var request: RequestDataModel { get }
}

extension APIClient
{
    func execute(onSuccess: @escaping (RequestType) -> (),
              onFailure: @escaping (Error) -> ())
    {
        guard let url = URL(string: request.path) else {
            onFailure(APIError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeoutInterval)
        urlRequest.httpMethod = request.method.rawValue
        
        do
        {
            if let params = request.params
            {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        catch let error
        {
            onFailure(error)
        }
        
        if let headers = request.headers
        {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        self.make(request: urlRequest, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    private func make(request: URLRequest,
                      onSuccess: @escaping (RequestType) -> (),
                      onFailure: @escaping (Error) -> ())
    {
        let sessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error
            {
                onFailure(error)
                return
            }
            
            guard let data = data,
                let response = response as? HTTPURLResponse else
            {
                onFailure(APIError.noData)
                return
            }
            
            if response.statusCode != 200
            {
                onFailure(self.getEmbeddedError(from: data))
            }
            
            do
            {
                let jsonDecoder = JSONDecoder()
                let codableType = try jsonDecoder.decode(RequestType.self, from: data)
                onSuccess(codableType)
            }
            catch let error
            {
                onFailure(error)
            }
        }
        sessionDataTask.resume()
    }
    
    private func getEmbeddedError(from data: Data) -> Error
    {
        do
        {
            guard let errorDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let statusCode = errorDict["status"] as? Int else { return APIError.invalidJSONForErrorBody }
            
            return NSError(domain: "", code: statusCode, userInfo: errorDict) as Error
        }
        catch
        {
            return APIError.noErrorData
        }
    }
}

extension APIClient
{
    func getDefaultHeaders() -> [String: String]
    {
        return ["Content-Type":"application/Json"]
    }
}
