import Foundation

let characterEntities : [String: Character] = [
    
    // XML predefined entities:
    "&quot;"     : "\"",
    "&amp;"      : "&",
    "&apos;"     : "'",
    "&lt;"       : "<",
    "&gt;"       : ">",
    
    // HTML character entity references:
    "&nbsp;"     : "\u{00A0}",
    "&iexcl;"    : "\u{00A1}",
    "&cent;"     : "\u{00A2}",
]

extension String {
    func replacingCharacterEntities() -> String {
        func unicodeScalar(for numericCharacterEntity: String) -> Unicode.Scalar? {
            var unicodeString = ""
            for character in numericCharacterEntity {
                if "0123456789".contains(character) {
                    unicodeString.append(character)
                }
            }
            if let scalarInt = Int(unicodeString),
               let unicodeScalar = Unicode.Scalar(scalarInt) {
                return unicodeScalar
            }
            return nil
        }
        
        var result = ""
        var position = self.startIndex

        let range = NSRange(self.startIndex..<self.endIndex, in: self)
        let pattern = #"(&\S*?;)"#
        let unicodeScalarPattern = #"&#(\d*?);"#

        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
        regex.enumerateMatches(in: self, options: [], range: range) { matches, flags, stop in
            if let matches = matches {
                    if let range = Range(matches.range(at: 0), in:self) {
                        let rangePreceedingMatch = position..<range.lowerBound
                        result.append(contentsOf: self[rangePreceedingMatch])
                        let characterEntity = String(self[range])
                        if let replacement = characterEntities[characterEntity] {
                            result.append(replacement)
                        } else if let _ = characterEntity.range(of: unicodeScalarPattern, options: .regularExpression),
                                  let unicodeScalar = unicodeScalar(for: characterEntity) {
                            result.append(String(unicodeScalar))
                        }
                        position = self.index(range.lowerBound, offsetBy: characterEntity.count )
                    }
            }
        }
        if position != self.endIndex {
            result.append(contentsOf: self[position..<self.endIndex])
        }
        return result
    }
}
