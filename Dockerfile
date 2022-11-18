FROM julia:1.8.2

LABEL maintainer="Sebastian Zajac <sebastian.zajac@sgh.waw.pl>"
LABEL description="Simpy Web App with ML model"

RUN mkdir /app

WORKDIR /app

COPY app.jl install.jl model.bson .


# install all packages 
Run julia install.jl

EXPOSE 8000

CMD ["julia", "app.jl"]
