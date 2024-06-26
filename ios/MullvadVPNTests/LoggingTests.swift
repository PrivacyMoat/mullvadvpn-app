//
//  LoggingTests.swift
//  MullvadVPNTests
//
//  Created by Emils on 04/04/2024.
//  Copyright © 2024 Mullvad VPN AB. All rights reserved.
//

import Foundation
@testable import MullvadLogging
import XCTest

class MullvadLoggingTests: XCTestCase {
    func temporaryFileURL() -> URL {
        // Create a URL for an unique file in the system's temporary directory.
        let directory = NSTemporaryDirectory()
        let filename = UUID().uuidString
        let fileURL = URL(fileURLWithPath: directory).appendingPathComponent(filename)

        // Add a teardown block to delete any file at `fileURL`.
        addTeardownBlock {
            try? FileManager.default.removeItem(at: fileURL)
        }

        // Return the temporary file URL for use in a test method.
        return fileURL
    }

    func testLogFileOutputStreamWritesHeader() {
        let headerText = "This is a header"
        let logMessage = "And this is a log message\n"
        let fileURL = temporaryFileURL()
        let stream = LogFileOutputStream(fileURL: fileURL, header: headerText)
        stream.write(logMessage)
        sync()

        let contents = String(decoding: try! Data(contentsOf: fileURL), as: UTF8.self)
        XCTAssertEqual(contents, "\(headerText)\n\(logMessage)")
    }

    func testLogHeader() {
        let expectedHeader = "Header of a log file"

        var builder = LoggerBuilder(header: expectedHeader)
        let fileURL = temporaryFileURL()
        builder.addFileOutput(fileURL: fileURL)

        builder.install()

        Logger(label: "test").info(":-P")

        sync()

        let contents = String(decoding: try! Data(contentsOf: fileURL), as: UTF8.self)

        XCTAssert(contents.hasPrefix(expectedHeader))
    }
}
