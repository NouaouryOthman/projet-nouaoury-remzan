<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
    <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="bootstrap.css"/>
    <g:layoutHead/>
</head>

<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <a class="navbar-brand" href="/"><g:img dir="images" file="logo.png" width="40" height="40"/></a>
    <fieldset class="navbar-form navbar-left">
        <g:form controller="annonce" action="index" method="GET" class="form-inline">
            <div class="fieldcontain">
                <g:textField name="query" placeholder="Chercher une annonce" class="form-control" value="${params.query}"/>
                <button class="btn btn-success" type="submit">Chercher une annonce!</button>
            </div>
        </g:form>
    </fieldset>
    <ul class="navbar-nav">
        <li class="nav-item">
            <g:link class="nav-link active" controller="annonce">Annonces</g:link>
        </li>
        <li class="nav-item">
            <g:link class="nav-link" controller="annonce" action="create">Créez une annonce</g:link>
        </li>
        <sec:ifNotLoggedIn>
            <li class="nav-item">
                <g:link controller='login' action='auth' class="nav-link"><span class="glyphicon glyphicon-log-in"></span> Login</g:link>
            </li>
        </sec:ifNotLoggedIn>
        <sec:ifLoggedIn>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbardrop1" data-toggle="dropdown">
                    Bonjour <sec:loggedInUserInfo field='username'/> !&nbsp;
                </a>

                <div class="dropdown-menu">
                    <g:link controller='user' action='show' id='${sec.loggedInUserInfo(field: 'id')}'
                            class="dropdown-item">Profil</g:link>
                    <a class="dropdown-item" href="/logout">Logout</a>
                </div>
            </li>
        </sec:ifLoggedIn>
    </ul>
</nav>

<sec:ifLoggedIn>
    <sec:ifAnyGranted roles="ROLE_ADMIN, MODO_ROLE">
        <div class="wrapper d-flex align-items-stretch">
            <nav id="sidebar">
                <div class="custom-menu">
                    <button type="button" id="sidebarCollapse" class="btn btn-primary">
                        <i class="fa fa-bars"></i>
                        <span class="sr-only">Toggle Menu</span>
                    </button>
                </div>

                <h1><a href="/" class="logo disabled">Le Coin Coin</a></h1>
                <ul class="list-unstyled components mb-5">
                    <li class="active">
                        &nbsp;&nbsp;<span class="fa fa-columns mr-3"></span> Annonces
                    </li>
                    <li>
                        <a href="/annonce/create"><span class="fa fa-plus mr-3"></span> Ajouter annonce</a>
                    </li>
                    <li>
                        <a href="/annonce"><span class="fa fa-list mr-3"></span> Liste des annonces</a>
                    </li>
                    <li class="active">
                        &nbsp;&nbsp;<span class="fa fa-user mr-3"></span> Utilisateurs
                    </li>
                    <li>
                        <a href="/user/create"><span class="fa fa-plus mr-3"></span> Ajouter utilisateur</a>
                    </li>
                    <li>
                        <a href="/user"><span class="fa fa-list mr-3"></span> Liste des utilisateurs</a>
                    </li>
                    <li class="active">
                        &nbsp;&nbsp;<span class="fa fa-image mr-3"></span> Illustrations
                    </li>
                    <li>
                        <a href="/illustration/create"><span class="fa fa-plus mr-3"></span> Ajouter illustration</a>
                    </li>
                    <li>
                        <a href="/illustration"><span class="fa fa-list mr-3"></span> Liste des illustrations</a>
                    </li>
                </ul>

            </nav>


    </sec:ifAnyGranted>
</sec:ifLoggedIn>
<!-- Page Content  -->
<div id="content" class="p-4 p-md-5 pt-5">
    <g:layoutBody/>

    <div class="footer" role="contentinfo"></div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

</div>
</div>
<asset:javascript src="jquery.min.js"/>
<asset:javascript src="popper.js"/>
<asset:javascript src="bootstrap.min.js"/>
<asset:javascript src="main.js"/>

</body>
</html>
