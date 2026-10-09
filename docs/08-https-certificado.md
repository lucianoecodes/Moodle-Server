# 8. Configuração HTTPS / Certificado

## Certificado

| Item | Valor |
|------|-------|
| **Tipo** | Wildcard `*.local.com` |
| **Autoridade** | Thawte TLS RSA CA G1 (DigiCert) |
| **Validade** | 23/01/2026 a 23/02/2027 |
| **Arquivo (bundle)** | `/var/lib/docker/moodle-app/ssl/star_local_com.pem` |
| **Chave** | `.../ssl/star_local_com.key` |

> O `.pem` é o **bundle** (certificado + cadeia).

## VHosts

| VHost | Porta | Função |
|-------|-------|--------|
| `moodle-ssl.conf` | 443 | Serve o Moodle via HTTPS |
| `redirect-https.conf` | 80 | Redireciona HTTP → HTTPS |

Os modelos estão disponíveis em [`config/`](../config/).

## Configuração do Moodle (config.php)

- **wwwroot**: `$CFG->wwwroot = 'https://learning.test.local'`
- **sslproxy**: `$CFG->sslproxy = true;`

> ⚠️ Sem `sslproxy=true`, o Moodle gera URLs em `http://` por trás do proxy HTTPS e entra em loop de redirecionamento.

## DocumentRoot

O `DocumentRoot` do Moodle é **`/var/www/html/public`** (exigência da imagem Elestio).

> Se apontar para `/var/www/html`, o Moodle bloqueia com: *"O diretório raiz do Moodle não deve ser publicamente acessível. Use /public"*.

## Continuar

- [Anterior: Stack Moodle](07-stack-moodle.md)
- [Próximo: Banco de Dados](09-banco-dados.md)
