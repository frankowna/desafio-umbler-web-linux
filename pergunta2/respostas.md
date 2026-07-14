# Pergunta 2 - Arquitetura Web

## Cenário

Para ambientes WordPress, minha prioridade é construir uma arquitetura simples, segura e de fácil manutenção.

O Nginx atua como servidor web responsável pelo recebimento das requisições HTTP, entrega de conteúdo estático e encaminhamento das requisições dinâmicas para o PHP-FPM (LSPHP em ambientes LiteSpeed).

Essa separação reduz consumo de recursos e melhora significativamente o desempenho quando comparada a arquiteturas monolíticas.

---

# Fluxo da requisição

Cliente

↓

DNS

↓

Nginx

↓

PHP-FPM / LSPHP

↓

WordPress

↓

Banco de Dados

↓

Resposta ao Cliente

---

# Boas práticas adotadas

## Cache

Arquivos estáticos recebem cache utilizando:

- expires
- Cache-Control

Isso reduz requisições repetidas ao servidor.

---

## Segurança

Foram consideradas as seguintes práticas:

- Bloqueio de arquivos ocultos
- Restrição de acesso a arquivos sensíveis
- Logs separados
- Limitação do tamanho de upload
- Utilização do try_files para evitar execução indevida

---

## Performance

As principais otimizações seriam:

- HTTP/2
- Compressão Gzip ou Brotli
- Cache de objetos
- Redis
- OPcache
- CDN
- Keep Alive

Em ambientes LiteSpeed também utilizaria LSCache, que oferece excelente integração com WordPress.

---

# LiteSpeed

Caso o ambiente utilize LiteSpeed ou OpenLiteSpeed, substituiria o PHP-FPM pelo LSPHP.

O LSPHP apresenta melhor integração com o LiteSpeed, menor consumo de memória e excelente desempenho em aplicações PHP.

Outro diferencial importante é o LSCache, que permite cache em nível de aplicação com excelente desempenho para WordPress.

---

# Considerações

Independentemente do servidor web utilizado, procuro sempre priorizar:

- Segurança
- Performance
- Simplicidade
- Facilidade de manutenção
- Monitoramento

A configuração apresentada representa uma base para ambientes WordPress hospedados em produção e pode ser expandida conforme as necessidades do ambiente.