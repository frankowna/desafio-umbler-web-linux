# Pergunta 3 - Deliverability de E-mail

## Objetivo

A entrega correta de e-mails depende não apenas do servidor SMTP, mas também da correta configuração dos registros DNS responsáveis pela autenticação e reputação do domínio.

Sempre que investigo problemas de entrega procuro validar primeiro os registros DNS antes de analisar logs do servidor de e-mail.

---

# Ordem da investigação

Minha sequência normalmente é:

1. Verificar resolução DNS.
2. Validar registros MX.
3. Validar SPF.
4. Validar DKIM.
5. Validar DMARC.
6. Confirmar PTR (Reverse DNS).
7. Consultar blacklists.
8. Analisar logs do servidor SMTP.

---

# MX

O registro MX informa quais servidores recebem os e-mails do domínio.

Exemplo:

```
mail.exemplo.com
```

---

# SPF

O SPF informa quais servidores estão autorizados a enviar mensagens utilizando aquele domínio.

Exemplo:

```
v=spf1 include:_spf.google.com ~all
```

---

# DKIM

O DKIM adiciona uma assinatura criptográfica às mensagens.

Essa assinatura permite validar que o conteúdo do e-mail não foi alterado durante o transporte.

---

# DMARC

O DMARC define a política aplicada quando SPF ou DKIM falham.

Além disso, permite o envio de relatórios sobre tentativas de spoofing.

---

# PTR

O PTR (Reverse DNS) relaciona o endereço IP ao nome do servidor.

Muitos provedores de e-mail consideram esse registro durante a avaliação da reputação do remetente.

---

# Outras verificações

Além dos registros DNS, também verifico:

- Fila do servidor SMTP.
- Logs do Exim ou Postfix.
- Blacklists públicas.
- Taxa de rejeição.
- Erros SMTP.
- Certificados TLS.
- Conectividade com o servidor remoto.

---

# Considerações

A validação desses registros costuma resolver grande parte dos problemas relacionados à entrega de mensagens.

Por esse motivo considero essa análise uma das primeiras etapas durante qualquer troubleshooting envolvendo e-mail.