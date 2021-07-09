
![Platform](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Language](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)

# NEWSAPI.ORG SwiftUI App
Code follows [Raywenderlich][RW] style guide.

## Dependencies

None

## Requirements

- iOS 14.0 and Above
- Xcode 12+

### Version Management

* Build Number willl increased for each iTunes Connect submission
* App version will only increase on app submiting to App Store
* Each version will have build number starting from 1000

## Architecture & Frameworks

- Clean MVVM Feature Driven Architecture
- Uses [SwiftUI][SUI] & [Combine][COM]
  
## Git
- This project will follow [GitFlow][GF] version control workflow convections 
- `dev` will be the semi-stable branch with `tag` on each stable merge. This is the branch from where IPA should be published to iTunes Test Flight
- `master` will have code that are fully stable with `release` on each merge. App store publishing should be done from this branch only.

[RW]: https://github.com/raywenderlich/swift-style-guide
[GF]: https://www.atlassian.com/git/tutorials/comparing-workflows
[FL]: https://fastlane.tools
[COM]: https://developer.apple.com/documentation/combine
[SUI]: https://developer.apple.com/documentation/swiftui/

## Todo
- Add UI tests
- Add a linter
- Clean up

