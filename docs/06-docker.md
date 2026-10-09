# 6. Docker (Versões, Containers, Volumes)

## Versões

| Componente | Versão |
|------------|--------|
| **Docker Engine** | 29.8.0 |
| **Docker Compose** | v5.5.1 |

## Containers

| Container | Imagem | Portas |
|-----------|--------|--------|
| `moodle-app-moodle-1` | `elestio/moodle:latest` | 80, 443 (publicadas) |
| `moodle-app-database-1` | `mariadb:10.11` | 3306 (interna) |

## Volumes Docker

| Volume | Conteúdo |
|--------|----------|
| `moodle-app_db_data` | Dados do banco MariaDB |
| `moodle-app_moodle_data` | Código do Moodle (`/var/www/html`) |
| `moodle-app_moodledata_uploads` | Dados de upload (`/var/www/moodledata`) |

## Arquivo de composição

| Item | Local |
|------|-------|
| **Compose file** | `/var/lib/docker/moodle-app/docker-compose.yml` |
| **Backup do compose** | `/root/docker-compose.yml.bak` |

## Continuar

- [Anterior: Rede](05-rede.md)
- [Próximo: Stack Moodle](07-stack-moodle.md)
