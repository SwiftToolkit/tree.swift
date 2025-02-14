import Foundation

typealias IsLastChild = Bool

extension String {
    static let levelLine = "│   "
    static let child     = "├──"
    static let lastChild = "└──"
    static let lastChildSpacing = "    "

    static func indentation(
        isLast: IsLastChild,
        ancestors: [IsLastChild]
    ) -> String {
        var indentation = ""

        ancestors.forEach { isLastAncestor in
            if isLastAncestor {
                indentation.append(lastChildSpacing) // "    "
            } else {
                indentation.append(levelLine)        // "│   "
            }
        }

        if isLast {
            indentation.append(lastChild) // └──
        } else {
            indentation.append(child)     // ├──
        }

        return indentation
    }
}
