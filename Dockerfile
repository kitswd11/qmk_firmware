FROM base/archlinux:latest
MAINTAINER Yoshi Yamaguchi ymotongpoo

RUN pacman-key --init && pacman-key --populate archlinux && pacman-key --refresh-keys
RUN pacman -Syyu --needed --noconfirm
RUN pacman-db-upgrade
RUN pacman -S --needed --noconfirm \
  base-devel \
  avr-gcc \
  avr-binutils \
  avr-libc \
  dfu-util \
  git
RUN mkdir /home/ergodox 
RUN useradd -s /bin/bash ergodox
RUN chown ergodox /home/ergodox
RUN echo 'ergodox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ergodox
WORKDIR /home/ergodox
RUN git clone https://github.com/ymotongpoo/qmk_firmware.git
WORKDIR /home/ergodox/qmk_firmware/keyboard/ergodox_ez