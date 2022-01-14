package emsi.mbds

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(redirect: "/annonce")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
