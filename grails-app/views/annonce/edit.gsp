<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<a href="#edit-annonce" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="edit-annonce" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${this.annonce}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.annonce}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <div class="card text-center">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs">
                <li class="nav-item">
                    <g:link controller="annonce" action="show" id="${annonce.id}" class="nav-link">Voir annonce</g:link>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled active">Modifier annonce</a>
                </li>
            </ul>
        </div>

        <div class="card-body">
            <h5 class="card-title">Annonce : ${annonce.title}</h5>
            <g:form resource="${this.annonce}" method="PUT">
                <g:hiddenField name="version" value="${this.annonce?.version}"/>
                <fieldset class="form">
                    <div class="form-group">
                        <g:textField name="title" placeholder="Titre" value="${annonce.title}"/>
                    </div>

                    <div class="form-group">
                        <g:textArea name="description" placeholder="Description" value="${annonce.description}"/>
                    </div>

                    <div class="form-group">
                        <g:textField name="price" placeholder="Price" value="${annonce.price}"/>
                    </div>

                </fieldset>
                <fieldset class="buttons form-group">
                    <input class="save btn btn-success" type="submit"
                           value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                </fieldset>
            </g:form>
            <g:form resource="${this.annonce}" method="DELETE">
                <button class="btn btn-danger delete" type="submit"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Supprimer</button>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>
