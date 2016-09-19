import Foundation

public protocol ReqlArg {
    func reqlJSON() throws -> String
}

extension String : ReqlArg {
    public func reqlJSON() throws -> String {
        return "\"\(self)\""
    }
}

extension Bool : ReqlArg {
    public func reqlJSON() throws -> String {
        if self {
            return "true"
        } else {
            return "false"
        }
    }
}

extension Int : ReqlArg {
    public func reqlJSON() throws -> String {
        return "\(self)"
    }
}

extension UInt : ReqlArg {
    public func reqlJSON() throws -> String {
        return "\(self)"
    }
}

extension Float : ReqlArg {
    public func reqlJSON() throws -> String {
        return "\(self)"
    }
}

extension Double : ReqlArg {
    public func reqlJSON() throws -> String {
        return "\(self)"
    }
}

extension Array : ReqlArg {
    public func reqlJSON() throws -> String {
        var str = "["
        str += try ReqlTerm.makeArray.rawValue.reqlJSON()
        str += ",["
        for (idx, value) in self.enumerated() {
            guard let v = value as? ReqlArg else {
                throw Error(code: .reql(backtrace: nil), reason: "All items in a ReqlArg array must conform to ReqlArg. '\(value)' does not.")
            }

            str += try v.reqlJSON()
            if idx + 1 < self.count {
                str += ","
            }
        }
        str += "]]"
        return str
    }
}

extension Dictionary : ReqlArg {
    public func reqlJSON() throws -> String {
        var str = "{"
        for (idx, element) in self.enumerated() {
            guard let k = element.key as? String else {
                throw Error(code: .reql(backtrace: nil), reason: "All keys in a ReqlArg dictionary must be strings. '\(element.key)' is not.")
            }
            guard let v = element.value as? ReqlArg else {
                throw Error(code: .reql(backtrace: nil), reason: "All values in a ReqlArg dictionary must conform to ReqlArg. '\(element.value)' does not.")
            }

            str += try k.reqlJSON()
            str += ":"
            str += try v.reqlJSON()
            if idx + 1 < self.count {
                str += ","
            }
        }
        str += "}"
        return str
    }
}
