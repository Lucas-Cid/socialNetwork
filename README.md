# Instruções de instalação do projeto

Você precisará do [Docker](https://www.docker.com/) e do [Docker Compose](https://docs.docker.com/compose/install/). Certifique-se de que não há nada de errado com a instalação destas ferramentas executando no terminal `docker -v` e `docker-compose -v`.

1. Execute o script `initial_setup.sh`. Isso irá configurar o projeto pela primeira vez.
2. Inicie o servidor. Siga as instruções abaixo.

**Note que esta etapa pode demorar um pouco.**

Caso não seja possível executar o arquivo mencionado, execute em seu terminal:

```
chmod +x initial_setup.sh
```


# Como iniciar o servidor
Na pasta do projeto, execute `sudo docker-compose up`. Feito isso, acesse a porta 3000 do seu [localhost](localhost:3000).