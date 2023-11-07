import Foundation
import XMLCoder


typealias Parameters = [Parameter: any ParameterValueProviding]

extension BarbershopTagsAPIClient {
    
    func performQuery(_ parameters: Parameters) async throws -> Data {
        var parameters = parameters
        parameters[.clientName] = clientName
        
        let request = try getRequest(from: parameters)
        
        let (data, response) = try await session.data(for: request)
        
        guard let HTTPResponse = response as? HTTPURLResponse else {
            throw Error.badResponse
        }

        guard 200..<400 ~= HTTPResponse.statusCode else {
            throw Error.badStatus(status: HTTPResponse.statusCode)
        }

        return data
    }
    
    func getRequest(from parameters: Parameters) throws -> URLRequest {
        guard 
            let url = URL(string: "http://www.barbershoptags.com/api.php"),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { throw Error.malformedURL }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map {
                .init(name: $0.rawValue, value: $1.parameterValue)
            }
        }
        
        guard let finalURL = components.url else { throw Error.malformedURL }

        let request = NSMutableURLRequest(url: finalURL)
        request.httpMethod = "GET"
        
        return request as URLRequest
    }
}


extension BarbershopTagsAPIClient {
    func performQuery(_ parameters: Parameters) async throws -> QueryResult {
        let data: Data = try await performQuery(parameters)
        
        return try decoder.decode(QueryResult.self, from: data)
    }

    func performQuery(_ parameters: Parameters) async throws -> String {
        let data: Data = try await performQuery(parameters)

        let string = String(decoding: data, as: UTF8.self)
        
        guard !string.isEmpty else { throw Error.badResponse }
        
        return string
    }    
}
