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
    enum Field: String {
        case id = "id"
        case title = "Title"
        case alternateTitle = "AltTitle"
        case version = "Version"
        case key = "WritKey"
        case numberOfVoices = "Parts"
        case style = "Type"
        case recordingMethod = "Recording"
        case youTubeID = "TeachVid"
        case notes = "Notes"
        case arranger = "Arrenger"
        case arrangerWebsite = "ArrWebsite"
        case arrangedYear = "Arranged"
        case sungBy = "SungBy"
        case singerWebsite = "SungWebsite"
        case sungYear = "SungYear"
        case quartet = "Quartet"
        case quartetWebsite = "QWebsite"
        case teacher = "Teacher"
        case teacherWebsite = "TWebsite"
        case provider = "Provider"
        case providerWebsite = "ProvWebsite"
        case postDate = "Posted"
        case classicID = "Classic"
        case collection = "Collection"
        case averageRating = "Rating"
        case numberOrRatings = "RatingCount"
        case numberOfDownloads = "Downloaded"
        case updateDate = "stamp"
        case sheetMusic = "SheetMusic"
        case alternateSheetMusic = "SheetMusicAlt"
        case notation = "Notation"
        case lyrics = "Lyrics"
        case allVoices = "AllParts"
        case bassVoice = "Bass"
        case bariVoice = "Bari"
        case leadVoice = "Lead"
        case tenorVoice = "Tenor"
        case other1Voice = "Other1"
        case other2Voice = "Other2"
        case other3Voice = "Other3"
        case other4Voice = "Other4"
        case videos = "videos"
    }
}
