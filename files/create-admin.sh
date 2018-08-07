#!/bin/bash

V_NOME=$1
V_CPF=$2
V_EMAIL=$3

if [[ -z $V_NOME || -z $V_CPF || -z $V_EMAIL ]]; then
    echo "ERROR: O comando deve ser utilizado como abaixo:"
    echo "create-admin 'NOME DO USUARIO' 'CPF' 'EMAIL'"
    echo ""
    exit 1
fi

# Perfis
# 1. Comitê
# 2. Subcomitê
# 3. Núcleo (Administrador)
# 4. Unidade
# 5. Gestor do Processo
# 6. Analista de Risco
V_PERFIL=3

psql -U $DB_USER -h $DB_HOST $DB_NAME -c "INSERT INTO gestaoriscos.tb_usuario VALUES (nextval('gestaoriscos.sk_usuario'), '$V_NOME', '$V_CPF', null, '$V_EMAIL');"
psql -U $DB_USER -h $DB_HOST $DB_NAME -c "INSERT INTO gestaoriscos.tb_permissao VALUES (nextval('gestaoriscos.sk_permissao'), nextval('gestaoriscos.sk_usuario')-1, $V_PERFIL , false, current_timestamp);"
