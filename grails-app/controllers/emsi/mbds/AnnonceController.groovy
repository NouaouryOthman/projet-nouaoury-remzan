package emsi.mbds

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_MODO'])
class AnnonceController {

    AnnonceService annonceService
    def springSecurityService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def annonceList = Annonce.createCriteria().list (params) {
            if ( params.query ) {
                ilike("title", "%${params.query}%")
                ilike("description", "%${params.query}%")
            }
        }
        model: [annonceList: annonceList,annonceCount: annonceService.count()]
    }

    def show(Long id) {
        respond annonceService.get(id)
    }

    def create() {
        respond new Annonce(params)
    }

    def save(Annonce annonce) {
        if (annonce == null) {
            notFound()
            return
        }

        try {
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
            annonceService.save(annonce)
        } catch (ValidationException e) {
            respond annonce.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                redirect annonce
            }
            '*' { respond annonce, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond annonceService.get(id)
    }

    def update(Annonce annonce) {
        if (annonce == null) {
            notFound()
            return
        }

        try {
            annonceService.save(annonce)
        } catch (ValidationException e) {
            respond annonce.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                redirect annonce
            }
            '*' { respond annonce, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        annonceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'annonce.label', default: 'Annonce'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'annonce.label', default: 'Annonce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
