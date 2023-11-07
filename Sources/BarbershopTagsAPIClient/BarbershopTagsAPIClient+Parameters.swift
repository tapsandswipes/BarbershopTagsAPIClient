import Foundation


enum Parameter: String, Sendable {
    case tagID = "id" // Int

    case query = "q" // String
    case maxNumberOfResults = "n" // Int
    case startIndex = "start" // Int
    case numberOfParts = "Parts" // Int
    case style = "Type" // TagInfo.Style
    case hasLearningTracks = "Learning" // Bool: Yes | No
    case hasSheetMusic = "SheetMusic" // Bool: Yes | No
    case collection = "Collection" // TagInfo.Collection
    case minimumRating = "MinRating" // Int
    case minimumDownloads = "MinDownloaded" // Int
    case minimumDate = "Minstamp" // Date: YYYY-MM-DD or YYYY-MM-DD HH:MM:SS
    case sortedBy = "Sortby" // SortOrder
    case resultFields = "fldlist" // Comma separeted list of Field
    case clientName = "client" // String
    
    case action = "action" // Always: rate
    case rating = "rating" // Int: 1...5
    
}

protocol ParameterValueProviding {
    var parameterValue: String { get }
}

extension Bool: ParameterValueProviding {
    var parameterValue: String { self ? "Yes" : "No" }
}

extension Int: ParameterValueProviding {
    var parameterValue: String { String(self) }
}

extension String: ParameterValueProviding {
    var parameterValue: String { self }
}

extension Array: ParameterValueProviding where Element: ParameterValueProviding {
    var parameterValue: String {
        reduce("") { r, e in
            r + ",\(e.parameterValue)"
        }
    }
}

extension RawRepresentable where RawValue: ParameterValueProviding {
    var parameterValue: String { rawValue.parameterValue }
}

extension Date: ParameterValueProviding {
    var parameterValue: String { self.formatted() }
}

extension ResponseInfo.SortOrder: ParameterValueProviding {}
extension TagInfo.Style: ParameterValueProviding {}
extension TagInfo.Collection: ParameterValueProviding {}


extension Query {
    func parameters() -> Parameters? {
        var parameters: Parameters = [:]
        
        term.map { parameters[.query] = $0 }
        numberOfParts.map { parameters[.numberOfParts] = $0 }
        style.map { parameters[.style] = $0 }
        hasLearningTracks.map { parameters[.hasLearningTracks] = $0 }
        hasSheetMusic.map { parameters[.hasSheetMusic] = $0 }
        collection.map { parameters[.collection] = $0 }
        minimumRating.map { parameters[.minimumRating] = $0 }
        minimumDownloads.map { parameters[.minimumDownloads] = $0 }
        minimumDate.map { parameters[.minimumDate] = $0 }

        guard !parameters.isEmpty else { return nil }
        
        return parameters
    }
}

extension ResponseInfo {
    func parameters() -> Parameters? {
        var parameters: Parameters = [:]
        
        maxNumberOfResults.map { parameters[.maxNumberOfResults] = $0 }
        startIndex.map { parameters[.startIndex] = $0 }
        resultFields.map { parameters[.resultFields] = $0 }
        sortedBy.map { parameters[.sortedBy] = $0 }
        
        guard !parameters.isEmpty else { return nil }
        
        return parameters
    }
}

extension ResponseInfo.Field: ParameterValueProviding {
    var parameterValue: String {
        switch self {
        case .id:
            TagInfo.CodingKeys.id.rawValue
        case .title:
            TagInfo.CodingKeys.title.rawValue
        case .alternateTitle:
            TagInfo.CodingKeys.alternateTitle.rawValue
        case .version:
            TagInfo.CodingKeys.version.rawValue
        case .key:
            TagInfo.CodingKeys.key.rawValue
        case .numberOfVoices:
            TagInfo.CodingKeys.numberOfVoices.rawValue
        case .style:
            TagInfo.CodingKeys.style.rawValue
        case .recordingMethod:
            TagInfo.CodingKeys.recordingMethod.rawValue
        case .youTubeID:
            TagInfo.CodingKeys.youTubeID.rawValue
        case .notes:
            TagInfo.CodingKeys.notes.rawValue
        case .arranger:
            TagInfo.CodingKeys.arranger.rawValue
        case .arrangerWebsite:
            TagInfo.CodingKeys.arrangerWebsite.rawValue
        case .arrangedYear:
            TagInfo.CodingKeys.arrangeYear.rawValue
        case .sungBy:
            TagInfo.CodingKeys.sungBy.rawValue
        case .singerWebsite:
            TagInfo.CodingKeys.singerWebsite.rawValue
        case .sungYear:
            TagInfo.CodingKeys.sungYear.rawValue
        case .quartet:
            TagInfo.CodingKeys.quartet.rawValue
        case .quartetWebsite:
            TagInfo.CodingKeys.quartetWebsite.rawValue
        case .teacher:
            TagInfo.CodingKeys.teacher.rawValue
        case .teacherWebsite:
            TagInfo.CodingKeys.teacherWebsite.rawValue
        case .provider:
            TagInfo.CodingKeys.provider.rawValue
        case .providerWebsite:
            TagInfo.CodingKeys.providerWebsite.rawValue
        case .postDate:
            TagInfo.CodingKeys.postDate.rawValue
        case .classicID:
            TagInfo.CodingKeys.classicID.rawValue
        case .collection:
            TagInfo.CodingKeys.collection.rawValue
        case .averageRating:
            TagInfo.CodingKeys.averageRating.rawValue
        case .numberOrRatings:
            TagInfo.CodingKeys.numberOrRatings.rawValue
        case .numberOfDownloads:
            TagInfo.CodingKeys.numberOfDownloads.rawValue
        case .updateDate:
            TagInfo.CodingKeys.updateDate.rawValue
        case .sheetMusic:
            TagInfo.CodingKeys.sheetMusic.rawValue
        case .alternateSheetMusic:
            TagInfo.CodingKeys.alternateSheetMusic.rawValue
        case .notation:
            TagInfo.CodingKeys.notation.rawValue
        case .lyrics:
            TagInfo.CodingKeys.lyrics.rawValue
        case .allVoices:
            TagInfo.CodingKeys.allVoices.rawValue
        case .bassVoice:
            TagInfo.CodingKeys.bassVoice.rawValue
        case .bariVoice:
            TagInfo.CodingKeys.bariVoice.rawValue
        case .leadVoice:
            TagInfo.CodingKeys.leadVoice.rawValue
        case .tenorVoice:
            TagInfo.CodingKeys.tenorVoice.rawValue
        case .other1Voice:
            TagInfo.CodingKeys.other1Voice.rawValue
        case .other2Voice:
            TagInfo.CodingKeys.other2Voice.rawValue
        case .other3Voice:
            TagInfo.CodingKeys.other3Voice.rawValue
        case .other4Voice:
            TagInfo.CodingKeys.other4Voice.rawValue
        case .videos:
            TagInfo.CodingKeys._videos.rawValue
        }
    }
}

