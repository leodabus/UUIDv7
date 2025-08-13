# UUIDv7

Swift extension to generate and decode UUIDv7.

## Usage

### • Generate a UUIDv7 (timestamp-based)

```swift
let uuid = UUID.v7()
print(uuid)               // Example: 018A6D78-0F1B-7E4F-947A-4094C38ADCE1
print(uuid.date)          // Extracts the encoded creation timestamp
```

---

### • Convert an existing UUID to version 7 using a specific date

Useful when you already have a legacy UUID and want to embed a known timestamp (e.g., database creation date):

```swift
let legacyUUID = UUID()
let creationDate = Date(timeIntervalSince1970: 1_694_123_456) // custom timestamp
let uuidv7 = legacyUUID.convertedToV7(using: creationDate)

print(uuidv7)             // Preserves entropy from the original UUID, injects timestamp
print(uuidv7.date)        // Will match `creationDate` accurately
```

---

### • Use with sorting and storage

UUIDv7 values are chronologically and lexicographically sortable, which makes them ideal for:

- Ordered identifiers in time-sensitive databases  
- Timeline-safe keys across distributed systems  
- Audit logs and traceable objects

```swift
let sorted = [UUID.v7(), UUID.v7(), UUID.v7()].sorted()
print(sorted)             // Guaranteed to reflect creation order
```

---

### • Verify timestamp integrity (optional check)

```swift
let referenceDate = Date()
let uuid = UUID().convertedToV7(using: referenceDate)

if let extracted = uuid.date {
    print("Match:", abs(extracted.timeIntervalSince(referenceDate)) < 0.001)
}
```
