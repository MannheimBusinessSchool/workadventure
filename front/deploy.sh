#!/usr/bin/env bash

set -e

echo -n "Please enter root domain [campusadventure.de]: "
read -r;
if [ -z "$REPLY" ]; then
  DOMAIN="campusadventure.de";
else
  DOMAIN="$REPLY"
fi

echo -n "Please enter turn password: "
read -r;
if [ -z "$REPLY" ]; then
  exit 1
else
  TURN_PASSWORD="$REPLY"
fi

echo -n "Please enter target bucket name [spaces-front]: "
read -r;
if [ -z "$REPLY" ]; then
  TARGET_BUCKET="spaces-front"
else
  TARGET_BUCKET="$REPLY"
fi

export PUSHER_URL="pusher.$DOMAIN"
export UPLOADER_URL="uploader.$DOMAIN"
export JITSI_URL="meet.$DOMAIN"
export STUN_URL="stun.$DOMAIN"
export TURN_URL="turn.$DOMAIN"
export TURN_USER="turnuser"
export TURN_PASSWORD="$TURN_PASSWORD"

export JITSI_PRIVATE_MODE="true"

yarn install

yarn templater

yarn build

aws s3 sync dist "s3://$TARGET_BUCKET"
