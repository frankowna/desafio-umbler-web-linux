# Pergunta 5 - Puppet

## Objetivo

Desenvolver um módulo Puppet responsável pelo provisionamento automatizado de um novo cliente em um ambiente de hospedagem compartilhada.

O módulo foi estruturado em classes independentes para facilitar reutilização, manutenção e evolução da infraestrutura.

## Estrutura

```
manifests/

init.pp

install.pp

config.pp

wordpress.pp

templates/

nginx_vhost.erb
```

## Fluxo

init.pp

↓

install.pp

↓

config.pp

↓

wordpress.pp

## Funcionalidades

- Instalação da stack web
- Configuração do Nginx
- Configuração do LiteSpeed/LSPHP
- Criação do usuário
- Criação da estrutura de diretórios
- Configuração do Virtual Host
- Habilitação do LSCache
- Instalação do WordPress

## Idempotência

Todos os recursos Puppet são declarativos.

Executar o módulo mais de uma vez não recria usuários, diretórios ou arquivos existentes, garantindo consistência do ambiente.

## Premissas

Para simplificar o desafio foram assumidas algumas premissas:

- Sistema baseado em Debian/Ubuntu.
- Repositórios já configurados.
- LiteSpeed/LSPHP disponível para instalação.
- WordPress obtido via pacote ou download oficial.

## Em produção

Em um ambiente produtivo eu adicionaria:

- Hiera para gerenciamento de parâmetros.
- Secrets Manager para senhas.
- Certificados TLS automatizados.
- Monitoramento.
- Backup.
- Testes com Puppet Lint.
- Integração em pipeline CI/CD.

## Observações

O módulo apresentado foi simplificado para atender ao escopo do desafio.

Em um ambiente corporativo eu utilizaria Hiera para gerenciamento de parâmetros, testes automatizados com Puppet Lint e integração do módulo em um pipeline CI/CD.