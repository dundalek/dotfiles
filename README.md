# dotfiles

```
sudo apt install stow
```

```
cd
git clone git@github.com:dundalek/dotfiles.git

# make sure to create these folders first otherwise they will get symlinked and junk will appear in the dotfiles
mkdir .atom bin .config/fish .clojure

cd ~/dotfiles
stow bash
stow closh
...
```


## Ideas for future

Try git in home directory without stow:
https://drewdevault.com/2019/12/30/dotfiles.html


- User docker to setup the environment
  - https://bergie.iki.fi/blog/docker-developer-shell/
  - http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
