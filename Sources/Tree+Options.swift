//
//  Options.swift
//  tree.swift
//
//  Created by Natan Rolnik on 20/02/2025.
//

import ArgumentParser

extension Tree {
    struct Options: ParsableArguments {
        @Option(name: .customShort("L"))
        var maxLevel: Int?

        @Flag(name: .customShort("a"))
        var includeHidden = false

        @Flag(name: .customShort("d"))
        var directoriesOnly = false

        @Flag(name: .customLong("noreport"))
        var disableReport = false
    }
}
