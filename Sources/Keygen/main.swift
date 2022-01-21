import ArgumentParser
import Foundation
import Crypto

struct Keygen: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Generate a random sequence of bytes for use as a Symmetric Key.")
    
    @Option(name: .shortAndLong, help: "The number of bits in the Symmetric Key.")
    var bits: Int

    func validate() throws {
        guard bits > 0, bits % 8 == 0 else {
            throw ValidationError("<bits> must be a positive integer and factored by 8")
        }
    }
    
    func run() {
        print(SymmetricKey(size: .init(bitCount: bits)).dataRepresentation.base64EncodedString())
    }
}

extension ContiguousBytes {
    /// A Data instance created from the contiguous bytes by making a copy.
    var dataRepresentation: Data {
        return self.withUnsafeBytes { bytes in
            return Data(bytes: bytes.baseAddress!, count: bytes.count)
        }
    }
}

Keygen.main()
