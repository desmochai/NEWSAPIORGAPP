import SwiftUI

// Reference : https://swiftwithmajid.com/2019/12/04/must-have-swiftui-extensions/

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}


