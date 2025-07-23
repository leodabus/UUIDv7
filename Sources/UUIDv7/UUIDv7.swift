// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

extension DataProtocol where Self: RangeReplaceableCollection {
    init<N: Numeric>(_ numeric: N) {
        self = withUnsafeBytes(of: numeric, Self.init)
    }
}
extension Numeric {
    var data: Data { .init(self) }
    init<D: DataProtocol>(_ data: D) {
        var value: Self = .zero
        let size = withUnsafeMutableBytes(of: &value, data.copyBytes)
        self = value
    }
}
extension Data {
    func object<T>() -> T {
        withUnsafeBytes { $0.load(as: T.self) }
    }
}
extension Date {
    static var nowEpochTimeMilliseconds: Double { Date().timeIntervalSince1970 * 1000 }
    static var nowEpochTime: UInt64 { .init(nowEpochTimeMilliseconds) }
}

extension UUID {

    static var v7: UUID {
        var uuid = UUID()
        var bytes = withUnsafeBytes(of: uuid) { Data($0) }
        bytes[0..<6] = .init(Date.nowEpochTime.littleEndian.data.subdata(in: 0..<6).reversed())
        bytes[6] = (bytes[6] & 0x0F) | 0x70
        bytes[8] = (bytes[8] & 0x3F) | 0x80
        return bytes.object()
    }

    var date: Date? {
        let bytes = withUnsafeBytes(of: uuid) { Data($0) }
        guard (bytes[6] >> 4) == 0x7 else { return nil }
        let timestamp: UInt64 = .init(([0,0] + bytes[0..<6]).reversed())
        return .init(timeIntervalSince1970: TimeInterval(timestamp) / 1000)
    }
}
