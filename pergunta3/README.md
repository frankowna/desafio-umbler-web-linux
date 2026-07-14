# Pergunta 3 - Deliverability de E-mail

## Objetivo

Esta seção apresenta uma abordagem para validação da configuração de entrega de e-mails (Deliverability).

O objetivo é verificar rapidamente se um domínio possui os principais registros DNS utilizados para autenticação e reputação de envio.

## Arquivos

- respostas.md → Explicação da solução.
- check_mail.sh → Script para validação dos registros DNS.

## Premissas

O script verifica:

- MX
- SPF
- DKIM
- DMARC
- PTR (Reverse DNS)