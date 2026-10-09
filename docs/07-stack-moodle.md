# 7. Stack Moodle (Docker Compose + Bind Mounts HTTPS)

## Visão geral

A stack é gerenciada pelo **docker-compose** no arquivo `docker-compose.yml`, localizado em:

> **`/var/lib/docker/moodle-app/docker-compose.yml`**

### Serviços

| Serviço | Imagem | Função |
|---------|--------|--------|
| `database` | `mariadb:10.11` | Banco de dados |
| `moodle` | `elestio/moodle:latest` | Aplicação Moodle |

### Parâmetros principais

- **MOODLE_URL**: `https://learning.test.local`
- **Portas publicadas**: `80` e `443`

## Bind mounts persistentes (HTTPS)

Para que a configuração HTTPS sobreviva a recriações do container, os seguintes **bind mounts** são definidos (todos sob `/var/lib/docker/moodle-app/`):

| Pasta no host | Montado em | Conteúdo |
|---------------|------------|----------|
| `ssl/` | `/etc/apache2/ssl` | Certificados |
| `apache2-sites/` | `/etc/apache2/sites-available` | VHosts 443 e redirect 80 |
| `apache2-sites-enabled/` | `/etc/apache2/sites-enabled` | Symlinks de ativação |
| `apache2-mods/` | `/etc/apache2/mods-enabled` | Módulos (inclui mod_ssl) |

> 💡 Veja um exemplo sanitizado do arquivo em [`deploy/docker-compose.yml`](../deploy/docker-compose.yml).

## Continuar

- [Anterior: Docker](06-docker.md)
- [Próximo: Configuração HTTPS / Certificado](08-https-certificado.md)
