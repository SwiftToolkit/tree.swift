import Foundation
@preconcurrency import PathKit

extension Tree {
    enum Error: Swift.Error {
        case invalidPath(Path)
        case notADirectory(Path)
    }
}

extension Tree.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case let .invalidPath(path):
            "The path \"\(path.absolute().string)\" does not exist."
        case let .notADirectory(path):
            "The path \"\(path.absolute().string)\" is not a directory."
        }
    }
}
