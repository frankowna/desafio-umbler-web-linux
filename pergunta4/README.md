# Pergunta 4 - Docker

## Objetivo

Esta seção apresenta um ambiente Docker para execução de aplicações PHP utilizando Nginx e MariaDB.

A solução foi desenvolvida considerando simplicidade, isolamento entre serviços e facilidade de manutenção.

## Componentes

- Nginx
- PHP-FPM
- MariaDB

## Estrutura

- nginx/ → Configuração do Virtual Host
- php/ → Imagem personalizada do PHP
- www/ → Aplicação PHP
- docker-compose.yml → Orquestração dos containers

## Como executar

```bash
docker compose up -d
```

Após iniciar os containers:

```
http://localhost
```

Será exibida a página **phpinfo()**, permitindo validar a comunicação entre Nginx e PHP-FPM.

## Persistência

Os dados do MariaDB são armazenados em um volume Docker nomeado, garantindo que não sejam perdidos caso os containers sejam recriados.

## Evoluções recomendadas para produção

Embora o ambiente apresentado atenda aos requisitos do desafio, em um ambiente produtivo eu consideraria as seguintes melhorias:

- Implementação de Health Checks para todos os containers.
- Utilização de uma rede Docker dedicada.
- Externalização das variáveis de ambiente através de arquivo `.env`.
- Definição de limites de CPU e memória.
- Configuração de certificados TLS/SSL.
- Integração com monitoramento e observabilidade.
- Estratégia automatizada de backup do banco de dados.
- Pipeline CI/CD para build, testes e publicação das imagens.
- Versionamento das imagens Docker.
- Execução dos containers utilizando usuários não privilegiados.