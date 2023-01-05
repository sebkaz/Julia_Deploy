# pull latest julia image
FROM julia:latest

# set up the app
WORKDIR /home/app
COPY . /home/app


# instantiate Julia packages
RUN julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate(); Pkg.precompile(); "

# ports
EXPOSE 8000

# set up app environment
# ENV JULIA_DEPOT_PATH "/home/.julia"
# ENV GENIE_ENV "dev"
# ENV GENIE_HOST "0.0.0.0"
# ENV PORT "8000"
# ENV WSPORT "8000"
# ENV EARLYBIND "true"

# run app
CMD ["julia", "regression.jl"]

# or maybe include a Julia file
#CMD julia -e 'using Pkg; Pkg.activate("."); include("app.jl"); '
