# Changelog

## [v1.0.2] - 2025-07-27

### Added
- `UUID.convertedToV7(using:)`: Converts an existing UUID into a version 7 UUID using a custom `Date` timestamp. Useful for assigning meaningful temporal context to legacy UUIDs.
- `UUID.bytes`: Exposes the 16-byte array representation of the UUID (`[UInt8]`), complementing the existing `data` property.

### Changed
- Refactored `UUID.v7` from a computed property to a static method `UUID.v7()` for better clarity and intention.
- Improved documentation across all helpers and extensions.

### Fixed
- Ensured strict adherence to UUIDv7 byte layout, with correct encoding of timestamp in big-endian format and correct version/variant bits.

---

## [v1.0.1] - 2024-XX-XX

### Added
- Initial implementation of UUIDv7 generation via `UUID.v7` computed property.
- Timestamp extraction via `UUID.date`.

---

## [v1.0.0] - 2024-XX-XX

Initial release.

