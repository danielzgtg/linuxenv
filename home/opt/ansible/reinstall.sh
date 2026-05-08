#!/bin/bash
set -e
eatmydata rm -rf venv ansible* ~/bin/ansible*
eatmydata python3 -m venv venv
. venv/bin/activate
eatmydata pip3 install ansible
for x in $(cd venv/bin; ls -1 ansible*); do
echo "#!/bin/bash
set -e
. ~/opt/ansible/venv/bin/activate
exec ~/opt/ansible/venv/bin/$x "'"$@"' > "$x"
chmod 700 "$x"
ln -s '../opt/ansible/'"$x" ~/bin/"$x"
done
pip freeze
exec sync
