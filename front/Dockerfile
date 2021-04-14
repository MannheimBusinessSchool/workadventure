FROM thecodingmachine/workadventure-back-base:latest as message-builder
WORKDIR /var/www/messages
COPY --chown=docker:docker messages .
RUN yarn install && yarn proto

# we are rebuilding on each deploy to cope with the PUSHER_URL environment URL
FROM node:15-stretch

COPY --chown=docker:docker front .
COPY --from=message-builder --chown=docker:docker /var/www/messages/generated ./src/Messages/generated

# Removing the iframe.html file from the final image as this adds a XSS attack.
# iframe.html is only in dev mode to circumvent a limitation
RUN rm dist/iframe.html

RUN yarn install

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
RUN ./aws/install && aws --version

RUN chmod +x ./build.sh

ENV NODE_ENV=production
CMD ["./build.sh"]
