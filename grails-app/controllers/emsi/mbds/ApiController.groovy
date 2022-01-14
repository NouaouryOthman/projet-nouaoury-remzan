package emsi.mbds

import grails.converters.JSON
import grails.converters.XML
import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

class ApiController {

    UserService userService
    AnnonceService annonceService
    def springSecurityService
    /**
     * GET / PUT / PATCH / DELETE
     * Pour une note max : Gérer la notion de role en plus de l'utilisateur
     */
    @Secured('ROLE_ADMIN')
    def user() {
        switch (request.getMethod()) {
            case "GET":
                if (!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if (!userInstance)
                    return response.status = 404
                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "PUT":
                if (!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if (!userInstance)
                    return response.status = 404
                if(request.JSON.username != null)
                    userInstance.username = request.JSON.username
                if(request.JSON.password != null)
                    userInstance.password = request.JSON.password
                if(request.JSON.enabled != null)
                    userInstance.enabled = request.JSON.enabled
                if(request.JSON.accountLocked != null)
                    userInstance.accountLocked = request.JSON.accountLocked
                if(request.JSON.accountExpired)
                    userInstance.accountExpired = request.JSON.accountEpired
                userService.save(userInstance)
                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "PATCH":
                if (!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if (!userInstance)
                    return response.status = 404
                if(request.JSON.username)
                    userInstance.username = request.JSON.username
                if(request.JSON.password)
                    userInstance.password = request.JSON.password
                userService.save(userInstance)
                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "DELETE":
                if (!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if (!userInstance)
                    return response.status = 404
                UserRole.deleteAll(UserRole.findAllByUser(userInstance))
                userService.delete(params.id)
                return response.status = 200
                break
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    /**
     * POST / GET
     */
    @Secured('ROLE_ADMIN')
    def users() {
        switch (request.getMethod()) {
            case "GET":
                def users = User.getAll()
                if (!users)
                    return response.status = 404
                response.withFormat {
                    xml { render users as XML }
                    json { render users as JSON }
                }
                break
            case "POST":
                def userInstance = new User()
                userInstance.username = request.JSON.username
                userInstance.password = request.JSON.password
                if(request.JSON.role != null){
                    UserRole.create(userInstance, Role.get(request.JSON.role),true)
                }
                UserRole.create(userInstance, Role.findByAuthority("USER_ROLE"),true)
                if (!userService.save(userInstance))
                    return response.status = 400
                response.withFormat{
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }
    /**
     * GET / PUT / PATCH / DELETE
     */
    @Secured('ROLE_ADMIN')
    def annonce()  {
        switch(request.getMethod()) {
            case "GET":
                if (!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)
                if (!annonceInstance)
                    return response.status = 404
                response.withFormat {
                    xml { render annonceInstance as XML}
                    json { render annonceInstance as JSON }
                }
                break
            case "PUT":
                if (!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)
                if (!annonceInstance)
                    return response.status = 404
                if(request.JSON.title != null)
                    annonceInstance.title = request.JSON.title
                if(request.JSON.description != null)
                    annonceInstance.description = request.JSON.description
                if(request.JSON.price != null)
                    annonceInstance.price = request.JSON.price
                if(request.JSON.status != null)
                    annonceInstance.status = request.JSON.status
                annonceService.save(annonceInstance)
                response.withFormat {
                    xml { render annonceInstance as XML }
                    json { render annonceInstance as JSON }
                }
                break
            case "PATCH":
                if (!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)
                if (!annonceInstance)
                    return response.status = 404
                if(request.JSON.title != null)
                    annonceInstance.title = request.JSON.title
                if(request.JSON.description != null)
                    annonceInstance.description = request.JSON.description
                annonceService.save(annonceInstance)
                response.withFormat {
                    xml { render annonceInstance as XML }
                    json { render annonceInstance as JSON }
                }
                break
            case "DELETE":
                if (!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)
                if (!annonceInstance)
                    return response.status = 404
                annonceService.delete(params.id)
                return response.status = 200
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    /**
     * POST / GET
     * Pour une note maximale : gérer la notion d'illustration
     */
    @Secured('ROLE_ADMIN')
    def annonces() {
        switch (request.getMethod()) {
            case "GET":
                def annonces = Annonce.getAll()
                if (!annonces)
                    return response.status = 404
                response.withFormat {
                    xml { render annonces as XML }
                    json { render annonces as JSON }
                }
                break
            case "POST":
                def annonce = new Annonce(
                        title: params.title,
                        description: params.description,
                        price: params.price
                )
                def i = 0
                annonce.setAuthor(springSecurityService.currentUser)
                annonce.setRef(annonce.getTitle() + "@" + new SimpleDateFormat("ddMMyyyyhhmmss").format(new Date()))
                annonce.setStatus(false)
                def illustrations = new ArrayList<Illustration>()
                request.getFiles("images").each { file ->
                    if (file.getSize() > 0 && file.getContentType().split('/')[0] == "image") {
                        def illustration = new Illustration()
                        illustration.setFilename(annonce.getTitle() + "_" + annonce.getAuthor().getUsername() + "_" + new SimpleDateFormat("ddMMyyyyhhmmss").format(new Date()) + "_" + i + ".jpeg")
                        illustration.setAnnonce(annonce)
                        illustrations.add(illustration)
                        file.transferTo(new File(grailsApplication.config.assets.path + annonce.getTitle() + "_" + annonce.getAuthor().getUsername() + "_" + new SimpleDateFormat("ddMMyyyyhhmmss").format(new Date()) + "_" + i + ".jpeg"))
                        i++
                    }
                }
                annonce.setIllustrations(illustrations)
                if (!annonce)
                    return response.status = 400
                if(annonceService.save(annonce))
                    return response.status = 201
                break
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }
}

