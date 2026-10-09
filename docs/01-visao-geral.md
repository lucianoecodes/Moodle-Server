# 1. Visão Geral do Servidor

## Descrição

Este servidor hospeda o **LMS Moodle** da equipe de treinamento (**Security Awareness**). A infraestrutura utiliza **Oracle Linux** com **Docker** para orquestrar a aplicação Moodle e o banco de dados **MariaDB**, configurados via `docker-compose`.

O acesso é feito via **HTTPS** no domínio:

> 🔗 **`https://learning.test.local`**

## Componentes principais

| Componente | Detalhe |
|------------|---------|
| **Aplicação** | Moodle (imagem `elestio/moodle:latest`) |
| **Banco de dados** | MariaDB 10.11 |
| **Orquestração** | Docker Compose |
| **Sistema operacional** | Oracle Linux Server 9.8 |
| **Acesso** | HTTPS (porta 443) |

## Continuar

- [Voltar ao índice](../README.md)
- [Próximo: Sistema Operacional](02-sistema-operacional.md)
