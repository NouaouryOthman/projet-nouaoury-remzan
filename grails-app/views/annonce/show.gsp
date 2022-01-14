<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-annonce" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>


<div id="show-annonce" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="card text-center">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs">
                <li class="nav-item">
                    <a class="nav-link active disabled">Voir annonce</a>
                </li>
                <li class="nav-item">
                    <g:link controller="annonce" action="edit" id="${annonce.id}" class="nav-link"
                            href="#">Modifier annonce</g:link>
                </li>
            </ul>
        </div>

        <div class="card-body">
            <h5 class="card-title">Annonce : ${annonce.title}</h5>

            <p class="card-text">Description : ${annonce.description}</p>

            <p class="card-text">Publié le : <g:formatDate format="dd-MM-yyyy" date="${annonce.dateCreated}"/></p>

            <p class="card-text">Publié par : <g:link controller="user" action="show"
                                                      id="${annonce.author.id}">${annonce.author.username}</g:link></p>

            <div class="row">
                <g:each in="${annonce.illustrations}">
                    <div class="col-md-4">
                        <div class="thumbnail">
                            <g:img file="${it.filename}" class="img-fluid" style="width:100%; height: 50%"/>
                        </div>
                    </div>
                </g:each>
            </div>
            <g:form resource="${this.annonce}" method="DELETE">
                <button class="btn btn-danger delete" type="submit"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Supprimer</button>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>
