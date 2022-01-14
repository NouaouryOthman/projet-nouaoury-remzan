<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-user" class="skip" tabindex="-1">Aller au contenu</a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}">Page d'accueil</a></li>
        <sec:access expression="hasAnyRole('ROLE_ADMIN', 'ROLE_MODO')">
            <li><g:link class="list" action="index">Liste des utilisateurs</g:link></li>
        </sec:access>
        <li><g:link class="create" action="create">Créer utilisateur</g:link></li>
    </ul>
</div>

<div id="show-user" class="content scaffold-show" role="main">
    <h1>Afficher utilisateur</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="card text-center">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs">
                <li class="nav-item">
                    <a class="nav-link active disabled">Profil</a>
                </li>
                <li class="nav-item">
                    <g:link controller='user' action='edit' id='${user.id}'
                            class="nav-link">Modifier</g:link>
                </li>
            </ul>
        </div>

    <div class="card-body">
        <h5 class="card-title">Informations utilisateur N° : ${user.id}</h5>

    <div class="card-text">
        <div class="form-group">
            <label>ID :</label>
            <strong><label>${user.id}</label></strong>
        </div>

        <div class="form-group">
            <label>Username :</label>
            <strong><label>${user.username}</label></strong>
        </div>
        <sec:access expression="hasAnyRole('ROLE_ADMIN', 'ROLE_MODO')">
            <div class="form-group">
                <label>Mot de passe expiré :</label>
                <strong><label>
                    <g:if test="${user.passwordExpired}">Oui</g:if>
                    <g:if test="${!user.passwordExpired}">Non</g:if>
                </label></strong>
            </div>

            <div class="form-group">
                <label>Compte verrouillé :</label>
                <strong><label>
                    <g:if test="${user.accountLocked}">Oui</g:if>
                    <g:if test="${!user.accountLocked}">Non</g:if>
                </label></strong>
            </div>

            <div class="form-group">
                <label>Compte expiré :</label>
                <strong><label>
                    <g:if test="${user.accountExpired}">Oui</g:if>
                    <g:if test="${!user.accountExpired}">Non</g:if>
                </label></strong>
            </div>

            <div class="form-group">
                <label>Compte activé :</label>
                <strong><label>
                    <g:if test="${user.enabled}">Oui</g:if>
                    <g:if test="${!user.enabled}">Non</g:if>
                </label></strong>
            </div>
            </div>
            <g:form resource="${this.user}" method="DELETE">
                <button class="btn btn-danger" type="submit"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Êtes-vous sur ?')}');">Supprimer</button>
            </g:form>
        </sec:access>
    </div>
</div>
</body>
</html>
