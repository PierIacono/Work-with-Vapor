
import Fluent
import Vapor

struct VoloController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let voli = routes.grouped("voli")
        voli.get(use: index)
        voli.post(use: create)
        voli.put(use: update)

        
        voli.group(":voloID") { volo in
        volo.delete(use: delete)
        }
    }

//    GET INDEX    
    func index(req: Request) throws -> EventLoopFuture<[Volo]>{
        
            //Return all voli
        return volo.save(on: req.db).all()
    }
    
    //POST
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        let volo = try req.content.decode(Volo.self)
        return volo.save(on:req.db).transform(to: .ok)
    }
    
    //PUT
    func update(req:Request) throws -> EventLoopFuture<HTTPStatus>{
        
        let volo = try req.content.decode(Volo.self)
        return Volo.find(volo.id, on: req.db)
        
        //The unwrap checks if the volo exist
        
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.id = volo.id
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    //DELETE
    func delete(req:Request) throws -> EventLoopFuture<HTTPStatus>{
        
        Volo.find(req.parameters.get("voloId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ $0.delete(on:req.db)}
            .transform(to: .ok)
    }
}



//    fileprivate func getVolo(req: Request) throws -> EventLoopFuture<Dinner.Public> {
  //
  //            guard let voloId = req.parameters.get("id", as: UUID.self) else {
  //              throw Abort(.badRequest)
  //          }
  //        //    Query
  //            return Volo.query(on: req.db)
  //            .filter(\.$id == id)
  //            .first()
  //            .unwrap(or: Abort(.notFound))
  //            }
  //
  //
  //            func delete(req: Request) async throws -> HTTPStatus {
  //                guard let volo = try await Volo.find(req.parameters.get("VoloID"), on: req.db) else {
  //                    throw Abort(.notFound)
  //                }
  //                try await volo.delete(on: req.db)
  //                return .ok
  //            }
