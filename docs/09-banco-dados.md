# 9. Banco de Dados

## Detalhes do SGBD

| Item | Valor |
|------|-------|
| **SGBD** | MariaDB 10.11 |
| **Container** | `moodle-app-database-1` |
| **Banco** | `moodle` |
| **Usuário** | `moodle_user` |
| **Prefixo das tabelas** | `mdl_` |
| **Volume persistente** | `moodle-app_db_data` |

## Acesso via linha de comando

Dentro do container do banco:

```bash
docker exec -it moodle-app-database-1 mysql -u moodle_user -p moodle
```

> A senha do usuário `moodle_user` está documentada em [credenciais](10-credenciais.md).

## Principais tabelas de interesse

| Tabela | Conteúdo |
|--------|----------|
| `mdl_user` | Usuários da plataforma |
| `mdl_course` | Cursos |
| `mdl_course_categories` | Categorias de cursos |
| `mdl_scorm` | Atividades SCORM |
| `mdl_config` | Configurações globais |
| `mdl_config_plugins` | Configurações de plugins (ex.: LDAP) |

## Continuar

- [Anterior: HTTPS / Certificado](08-https-certificado.md)
- [Próximo: Usuários e Credenciais](10-credenciais.md)
