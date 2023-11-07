import Foundation

public
extension BarbershopTagsAPIClient {
    func getTags(matching query: Query, respone info: ResponseInfo? = nil) async throws -> QueryResult {
        guard var parameters = query.parameters() else { throw Error.malformedQuery }
        
        if let other = info?.parameters() {
            parameters.merge(other, uniquingKeysWith: { $1 })
        }
        
        return try await performQuery(parameters)
    }
    
    func getTag(id: TagInfo.ID, withFields fields: [ResponseInfo.Field]? = nil) async throws -> TagInfo {
        var parameters: Parameters = [.tagID: id]
        
        if let other = fields {
            parameters[.resultFields] = other
        }

        let result: QueryResult = try await performQuery(parameters)
        
        guard let tag = result.tags.first else { throw Error.tagDoesNotExtist }
        
        return tag
    }
    
    func rateTag(id: TagInfo.ID, rating: Int) async throws {
        let parameters: Parameters = [.action: "rate", .tagID: id, .rating: rating]

        let r: Data = try await performQuery(parameters)
        
        let s = String(decoding: r, as: UTF8.self)
        
        guard !s.isEmpty else { throw Error.badResponse }
        
        if s != "ok" {
            throw Error.tagDoesNotExtist
        }
    }
}

public
struct Query {
    var term: String?
    var numberOfParts: Int?
    var style: TagInfo.Style?
    var hasLearningTracks: Bool?
    var hasSheetMusic: Bool?
    var collection: TagInfo.Collection?
    var minimumRating: Int?
    var minimumDownloads: Int?
    var minimumDate: Date?
    
    public init(
        term: String? = nil,
        numberOfParts: Int? = nil,
        style: TagInfo.Style? = nil,
        hasLearningTracks: Bool? = nil,
        hasSheetMusic: Bool? = nil,
        collection: TagInfo.Collection? = nil,
        minimumRating: Int? = nil,
        minimumDownloads: Int? = nil,
        minimumDate: Date? = nil
    ) {
        self.term = term
        self.numberOfParts = numberOfParts
        self.style = style
        self.hasLearningTracks = hasLearningTracks
        self.hasSheetMusic = hasSheetMusic
        self.collection = collection
        self.minimumRating = minimumRating
        self.minimumDownloads = minimumDownloads
        self.minimumDate = minimumDate
    }
}

public
struct QueryResult: Decodable {
    public var available: Int
    public var lastIndex: Int { tags.last?.index ?? 0}
    public var tags: [TagInfo]
}


public
struct ResponseInfo {
    var maxNumberOfResults: Int?
    var startIndex: Int?
    var resultFields: [Field]?
    var sortedBy: SortOrder?
    
    public init(
        maxNumberOfResults: Int? = nil,
        startIndex: Int? = nil,
        resultFields: [ResponseInfo.Field]? = nil,
        sortedBy: ResponseInfo.SortOrder? = nil
    ) {
        self.maxNumberOfResults = maxNumberOfResults
        self.startIndex = startIndex
        self.resultFields = resultFields
        self.sortedBy = sortedBy
    }
    
}

extension ResponseInfo {
    public
    enum SortOrder: String {
        case title = "Title"
        case datePosted = "Posted"
        case dateUpdated = "stamp"
        case rating = "Rating"
        case dounloadCount = "Downloaded"
        case isClassic = "Classic"
    }

    public
    enum Field {
        case id
        case title
        case alternateTitle
        case version
        case key
        case numberOfVoices
        case style
        case recordingMethod
        case youTubeID
        case notes
        case arranger
        case arrangerWebsite
        case arrangedYear
        case sungBy
        case singerWebsite
        case sungYear
        case quartet
        case quartetWebsite
        case teacher
        case teacherWebsite
        case provider
        case providerWebsite
        case postDate
        case classicID
        case collection
        case averageRating
        case numberOrRatings
        case numberOfDownloads
        case updateDate
        case sheetMusic
        case alternateSheetMusic
        case notation
        case lyrics
        case allVoices
        case bassVoice
        case bariVoice
        case leadVoice
        case tenorVoice
        case other1Voice
        case other2Voice
        case other3Voice
        case other4Voice
        case videos
    }
}
