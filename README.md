# Julia_Deploy
ML model deploy in Julia 

### build image
```bash
docker build -t API_ML_Julia .
```
### run image
```bash
docker run -p 8000:8000 API_ML_Julia
```

### first check 
```bash
julia request.jl
```

GO to Web browser: 
```bash
localhost:8000/send 
```
or by GET method
```bash
localhost:800/api_one?data=1250
```
