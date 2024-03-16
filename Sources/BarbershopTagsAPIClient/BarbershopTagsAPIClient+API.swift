import Foundation

public
extension BarbershopTagsAPIClient {
    /// MAke a call to the server to search for tags
    /// - Parameters:
    ///   - query: object with the query to perform
    ///   - info: type of response to get
    /// - Returns: The result object with the response from the server
    func getTags(matching query: Query, respone info: ResponseInfo? = nil) async throws -> QueryResult {
        guard var parameters = query.parameters() else { throw Error.malformedQuery }
        
        if let other = info?.parameters() {
            parameters.merge(other, uniquingKeysWith: { $1 })
        }
        
        return try await performQuery(parameters)
    }
    
    /// Get a tag by its id
    /// - Parameters:
    ///   - id: the id of the tag to get
    ///   - fields: the fields to retrieve for the tag
    /// - Returns: An objedt with the fields indicated in the call if a tag with the provided id is found
    func getTag(id: TagInfo.ID, withFields fields: [ResponseInfo.Field]? = nil) async throws -> TagInfo {
        var parameters: Parameters = [.tagID: id]
        
        if let other = fields {
            parameters[.resultFields] = other
        }

        let result: QueryResult = try await performQuery(parameters)
        
        guard let tag = result.tags.first else { throw Error.tagDoesNotExtist }
        
        return tag
    }
    
    /// Send a tag rating to the server
    /// - Parameters:
    ///   - id: the id pof the tag to rate
    ///   - rating: the rating to send. It must be bewtween 1 and 5
    func rateTag(id: TagInfo.ID, rating: Int) async throws {
        let parameters: Parameters = [.action: "rate", .tagID: id, .rating: rating]

        let s: String = try await performQuery(parameters)
        
        if s != "ok" {
            throw Error.tagDoesNotExtist
        }
    }
}

/// Object to describe the query to perfprm
public
struct Query: Sendable {
    var term: String?
    var numberOfParts: Int?
    var style: TagInfo.Style?
    var hasLearningTracks: Bool?
    var hasSheetMusic: Bool?
    var collection: TagInfo.Collection?
    var minimumRating: Int?
    var minimumDownloads: Int?
    var minimumDate: Date?
    
    /// Initialize a query object
    /// - Parameters:
    ///   - term: Search term to look for
    ///   - numberOfParts: Number of parts that the tag is composed for
    ///   - style: The style of the tag
    ///   - hasLearningTracks: Flag to look for tags with learning tracks
    ///   - hasSheetMusic: Flag to look for tags with sheet music
    ///   - collection: Collection to look for tags into
    ///   - minimumRating: The minimum rating taht the tags must have
    ///   - minimumDownloads: The minimum number of downlods the tags must have
    ///   - minimumDate: Look fot tags created after this date
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

/// Result objet to return queries
public
struct QueryResult: Decodable, Sendable {
    /// Number of items that match the query
    public let available: Int
    /// Index of the last tag in this result. Use this index to configure the response in succesive calls.
    public var lastIndex: Int { tags.last?.index ?? 0}
    /// Array of tags that match the query
    public let tags: [TagInfo]
    
    /// Initialize a query result object
    /// - Parameters:
    ///   - available: Number of items that match the query
    ///   - tags: Array of tags that match the query
    public init(available: Int, tags: [TagInfo]) {
        self.available = available
        self.tags = tags
    }
}

/// Object to configure the response to get
public
struct ResponseInfo: Sendable {
    let maxNumberOfResults: Int?
    let startIndex: Int?
    let resultFields: [Field]?
    let sortedBy: SortOrder?
    
    /// Initialize a responde info object
    /// - Parameters:
    ///   - maxNumberOfResults: maximum number of tags to return in the query results
    ///   - startIndex: the index of the index to start. Used for pagination.
    ///   - resultFields: the fields to include in each tag
    ///   - sortedBy: sort the results by this field
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
    /// Fields available to sort results by
    public
    enum SortOrder: String, Sendable {
        case id = "id"
        case title = "Title"
        case datePosted = "Posted"
        case dateUpdated = "stamp"
        case rating = "Rating"
        case dounloadCount = "Downloaded"
        case isClassic = "Classic"
    }

    /// Available fields for each tag. 
    public
    enum Field: Sendable {
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
