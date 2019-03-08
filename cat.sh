#!/bin/bash
# github.com/mamutal91

# Este script é capaz de ler, no manifest XML, apenas o nome do PATH, ou do REPOSITÓRIO.
# A melhor forma de rodar ele, é gerando um arquivo como LOG
# Exemplo:
# ./cat.sh >> kraken.txt
# Edite o echo dentro da função, para o que deseja mostrar.

xml=manifest/snippets/kraken.xml

name=($(awk -F '"' '/project path/{print $4}' $xml))
path=($(awk -F '"' '/project path/{print $2}' $xml))

blacklist=()

function cat(){
	for (( i = j = 0; i < ${#path[@]}, j < ${#name[@]}; i++, j++ )); do
		if ! printf '%s\n' "${blacklist[@]}" | grep -Eqw "${name[j]}"
		then
			echo "${path[i]}"
			echo "${name[j]}"
		fi
	done
}

cat
