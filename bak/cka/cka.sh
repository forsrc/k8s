
################ kubectl completion bash

yum install bash-completion -y
source /usr/share/bash-completion/bash_completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source <(kubectl completion bash)

################

