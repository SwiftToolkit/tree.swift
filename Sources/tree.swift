import ArgumentParser
import PathKit

@main
struct Tree: ParsableCommand {
    @OptionGroup
    var options: Options

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
        print(path.absolute().string.bold)

        var files = 0
        var directories = 0

        try path.listChildren(
            filesCount: &files,
            directoriesCount: &directories,
            options: options
        )

        if !options.disableReport {
            print("\n")

            if files == 0 {
                print("\(directories) directories")
            } else {
                print("\(directories) directories, \(files) files")
            }
        }
    }
}

extension Path {
    func listChildren(
        ancestors: [IsLastChild] = [],
        filesCount: inout Int,
        directoriesCount: inout Int,
        options: Tree.Options
    ) throws {
        directoriesCount += 1

        if let maxLevel = options.maxLevel,
           ancestors.count >= maxLevel {
            return
        }

        var children = try children().sorted()
        if options.directoriesOnly {
            children = children.filter { $0.isDirectory }
        }

        let lastIndex = children.count - 1
        let enumeratedChildren = children.enumerated()
        try enumeratedChildren.forEach { tuple in
            let (index, child) = tuple
            let isLast = index == lastIndex

            if !options.includeHidden, child.lastComponent.hasPrefix(".") {
                return
            }

            let indentation = String.indentation(isLast: isLast, ancestors: ancestors)

            if child.isFile {
                filesCount += 1
                print(indentation, child.lastComponent)
            } else {
                print(indentation, child.lastComponent.bold)

                var updatedAncestors = ancestors
                updatedAncestors.append(isLast)
                try child.listChildren(
                    ancestors: updatedAncestors,
                    filesCount: &filesCount,
                    directoriesCount: &directoriesCount,
                    options: options
                )
            }
        }
    }
}
