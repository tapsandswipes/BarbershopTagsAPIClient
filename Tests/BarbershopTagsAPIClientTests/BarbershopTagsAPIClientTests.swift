import XCTest
@testable import BarbershopTagsAPIClient

final class BarbershopTagsAPIClientTests: XCTestCase {
    
    func testGetRequestFromParameters() throws {
        let sut = BarbershopTagsAPIClient(name: "Test Client")
        
        let parameters: Parameters = [
            .collection: TagInfo.Collection.classic
        ]
                
        let request = try sut.getRequest(from: parameters)
        
        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url?.query(percentEncoded: false), "Collection=classic")
    }
    
    func testRateWorngTag() async throws {
        let sut = BarbershopTagsAPIClient(name: "TC", session: .init(mockResponder: RateWrongResponse.self))
        
        do {
            try await sut.rateTag(id: 123456, rating: 5)
            XCTFail()
        } catch {
        }
        
        RateWrongResponse.unregister()
    }
    
    func testRateTagOK() async throws {
        let sut = BarbershopTagsAPIClient(name: "TC", session: .init(mockResponder: RateOKResponse.self))

        try await sut.rateTag(id: 123456, rating: 5)
        
        RateOKResponse.unregister()
    }
    
    func testTagsQuery() async throws {
        let sut = BarbershopTagsAPIClient(name: "TC", session: .init(mockResponder: TagsQueryResponse.self))

        let tags = try await sut.getTags(matching: .init(term: "T"))
        
        XCTAssertFalse(tags.tags.isEmpty)
        
        TagsQueryResponse.unregister()
    }
    
    func testTagsPartialQuery() async throws {
        let sut = BarbershopTagsAPIClient(name: "TC", session: .init(mockResponder: TagsQueryPartialResponse.self))

        let tags = try await sut.getTags(matching: .init(term: "T"))
        
        XCTAssertFalse(tags.tags.isEmpty)
        
        TagsQueryPartialResponse.unregister()
    }

    func testRealDataParsing() async throws {
        let sut = BarbershopTagsAPIClient(name: "Test Client")

        let tag = try await sut.getTag(id: 31)
        
        XCTAssertEqual(tag.id, 31)
        XCTAssertEqual(tag.title, "After Today")
    }
    
    func testSearchOneTag() async throws {
        let sut = BarbershopTagsAPIClient(name: "Test Client")
        
        let tags = try await sut.getTags(
            matching: .init(term: "Leaves"),
            respone: .init(
                maxNumberOfResults: 40,
                resultFields: [
                    .id,
                    .title,
                    .classicID,
                    .key,
                    .collection,
                    .numberOfVoices,
                    .allVoices,
                    .bassVoice,
                    .bariVoice,
                    .leadVoice,
                    .tenorVoice,
                    .lyrics,
                    .sheetMusic,
                    .alternateSheetMusic,
                ]
            )
        )
        
        XCTAssertFalse(tags.tags.isEmpty)
    }
}


enum RateWrongResponse: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        "tag 123456 does not exist".data(using: .utf8)!
    }
}

enum RateOKResponse: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        "ok".data(using: .utf8)!
    }
}

enum TagsQueryResponse: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        try Data(contentsOf: Bundle.module.url(forResource: "tags", withExtension: "xml")!)
    }
}

enum TagsQueryPartialResponse: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        try Data(contentsOf: Bundle.module.url(forResource: "partial", withExtension: "xml")!)
    }
}
