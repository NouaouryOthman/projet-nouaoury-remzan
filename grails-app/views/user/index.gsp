<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Utilisateurs</title>
</head>

<body>
<a href="#list-user" class="skip" tabindex="-1">Voir le contenu</a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}">Page d'accueil</a></li>
        <li><g:link class="create" action="create">Créer utilisateur</g:link></li>
    </ul>
</div>

<div id="list-user" class="content scaffold-list" role="main">
    <h1>La liste des utilisateurs</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table">
        <thead>
        <th>ID</th>
        <th>Username</th>
        <th></th>
        <th></th>
        <th></th>
        </thead>
        <tbody>
        <g:each in="${userList}">
            <tr>
                <td>${it.id}</td>
                <td>${it.username}</td>
                <td><g:link controller='user' action='show' id='${it.id}'
                            class="btn btn-primary"><span class="fa fa-eye"></span></g:link></td>
                <td><g:link controller='user' action='show' id='${it.id}'
                            class="btn btn-success"><span class="fa fa-pencil"></span></g:link></td>
                <td>
                    <g:form resource="${it}" method="DELETE">
                        <button class="btn btn-danger" type="submit"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Êtes-vous sur ?')}');">
                            <span class="fa fa-trash"></span>
                        </button>
                    </g:form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <g:paginate total="${userCount ?: 0}"/>

</div>
</body>
</html>