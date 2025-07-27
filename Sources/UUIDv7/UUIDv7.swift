// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
// MARK: - UUID v7 Extension

extension UUID {

    /// Generates a new UUID version 7 using the current timestamp in milliseconds.
    /// The first 48 bits encode the timestamp (in big-endian),
    /// while the remaining bits are derived from a random UUID.
    /// Bits 6 and 8 are patched to indicate version 7 and RFC 4122 variant.
    static func v7() -> UUID {
        /// Use as base structure
        let uuid = UUID()
        /// The underlying 16-byte representation of this UUID.
        var data = uuid.data
        // Encode current timestamp (UInt64 in milliseconds since 1970)
        // Take only the lower 6 bytes and reverse to big-endian
        data[0..<6] = .init(Date.nowEpochTime.littleEndian.data.subdata(in: 0..<6).reversed())
        // Set version (UUIDv7 = 0x7) in byte 6 (upper 4 bits)
        data[6] = (data[6] & 0x0F) | 0x70
        // Set variant (RFC 4122) in byte 8 (upper 2 bits = 10)
        data[8] = (data[8] & 0x3F) | 0x80
        // returns the final uuid object
        return data.object()
    }

    /// Converts this UUID into a version 7 UUID using the provided timestamp.
    /// The original UUID provides entropy for the non-timestamp bits.
    /// - Parameter date: The timestamp to embed in the UUID.
    /// - Returns: A UUIDv7 instance representing the given timestamp and the original entropy.
    func convertedToV7(using date: Date) -> UUID {
        /// The underlying 16-byte representation of this UUID instance.
        var data = self.data
        // Encode date timestamp (UInt64 in milliseconds since 1970)
        // Take only the lower 6 bytes and reverse to big-endian
        data[0..<6] = .init(date.epochTime.littleEndian.data.subdata(in: 0..<6).reversed())
        // Set version (UUIDv7 = 0x7) in byte 6 (upper 4 bits)
        data[6] = (data[6] & 0x0F) | 0x70
        // Set variant (RFC 4122) in byte 8 (upper 2 bits = 10)
        data[8] = (data[8] & 0x3F) | 0x80
        // returns the final uuid object
        return data.object()

    }
    /// The 16-byte `Data` representation of this UUID.
    var data: Data { .init(self) }

    /// The 16-byte array of bytes representing this UUID.
    var bytes: [UInt8] { .init(self) }

    /// Attempts to extract the `Date` encoded in a UUID v7 timestamp.
    /// Returns `nil` if the UUID is not version 7.
    var date: Date? {
        let data = self.data
        // Check if UUID is version 7
        guard (data[6] >> 4) == 0x7 else { return nil }
        // Convert first 6 bytes to UInt64 (pad with 2 leading zero bytes)
        let timestamp: UInt64 = .init(([0, 0] + data[0..<6]).reversed())
        // Convert milliseconds to seconds
        return .init(timeIntervalSince1970: TimeInterval(timestamp) / 1000)
    }
}

// MARK: - Data Initialization Helpers

fileprivate extension DataProtocol where Self: RangeReplaceableCollection {

    /// Converts any value into its raw byte representation using its memory layout.
    /// Useful for initializing a collection of bytes (e.g., `Data`, `[UInt8]`, etc.) from any type.
    /// - Parameter object: The value to convert into a sequence of bytes.
    init<T>(_ object: T) {
        self = Swift.withUnsafeBytes(of: object, Self.init)
    }
}

fileprivate extension Numeric {

    /// Converts numeric value to Data
    var data: Data { .init(self) }

    /// Initializes numeric value from a Data buffer
    init<D: DataProtocol>(_ data: D) {
        var value: Self = .zero
        let _ = withUnsafeMutableBytes(of: &value, data.copyBytes)
        self = value
    }
}

fileprivate extension ContiguousBytes {

    /// Converts the contiguous bytes into a value of type `T`.
    /// Assumes `Self` has at least `MemoryLayout<T>.size` bytes.
    func object<T>() -> T {
        withUnsafeBytes { $0.load(as: T.self) }
    }
}

// MARK: - Date Extensions

fileprivate extension Date {

    /// Current timestamp in milliseconds (as Double)
    static var nowEpochTimeMilliseconds: Double {
        Date().timeIntervalSince1970 * 1000
    }

    /// Current timestamp in milliseconds as UInt64
    static var nowEpochTime: UInt64 {
        .init(nowEpochTimeMilliseconds)
    }

    /// timestamp in milliseconds (as Double)
    var epochTimeMilliseconds: Double {
        timeIntervalSince1970 * 1000
    }

    /// timestamp in milliseconds as UInt64
    var epochTime: UInt64 {
        .init(epochTimeMilliseconds)
    }
}
