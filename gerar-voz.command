#!/bin/bash
# Gera o MP3 de boas-vindas do Nexo usando a voz Luciana (pt-BR) do macOS
# Basta dar 2 cliques nesse arquivo no Finder.

cd "$(dirname "$0")"

TEXTO="Olá! Eu sou o Nexo, seu assistente pessoal de última geração."

echo "🎙️  Gerando voz Luciana..."

# 1. macOS say → AIFF (nativo, sem depender de ffmpeg)
say -v "Luciana" -r 180 -o welcome.aiff "$TEXTO"

# 2. Converte AIFF → AAC/M4A (ferramenta nativa do macOS, não precisa instalar nada)
afconvert -f m4af -d aac welcome.aiff welcome.m4a

# 3. Remove o AIFF temporário
rm -f welcome.aiff

if [ -f welcome.m4a ]; then
  SIZE=$(du -h welcome.m4a | cut -f1)
  echo "✅ Pronto! welcome.m4a criado ($SIZE)"
  echo ""
  echo "Tocando preview... (você vai ouvir agora)"
  afplay welcome.m4a
  echo ""
  echo "🚀 Próximo passo: subir welcome.m4a junto com o index.html no GitHub."
else
  echo "❌ Erro ao gerar o arquivo."
  exit 1
fi

read -p "Pressione Enter para fechar..."
