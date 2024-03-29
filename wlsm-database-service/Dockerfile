FROM postgres:15

COPY . /docker-entrypoint-initdb.d

COPY ./multiple /docker-entrypoint-initdb.d/multiple

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_MULTIPLE_DATABASES=wlsm

EXPOSE 5432
