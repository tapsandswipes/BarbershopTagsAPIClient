# BarbershopTagsAPIClient

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)]() [![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift) 
[![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)]()

Swift library to make calls to barbershoptags.com public API.

## Usage

First, create a client instance with a name to identify yourseft to the server:

```swift
let client = BarbershopTagsAPIClient(name: "myApp")
```

then perfom a query with the `getTags` method:

```swift
let result = try await client.getTags(query: .init(term: "love me"), respone: .init(resultFields: [.title, …]))

print("Number of tags matching query: \(result.available)")
for tag in result.tags {
    print("Tag id: \(tag.id)")
    print("Tag title: \(tag.title)")
}
```
See [documentation](https://tapsandswipes.github.io/BarbershopTagsAPIClient/documentation/barbershoptagsapiclient/) for more options.
 
## Instalation

You can use the [Swift Package Manager](https://github.com/apple/swift-package-manager) by declaring **BarbershopTagsAPIClient** as a dependency in your `Package.swift` file:

```swift
.package(url: "https://github.com/tapsandswipes/BarbershopTagsAPIClient", from: "1.0.0")
```

*For more information, see [the Swift Package Manager documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).*


## Contact

- [Personal website](http://tapsandswipes.com)
- [GitHub](http://github.com/tapsandswipes)
- [Mastodon](https://mastodon.social/@acvivo)
- [LinkedIn](http://www.linkedin.com/in/acvivo)
- [Email](mailto:antonio@tapsandswipes.com)

If you use/enjoy BarbershopTagsAPIClient, let me know!

## License

### MIT License

Copyright (c) 2024 Antonio Cabezuelo Vivo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
