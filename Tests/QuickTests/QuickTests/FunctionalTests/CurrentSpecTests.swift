import Quick
import Nimble
import Dispatch

class CurrentSpecTests: QuickSpec {
    override class func spec() {
        it("returns nil when asking for AsyncSpec.current") {
            expect(AsyncSpec.current).to(beNil())
        }

        it("returns the currently executing spec") {
            let name: String = {
                let result = QuickSpec.current.name
                #if canImport(Darwin)
                return result.replacingOccurrences(of: "_", with: " ")
                #else
                return result
                #endif
            }()
            expect(name).to(match("returns the currently executing spec"))
        }

        let currentSpecDuringSpecSetup = QuickSpec.current

        it("returns nil when no spec is executing") {
            expect(currentSpecDuringSpecSetup).to(beNil())
        }

        it("supports XCTest expectations") {
            let expectation = QuickSpec.current.expectation(description: "great expectation")
            DispatchQueue.global(qos: .default).async { expectation.fulfill() }
            QuickSpec.current.waitForExpectations(timeout: 1)
        }
    }
}
