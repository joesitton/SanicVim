#!/bin/bash

docker run --rm -it --name sanicvim alpine sh -c '
  sed -i s/https/http/g /etc/apk/repositories
  apk add --no-cache git neovim
  git clone https://github.com/joesitton/sanicvim ~/.config/nvim
  nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
  nvim
  '
