import ArgumentParser
import PathKit

@main
struct Tree: ParsableCommand {
    @Argument
    var path: Path = .current

    func validate() throws {
        if !path.exists {
            throw Error.invalidPath(path)
        }

        if !path.isDirectory {
            throw Error.notADirectory(path)
        }
    }

    func run() throws {
        print(path.absolute().string)
        try path.listChildren()
    }
}

extension Path {
    func listChildren(ancestors: [IsLastChild] = []) throws {
        let children = try children().sorted()
        let lastIndex = children.count - 1
        let enumeratedChildren = children.enumerated()
        try enumeratedChildren.forEach { tuple in
            let (index, child) = tuple
            let isLast = index == lastIndex

            if child.lastComponent.hasPrefix(".") {
                return
            }

            let indentation = String.indentation(isLast: isLast, ancestors: ancestors)

            if child.isFile {
                print(indentation, child.lastComponent)
            } else {
                print(indentation, child.lastComponent)
                var updatedAncestors = ancestors
                updatedAncestors.append(isLast)
                try child.listChildren(ancestors: updatedAncestors)
            }
        }
    }
}
