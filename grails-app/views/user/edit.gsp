<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<a href="#edit-user" class="skip" tabindex="-1">Aller au contenu</a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}">Page d'accueil</a></li>
        <sec:access expression="hasAnyRole('ROLE_ADMIN', 'ROLE_MODO')">
            <li><g:link class="list" action="index">Liste des utilisateurs</g:link></li>
        </sec:access>
        <li><g:link class="create" action="create">Créer utilisateur</g:link></li>
    </ul>
</div>

<h1>Mettre à jour profil</h1>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div class="card text-center">
    <div class="card-header">
        <ul class="nav nav-tabs card-header-tabs">
            <li class="nav-item">
                <g:link controller='user' action='show' id='${this.user.id}'
                        class="nav-link">Profil</g:link>
            </li>
            <li class="nav-item">
                <a class="nav-link active disabled">Modifier</a>
            </li>
        </ul>
    </div>

    <div class="card-body">
        <h5 class="card-title">Modifier utilisateur N° : ${user.id}</h5>

        <div id="edit-user" class="content scaffold-edit" role="main">
            <g:hasErrors bean="${this.user}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.user}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form resource="${this.user}" method="PUT" class="form">
                <g:hiddenField name="version" value="${this.user?.version}"/>
                <div class="form-group">
                    <label class="control-label">Username</label>
                    <g:textField type="text" name="username"
                                 value="${user.username}"/>
                </div>

                <div class="form-group">
                    <label class="control-label">Password</label>
                    <g:passwordField type="password" name="password"
                                     value="${user.password}"/>
                </div>
                <sec:access expression="hasAnyRole('ROLE_ADMIN', 'ROLE_MODO')">
                    <div class="form-group">
                        <label class="control-label">Mot de passe expiré</label>
                        <g:checkBox type="checkbox" name="password"
                                    value="${user.passwordExpired}"/>
                    </div>

                    <div class="form-group">
                        <label class="control-label">Compte verrouillé</label>
                        <g:checkBox type="checkbox" name="accountLocked"
                                    value="${user.accountLocked}"/>
                    </div>

                    <div class="form-group">
                        <label class="control-label">Compte expiré</label>
                        <g:checkBox type="checkbox" name="accountExpired"
                                    value="${user.accountExpired}"/>
                    </div>

                    <div class="form-group">
                        <label class="control-label">Compte activé</label>
                        <g:checkBox type="checkbox" name="accountExpired"
                                    value="${user.enabled}"/>
                    </div>
                </sec:access>
                <fieldset class="buttons">
                    <input class="btn btn-success" type="submit"
                           value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                </fieldset>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>
