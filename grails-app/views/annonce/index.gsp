<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}"/>
    <title>Annonces</title>
    <asset:stylesheet src="annonce.css"/>
</head>

<body>
<a href="#list-annonce" class="skip" tabindex="-1">Aller au contenu</a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}">Page d'accueil</a></li>
        <li><g:link class="create" action="create">Ajouter annonce</g:link></li>
    </ul>
</div>

<div id="list-annonce" class="content scaffold-list" role="main">
    <h1>Liste des annonces</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:each in="${annonceList}">
        <div class="card mb-3" style="max-width: 700px;">
            <div class="row no-gutters">
                <div class="col-md-4">
                    <g:img src="${it.illustrations[0].filename}" class="card-img" alt="${it.title}"/>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><g:link controller="annonce" action="show" id="${it.id}">${it.title}</g:link></h5>
                        <p class="card-text">${it.description}</p>
                        <p class="products-price">${it.price} $</p>
                        <p class="card-text"><small class="text-muted">Créé le <g:formatDate format="dd-MM-yyyy" date="${it.dateCreated}"/></small></p>
                    </div>
                </div>
            </div>
        </div>
    </g:each>
    <g:paginate total="${annonceCount ?: 0}" params="${params}"/>
</body>
</html>