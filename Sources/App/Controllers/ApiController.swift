import Vapor
import HTTP
import App

/// Here we have a controller that helps facilitate
/// creating typical REST patterns
final class ApiController: ResourceRepresentable {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    /// GET /api
    func index(_ req: Request) throws -> ResponseRepresentable {
        print("Hello Fuck")
        return try view.make("hello", [
            "name": "!!!"
            ], for: req)
    }
    
    /// GET /api/:string
    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
        print(req.parameters)
        switch string {
        case "getTransportCount":
            var conf = try Config()
            try conf.setup()
            return try Droplet(conf).client.get("http://api.daminik00.ru/res/routes.json")
        default:
            return try JSON(node: [
                "name" : [
                    "fuck" : [["hello":"by"],["hello":"by"],["hello":"by"]]
                ],
                "color" : "Black",
                "miles_driven" : "1244ml"
                ])
        }
    }
    
    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<String> {
        return Resource(
            index: index,
            show: show
        )
    }
}

