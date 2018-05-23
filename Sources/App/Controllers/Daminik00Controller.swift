import Vapor
import HTTP

/// Here we have a controller that helps facilitate
/// creating typical REST patterns
final class Daminik00Controller: ResourceRepresentable {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    /// GET /daminik00
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("daminik00")
    }
    
    /// GET /daminik00/:string
    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
        switch string {
        case "github":
            return Response(redirect: "https://github.com/daminik00")
        default:
            return try view.make("daminik00")
        }
    }
    
    
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<String> {
        return Resource(index: index, show: show)
    }
}
