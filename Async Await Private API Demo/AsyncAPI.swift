//
//  AsyncAPI.swift
//  Async Await Private API Demo
//
//  Created by Trevor Whittingham on 10/25/22.
//

import Foundation

class AsyncAPI {
    
    /// Note on `withCheckedThrowingContinuation`
    ///
    /// From Apple's documentation:
    /// "Resuming from a continuation more than once is undefined behavior. Never resuming leaves the task in a suspended state indefinitely, and leaks any associated resources. CheckedContinuation logs a message if either of these invariants is violated."
    ///
    /// `CheckedContinuation` is highly recommended for development purposes, and is generally ok for a production environment as well.
    /// If performance improvements are absolutely necessary, `UnsafeContinuation` has slightly less overhead than the Checked version & can be easily swapped out.
    /// E.g. below we could change `withCheckedThrowingContinuation` to `withUnsafeThrowingContinuation` and no other changes would be necessary.
    
    func loadPeopleAsync() async throws -> [StarWarsPerson] {
        try await withCheckedThrowingContinuation { continuation in
            PrivateStarWarsAPI().loadPeople { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func loadPeopleAsyncWithSwitch() async throws -> [StarWarsPerson] {
        try await withCheckedThrowingContinuation { continuation in
            PrivateStarWarsAPI().loadPeople { result in
                switch result {
                case let .success(people):
                    continuation.resume(returning: people)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}
