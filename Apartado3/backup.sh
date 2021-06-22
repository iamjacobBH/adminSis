#script de respaldo de archivos
archivo="resp$( date +'%d%m%y%H%M' )"
tar -czvf "${archivo}.tar.gz" $1
echo "Respaldo terminado"
mv "${archivo}.tar.gz" $2