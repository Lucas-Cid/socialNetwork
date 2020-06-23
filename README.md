# Instruções de instalação do projeto

Você precisará do [Docker](https://www.docker.com/) e do [Docker Compose](https://docs.docker.com/compose/install/). Certifique-se de que não há nada de errado com a instalação destas ferramentas executando no terminal `docker -v` e `docker-compose -v`.

1. Abra o arquivo `Gemfile.lock` e exclua o seu conteúdo. Mantenha apenas um arquivo vazio,
1. Execute o script `initial_setup.sh`. Isso irá configurar o projeto pela primeira vez (e repopular o `Gemfile.lock`).

**Note que esta etapa pode demorar um pouco.**


# Como iniciar o servidor
Na pasta do projeto, execute `sudo docker-compose up`. Feito isso, acesse a porta 3000 do seu [localhost](localhost:3000).