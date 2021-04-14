FROM thecodingmachine/nodejs:12-apache

COPY --chown=docker:docker . .
ENV APACHE_DOCUMENT_ROOT=maps/
RUN sudo a2enmod headers
