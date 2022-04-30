FROM alpine:3.8 as builder

WORKDIR /tmp

# Install dependencies for vim compiling
RUN apk add --no-cache \
  build-base \
  ctags \
  git \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  make \
  ncurses-dev

# Compile vim from github repository
RUN git clone https://github.com/vim/vim && cd vim \
  && ./configure \
  --disable-gui \
  --enable-multibyte \
  --with-features=huge \
  --with-compiledby=renan.zelli@gmail.com \
  && make install


# Use a new image to ignore compiling dependencies
FROM alpine:3.8

# Copy vim files from previous image
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/share/vim  /usr/local/share/vim
RUN apk add --update --no-cache \
  libice \
  libsm \
  libx11 \
  libxt \
  ncurses \
  python3 \
  perl \
  ruby

# Install utilitaries
RUN apk add --update --no-cache \
  git \
  bash \
  ctags \
  fzf \
  the_silver_searcher

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Configure user
ARG USERNAME=renan
ARG GROUPNAME=renan
ARG WORKSPACE=/home/renan
ARG UID=1000
ARG GID=1000
ARG SHELL=/bin/bash

RUN apk add --no-cache sudo \
  && mkdir -p "${WORKSPACE}" \
  && echo "${USERNAME}:x:${UID}:${GID}:${USERNAME},,,:${WORKSPACE}:${SHELL}" \
  >> /etc/passwd \
  && echo "${USERNAME}::17032:0:99999:7:::" \
  >> /etc/shadow \
  && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" \
  > "/etc/sudoers.d/${USERNAME}" \
  && chmod 0440 "/etc/sudoers.d/${USERNAME}" \
  && echo "${GROUPNAME}:x:${GID}:${USERNAME}" >> /etc/group \
  && chown "${UID}":"${GID}" "${WORKSPACE}"

# Set default workdir and user
WORKDIR $WORKSPACE
USER $USERNAME
ENV VIMINIT="source /tmp/.vim/vimrc"

#Copy configurations to the container
COPY plug.vim /tmp/.vim/autoload/plug.vim
COPY plugged /tmp/.vim/plugged/
COPY .vimrc /tmp/.vim/vimrc

#Change permission to allow config files update
RUN sudo chown -R "${UID}":"${GID}" /tmp

ENTRYPOINT ["vim"]
