# Pergunta 1 - Linux e Troubleshooting

# Cenário

Um cliente informa que seu site apresenta lentidão e, eventualmente, retorna erro **HTTP 502 (Bad Gateway)**. Não existe histórico recente de alterações e o ambiente é composto por **Nginx + PHP-FPM**.

Antes de realizar qualquer intervenção, minha prioridade é identificar a camada onde a falha está ocorrendo, evitando mudanças desnecessárias e reduzindo o risco de ampliar o impacto do incidente.

Minha metodologia de troubleshooting é baseada em isolamento de camadas e análise de evidências.

---

# Estratégia de investigação

A sequência normalmente utilizada é:

1. Confirmar o sintoma reportado pelo cliente.
2. Validar a disponibilidade dos serviços.
3. Analisar logs da aplicação e do sistema.
4. Verificar consumo de recursos.
5. Validar conectividade entre os componentes.
6. Identificar a causa raiz.
7. Aplicar a correção.
8. Validar o funcionamento após a intervenção.
9. Documentar o incidente e propor ações preventivas.

---

# 1. Validar os serviços

Primeiro verifico se os serviços responsáveis pela aplicação estão ativos.

```bash
systemctl status nginx
systemctl status php-fpm
```

Em distribuições onde o serviço possui versão específica:

```bash
systemctl status php8.2-fpm
```

Caso algum serviço esteja parado, analiso o motivo antes de reiniciá-lo.

---

# 2. Validar a configuração do Nginx

Antes de qualquer reload ou restart, valido a configuração.

```bash
nginx -t
```

Essa prática evita indisponibilidade causada por erros de sintaxe ou diretivas inválidas.

---

# 3. Analisar logs

Os logs normalmente fornecem a causa mais precisa do problema.

Logs do Nginx:

```bash
tail -100 /var/log/nginx/error.log
tail -100 /var/log/nginx/access.log
```

Logs do PHP-FPM:

```bash
journalctl -u php-fpm -n 100
```

ou

```bash
tail -100 /var/log/php8.2-fpm.log
```

Também consulto o Journal do sistema:

```bash
journalctl -xe
```

Procuro principalmente por:

- upstream timed out
- connection refused
- segmentation fault
- out of memory
- permission denied

---

# 4. Verificar utilização de recursos

Problemas de infraestrutura frequentemente estão relacionados à saturação de recursos.

CPU

```bash
top
```

ou

```bash
htop
```

Memória

```bash
free -h
```

Disco

```bash
df -h
```

Uso por diretório

```bash
du -sh /*
```

I/O

```bash
iostat -x 1
```

Também verifico se o OOM Killer encerrou algum processo.

```bash
dmesg | grep -i oom
```

---

# 5. Verificar conectividade

Caso exista balanceador, banco de dados ou outro backend, valido a comunicação.

```bash
ping servidor
```

```bash
curl -I http://localhost
```

```bash
curl -v http://localhost
```

Portas abertas

```bash
ss -tulpn
```

Sockets UNIX

```bash
ss -xlp
```

---

# Possíveis causas do erro HTTP 502

## PHP-FPM indisponível

O Nginx está ativo, porém não consegue encaminhar requisições ao backend.

Validação:

```bash
systemctl status php-fpm
```

---

## Socket incorreto

O Nginx referencia um socket diferente do utilizado pelo PHP-FPM.

Exemplo:

```nginx
fastcgi_pass unix:/run/php/php8.1-fpm.sock;
```

Enquanto o PHP-FPM utiliza:

```text
/run/php/php8.2-fpm.sock
```

Validação:

```bash
ss -xlp
```

```bash
grep fastcgi_pass /etc/nginx/sites-enabled/*
```

---

## Timeout da aplicação

A aplicação demora mais do que o tempo configurado.

Nos logs normalmente aparecem mensagens semelhantes a:

```text
upstream timed out
```

Nessa situação investigo:

- aplicação
- consultas ao banco
- APIs externas
- cache
- recursos do servidor

---

## Falta de recursos

Também é comum encontrar:

- memória insuficiente
- swap excessiva
- disco cheio
- alta utilização de CPU
- gargalos de I/O

Esses problemas podem afetar tanto o Nginx quanto o PHP-FPM.

---

# Como diferencio a origem do problema

## Infraestrutura

Indícios:

- CPU elevada
- memória insuficiente
- disco cheio
- erros de hardware
- saturação de I/O

---

## Nginx

Indícios:

- erro de configuração
- serviço parado
- falha em nginx -t

---

## PHP-FPM

Indícios:

- workers indisponíveis
- falhas de inicialização
- socket inexistente
- limite de processos atingido

---

## Aplicação

Indícios:

- exceções PHP
- consultas lentas ao banco
- timeout
- erros internos

---

## Rede

Indícios:

- DNS incorreto
- firewall
- perda de conectividade
- latência elevada

---

# Boas práticas

Durante qualquer incidente procuro evitar alterações imediatas sem evidências.

Minha prioridade é:

- preservar logs;
- identificar a causa raiz;
- minimizar impacto ao cliente;
- validar a solução antes de finalizar o atendimento;
- documentar o ocorrido;
- propor melhorias para evitar recorrência.

Essa abordagem reduz retrabalho, aumenta a confiabilidade da resolução e facilita futuras investigações.

---

# Conclusão

Em ambientes de produção, troubleshooting eficiente depende muito mais de método do que de tentativa e erro.

Minha abordagem consiste em coletar evidências, isolar a camada afetada e somente então realizar alterações no ambiente.

Dessa forma consigo reduzir o tempo de indisponibilidade, aumentar a previsibilidade das intervenções e garantir maior estabilidade dos serviços.