#!/bin/bash
# deploy.sh â€” Sincroniza arquivos locais com o bucket S3

BUCKET=$1

if [ -z "$BUCKET" ]; then
  echo "Uso: bash deploy.sh NOME-DO-BUCKET"
  exit 1
fi

echo "Sincronizando arquivos com s3://$BUCKET..."
aws s3 sync ./site/ s3://$BUCKET/ --delete

echo "Deploy concluido com sucesso!"
echo "URL do site: http://$BUCKET.s3-website-us-east-1.amazonaws.com"
