ORIGINDIR=$PWD
BASEDIR=$(dirname $0)

cd $BASEDIR

echo "Replace template files"
for filename in $(find . -name \*.tmpl); do
    python ../application-exemple/build/replacer/replacer2.py configuration.env $filename
done

for filename in $(find . -name \*.tmpl); do
    rm -f $filename
done

for filename in $(find . -name \*.sh); do
    chmod u+x $filename
done