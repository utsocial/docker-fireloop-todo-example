FROM node:4.3.2

RUN useradd --user-group --create-home --shell /bin/false app 
RUN npm install --global npm@3.7.5
RUN npm install -g @mean-expert/fireloop@1.0.0-beta.1.3

ENV HOME=/home/app

COPY package.json npm-shrinkwrap.json $HOME/poc/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/poc
RUN npm install

USER root
COPY . $HOME/poc
RUN chown -R app:app $HOME/*
USER app

CMD ["node", "index.js"]
