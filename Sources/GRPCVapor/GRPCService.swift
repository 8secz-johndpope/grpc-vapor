//
//  GRPCService.swift
//  
//
//  Created by Michael Schlicker on 13.12.19.
//

import Foundation
import NIO
import Vapor

/**
`GRPCService` is a protocol that is implemented to declare gRPC services that can contain remote procedure calls.
 This protocol requires services to contain a `serviceName` and provide a `handleMethod`method that maps requests to call handlers which can call the procedures.
*/
public protocol GRPCService {

    /// A string containing the services name.
    var serviceName: String { get }

    /**
    Returns associated call handler of the service for a procedure call name and the associated Vapor `Request`.

     This method is usually generated by the code generator for every `GRPCService`.

    - parameter  methodName: `String` with the name of the called remote procedure.
    - parameter `vaporRequest`: Incoming Vapor `Request`instance.
    - returns: An `AnyCallHandler` call handler that calls the requested procedure.
    */
    func handleMethod(methodName: String, vaporRequest: Request) -> AnyCallHandler?
}

public extension GRPCService {

    /// The default implementation of the `serviceName` returns the last part of the services class or struct name using reflection.
    var serviceName: String {
        let description = String(describing: self)
        let components = description.components(separatedBy: ".")
        return components.last ?? description
    }

    /**
    The default implementation of the `handleMethod` method always returns `nil`. T
     This implementation should be overriden by the code generated for every service.
     The default implementation however is provided in order to prevent syntax errors before running the code generator and developers from implementing this method themselves.
     */
    func handleMethod(methodName: String, vaporRequest: Request) -> AnyCallHandler? {
        return nil
    }
}
